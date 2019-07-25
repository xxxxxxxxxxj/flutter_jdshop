import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/util/sp_util.dart';

class SerchHistory {
  //添加搜索历史记录
  static addSerchHistory(String value) async {
    List<String> serchHistoryList = new List<String>();
    List<String> list = await SpUtil.getStringList(SPKey.key_serchhistory);
    if (ObjectUtil.isNotEmpty(list)) {
      var hasValue = list.contains(value);
      if (!hasValue) {
        serchHistoryList.add(value);
      }
      serchHistoryList.addAll(list);
    } else {
      serchHistoryList.add(value);
    }
    await SpUtil.putStringList(SPKey.key_serchhistory, serchHistoryList);
  }

  //删除一条搜索历史记录
  static removeSerchHistory(String value) async {
    try {
      List<String> serchHistoryList = new List<String>();
      List<String> list = await SpUtil.getStringList(SPKey.key_serchhistory);
      serchHistoryList.addAll(list);
      serchHistoryList.remove(value);
      await SpUtil.putStringList(SPKey.key_serchhistory, serchHistoryList);
    } catch (e) {
      LogUtil.e(e.toString());
    }
  }

  //清空搜索历史记录
  static clearSerchHistory() async {
    try {
      await SpUtil.remove(SPKey.key_serchhistory);
    } catch (e) {
      LogUtil.e(e.toString());
    }
  }

  //获取搜索历史记录
  static Future<List<String>> getSerchHistory() async {
    try {
      List<String> serchHistoryList =
          await SpUtil.getStringList(SPKey.key_serchhistory);
      return serchHistoryList;
    } catch (e) {
      LogUtil.e(e.toString());
      return [];
    }
  }
}
