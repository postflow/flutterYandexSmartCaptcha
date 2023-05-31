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

/// CaptchaConfig:
/// sitekey — ключ клиентской части.
/// languageCaptcha — язык виджета. 'ru' | 'en' | 'be' | 'kk' | 'tt' | 'uk' | 'uz' | 'tr';
/// testMode — включение работы капчи в режиме тестирования. Пользователь всегда будет получать задание. Используйте это свойство только для отладки и тестирования.
/// isWebView — запуск капчи в WebView. Используется для повышения точности оценки пользователей при добавлении капчи в мобильные приложения с помощью WebView.
/// invisible — невидимая капча.
/// hideShield — скрыть блок с уведомлением об обработке данных.
/// colorBackground — цвет фона

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
      testMode: false,
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: YandexSmartCaptcha(
              captchaConfig: captchaConfig,
              onLoadWidget: const Center(
                child: SizedBox.square(
                    dimension: 60,
                    child: CircularProgressIndicator()
                ),
              ),
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
              shouldOpenPolicy: (String urlPolicy) {
                if (urlPolicy.contains('smartcaptcha_notice')) {
                  return false;
                } else {
                  return true;
                }
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
      ),
    );
  }
}
