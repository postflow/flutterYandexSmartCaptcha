//https://cloud.yandex.ru/docs/smartcaptcha/concepts/widget-methods#methods

final class WebPageCaptchaContent {
  String _siteKey;
  bool _testMode;
  String _languageCaptcha;
  bool _invisible;
  bool _hideShield;
  bool _isWebView;

  late String yandexSmartCaptchaWebContent;

  WebPageCaptchaContent({required String siteKey,
    bool testMode = false,
    String languageCaptcha = 'ru', //'ru' | 'en' | 'be' | 'kk' | 'tt' | 'uk' | 'uz' | 'tr';
    bool invisible = false,
    bool hideShield = false,
    bool isWebView = true
  }) : _isWebView = isWebView, _hideShield = hideShield, _invisible = invisible, _languageCaptcha = languageCaptcha, _testMode = testMode, _siteKey = siteKey {

    yandexSmartCaptchaWebContent = '''
            <!doctype html>
            <html lang="ru">
            <head>
              <meta charset="utf-8" />
              <meta name="viewport" content="width=device-width, initial-scale=1">
              <title></title>
               <script src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onLoadFunction" defer></script>
            </head>
            <body>
            <script>
              function onLoadFunction() {
                  if (window.smartCaptcha) {
                      const widgetId = window.smartCaptcha.render('captcha-container', {
                          sitekey: '$_siteKey',
                          invisible: $_invisible,
                          hideShield: $_hideShield,
                          hl: '$_languageCaptcha',
                          test: $_testMode,
                          webview: $_isWebView,
                          // callback: resultCallback
                      });
              
                      window.smartCaptcha.subscribe(
                          widgetId,
                          'challenge-visible',
                          () => { window.flutter_inappwebview.callHandler('challengeVisibleEvent'); }
                      );
              
                      window.smartCaptcha.subscribe(
                          widgetId,
                          'challenge-hidden',
                          () => { window.flutter_inappwebview.callHandler('challengeHiddenEvent'); }
                      );
                      
                      
                      
                       window.smartCaptcha.subscribe(
                          widgetId,
                          'network-error',
                          () => { window.flutter_inappwebview.callHandler('networkErrorEvent'); }
                      );
                      
                       window.smartCaptcha.subscribe(
                          widgetId,
                          'success',
                          (token) => { window.flutter_inappwebview.callHandler('tokenHandler'); }
                      );
                  }
              }
              
              // function resultCallback(token) {
              //     window.flutter_inappwebview.callHandler('tokenHandler');
              // }
              
            </script>
                <div id="captcha-container" style="height: 100px"></div>
            </body>
            </html>
    ''';
  }
}
