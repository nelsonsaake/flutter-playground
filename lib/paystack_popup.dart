import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_universal/webview_controller/webview_controller_web.dart'
    as web;
import 'package:webview_flutter/webview_flutter.dart' as dsk;
import 'package:webview_universal/widget/webview.dart' as uni;

const _paystackAuthUrl = "https://checkout.paystack.com/bsn2yx6x5b1sgkm";

final _borderRaidus = BorderRadius.circular(12);

Future<Widget> webviewForWeb(BuildContext context) async {
  web.WebViewController webViewController = web.WebViewController();

  await webViewController.init(
    context: context,
    uri: Uri.parse(_paystackAuthUrl),
    setState: (void Function() fn) {},
  );

  return uni.WebView(controller: webViewController);
}

Future<Widget> webviewForDesktop() async {
  dsk.WebViewController controller = dsk.WebViewController()
    // ..setBackgroundColor(const Color(0xFF757D81))
    ..setJavaScriptMode(dsk.JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(_paystackAuthUrl));

  return dsk.WebViewWidget(controller: controller);
}

showPopup(BuildContext context) async {
  Widget webview = const SizedBox.shrink();

  if (kIsWeb) {
    webview = await webviewForWeb(context);
  } else if (Platform.isWindows) {
    webview = await webviewForDesktop();
  }

  // ignore: use_build_context_synchronously
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRaidus,
        ),
        clipBehavior: Clip.hardEdge,
        child: DialogBackground(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: _borderRaidus,
              child: webview,
            ),
          ),
        ),
      );
    },
  );
}

class DialogBackground extends StatelessWidget {
  const DialogBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRaidus,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF757D81),
          borderRadius: _borderRaidus,
          image: const DecorationImage(
            image: AssetImage("assets/images/bg_1_2.jpg"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.compose(
            outer: ImageFilter.blur(
              sigmaX: 0,
              sigmaY: 0,
            ),
            inner: ImageFilter.blur(
              sigmaX: 1.5,
              sigmaY: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: _borderRaidus,
            child: child,
          ),
        ),
      ),
    );
  }
}
