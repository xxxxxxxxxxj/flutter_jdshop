import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/bannerbean.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/view/netimage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BannerWidget extends StatefulWidget {
  List<BannerData> _bannerList;
  double aspectRatio;

  BannerWidget(this._bannerList, this.aspectRatio);

  @override
  State<StatefulWidget> createState() {
    return _BannerWidgetState(_bannerList, aspectRatio);
  }
}

class _BannerWidgetState extends State<BannerWidget> {
  List<BannerData> _bannerList;
  double aspectRatio;

  _BannerWidgetState(this._bannerList, this.aspectRatio);

  @override
  Widget build(BuildContext context) {
    return (_bannerList != null && _bannerList.length > 0)
        ? Container(
            child: AspectRatio(
                aspectRatio: aspectRatio,
                child: Swiper(
                  onTap: (index) {
                    if (ObjectUtil.isNotEmpty(_bannerList[index].url)) {
                      Fluttertoast.showToast(msg: "跳转");
                    } else {
                      Fluttertoast.showToast(msg: "不跳转");
                    }
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return NetImage(_bannerList[index].pic);
                  },
                  itemCount: _bannerList.length,
                  autoplay: true,
                  autoplayDelay: 3000,
                  pagination: new SwiperPagination(),
                )),
          )
        : Text(
            "",
          );
  }
}
