import 'package:flutter_jdshop/bean/banner_bean.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_jdshop/data/index.dart';

class TabHomeRepository {
  Future<List<BannerData>> getBanner() async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.get, ApiConfig.HOME_TOP_BANNER);
    if (baseResp.code != ApiConfig.SUCCESS_CODE) {
      return new Future.error(baseResp.msg);
    }
    List<BannerData> list;
    if (baseResp.data != null) {
      BannerBean bannerBean = BannerBean.fromJson(baseResp.data);
      list = bannerBean.result;
    }
    return list;
  }
}
