library flutter_yandex_smartcaptcha;

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_yandex_smartcaptcha/src/web_page_content.dart';


export 'package:flutter_yandex_smartcaptcha/flutter_yandex_smartcaptcha.dart';


class CaptchaConfig {
  String siteKey;
  bool testMode;
  String languageCaptcha;
  bool invisible;
  bool hideShield;
  bool isWebView;
  Color background;

  CaptchaConfig({required this.siteKey,
    this.testMode = false,
    this.languageCaptcha = 'ru',
    this.invisible = false,
    this.hideShield = false,
    this.isWebView = true,
    this.background = Colors.transparent
  });

}

class YandexSmartCaptcha extends StatefulWidget {
  final CaptchaConfig captchaConfig;

  const YandexSmartCaptcha({required this.captchaConfig, Key? key}) : super(key: key);

  @override
  State<YandexSmartCaptcha> createState() => _YandexSmartCaptchaState();
}

class _YandexSmartCaptchaState extends State<YandexSmartCaptcha> {

  late final CaptchaConfig _captchaConfig;
  late final WebPageCaptchaContent _webPageCaptchaContent;
  late InAppWebViewController webViewController;



  _YandexSmartCaptchaState(){
    _captchaConfig = widget.captchaConfig;

    _webPageCaptchaContent = WebPageCaptchaContent(
        siteKey: widget.captchaConfig.siteKey,
        testMode: widget.captchaConfig.testMode,
        languageCaptcha: widget.captchaConfig.languageCaptcha,
        invisible: widget.captchaConfig.invisible,
        hideShield: widget.captchaConfig.hideShield,
        isWebView: widget.captchaConfig.isWebView
    );
  }



  final InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        transparentBackground: true,
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,

      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return InAppWebView(

      initialOptions: options,
      initialData: InAppWebViewInitialData(data: _webPageCaptchaContent.yandexSmartCaptchaWebContent),
      androidOnPermissionRequest: (controller, origin, resources) async {
        return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT);
      },

      onConsoleMessage: (controller, consoleMessage) {
        print('consoleMessage = ${consoleMessage.toString()}');
      },


      onWebViewCreated: (InAppWebViewController controller) {
        webViewController = controller;
        controller.addJavaScriptHandler(handlerName: 'tokenHandler', callback: (args) {
          print('args: $args');
        });


        controller.addJavaScriptHandler(handlerName: 'challengeVisibleEvent', callback: (args){
          print('challengeVisibleEvent args: $args');
        });

        controller.addJavaScriptHandler(handlerName: 'challengeHiddenEvent', callback: (args){
          print('challengeHiddenEvent args: $args');
        });

      },
    );
  }
}

