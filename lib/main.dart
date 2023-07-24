import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playground/paystack_popup.dart';
import 'package:webview_win_floating/webview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    WindowsWebViewPlatform.registerWith();
  }
  runApp(const PlaygroundApp());
}

class PlaygroundApp extends StatelessWidget {
  const PlaygroundApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF494949);
    const primaryBackgroundColor = Colors.white;
    return MaterialApp(
      title: 'plg',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: primaryBackgroundColor,
      ),
      home: const PlaygroundView(title: 'plg - paystack'),
    );
  }
}

class PlaygroundView extends StatefulWidget {
  const PlaygroundView({super.key, required this.title});

  final String title;

  @override
  State<PlaygroundView> createState() => _PlaygroundViewState();
}

class _PlaygroundViewState extends State<PlaygroundView> {
  final int _amount = 1000;

  @override
  void initState() {
    super.initState();
  }

  pay(BuildContext context) async {
    showPopup(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Push button to pay with paystack:',
            ),
            Text(
              'Amount: ' r'$' '$_amount',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pay(context),
        tooltip: 'Pay',
        child: const Icon(Icons.attach_money_rounded),
      ),
    );
  }
}
