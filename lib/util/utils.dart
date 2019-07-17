import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static JumpTo(BuildContext context, int jumpToPoint, {Map map}) {
    switch (jumpToPoint) {
      case JumpToPoint.webview:
        String url = map["url"];
        if (url.endsWith("apk")) {
          launchInBrowser(url);
        } else {
          Navigator.pushNamed(context, PageName.route_webview, arguments: map);
        }
        break;
      default:
        break;
    }
  }

  static Future<Null> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
