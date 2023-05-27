import 'package:flutter/material.dart';
import 'package:flutter_yandex_smartcaptcha/flutter_yandex_smartcaptcha.dart';


String siteKey = const String.fromEnvironment('SITE_KEY');


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    captchaConfig = CaptchaConfig(siteKey: siteKey, testMode: true, colorBackground: Colors.green );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(child: YandexSmartCaptcha(
            captchaConfig: captchaConfig,
            challengeViewCloseCallback: (){
              print("challengeViewCloseCallback");
            },
            challengeViewOpenCallback: (){
              print("challengeViewOpenCallback");
            },
            networkErrorCallback: (){
              print("networkErrorCallback");
            },

            tokenResultCallback: (String token){
              print("tokenResultCallback $token");
            },

            shouldOpenPolicy: (Uri uriPolicy){
              print('${uriPolicy.toString()}');
              return true;
            },
          )),
        ],
      ),

    );
  }
}
