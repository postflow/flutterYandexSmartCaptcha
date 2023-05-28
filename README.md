# Flutter Yandex SmartCaptcha

## Example:

```Dart
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
  final Controller _controller = Controller();

  @override
  void initState() {
    super.initState();
    captchaConfig = CaptchaConfig(
        siteKey: siteKey,
        testMode: true,
        languageCaptcha: 'ru',
        invisible: false,
        isWebView: true,
        colorBackground: Colors.cyan
    );
    _controller.onReadyCallback(() {
      debugPrint('SmartCaptcha controller is ready');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: YandexSmartCaptcha(
                captchaConfig: captchaConfig,
                controller: _controller,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final bool isReady = _controller.isControllerIsReady();
                      if (isReady) {
                        _controller.execute();
                      }
                    },
                    child: const Text('Execute')),
                ElevatedButton(
                    onPressed: () async {
                      final bool isReady = _controller.isControllerIsReady();
                      if (isReady) {
                        _controller.destroy();
                      }
                    },
                    child: const Text('Destroy'))
              ],
            ),
          )
        ],
      ),
    );
  }
}


```

![image](https://github.com/postflow/flutterYandexSmartCaptcha/blob/master/pic/android_small.png?raw=true)
![image](https://github.com/postflow/flutterYandexSmartCaptcha/blob/master/pic/ios_small.png?raw=true)
