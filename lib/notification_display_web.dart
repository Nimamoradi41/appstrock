import 'dart:js' as js;

void showForegroundNotification(String title, String body) {
  js.context.callMethod('showAppStrokeNotification', [title, body]);
}
