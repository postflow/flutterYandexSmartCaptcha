import 'package:flutter/material.dart';
import 'package:flutter_yandex_smartcaptcha/flutter_yandex_smartcaptcha.dart';


// Get you key from admin panel yandex cloud
String siteKey = const String.fromEnvironment('SITE_KEY');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yandex SmartCaptcha',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final CaptchaConfig captchaConfig;

  @override
  void initState() {
    captchaConfig = CaptchaConfig(
      siteKey: siteKey,
      testMode: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: YandexSmartCaptcha(
            captchaConfig: captchaConfig,
            challengeViewCloseCallback: () {
              debugPrint('call: challengeViewCloseCallback');
            },
            challengeViewOpenCallback: () {
              debugPrint('call: challengeViewOpenCallback');
            },
            networkErrorCallback: () {
              debugPrint('call: networkErrorCallback');
            },
            tokenResultCallback: (String token) {
              debugPrint('call: tokenResultCallback $token');
            },
            shouldOpenPolicy: (Uri uriPolicy) {
              return true;
            },
          )),
        ],
      ),
    );
  }
}
