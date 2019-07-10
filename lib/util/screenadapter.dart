import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static init(context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }

  static setWidth(double value) {
    return ScreenUtil.getInstance().setWidth(value);
  }

  static setHeight(double value) {
    return ScreenUtil.getInstance().setHeight(value);
  }

  static setSp(double fontSize) {
    return ScreenUtil.getInstance().setSp(fontSize);
  }

  static getScreenHeightDp() {
    return ScreenUtil.screenHeightDp;
  }

  static getScreenWidthDp() {
    return ScreenUtil.screenWidthDp;
  }

  static getScreenHeight() {
    return ScreenUtil.screenHeight;
  }

  static getScreenWidth() {
    return ScreenUtil.screenWidth;
  }
}
