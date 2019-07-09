import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/banner_bean.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerDefault extends StatefulWidget {
  List<BannerBean> _imgList;
  double aspectRatio;

  BannerDefault(this._imgList, this.aspectRatio);

  @override
  State<StatefulWidget> createState() {
    return _BannerDefaultState(_imgList, aspectRatio);
  }
}

class _BannerDefaultState extends State<BannerDefault> {
  List<BannerBean> _imgList;
  double aspectRatio;

  _BannerDefaultState(this._imgList, this.aspectRatio);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              _imgList[index].imgUrl,
              fit: BoxFit.fill,
            );
          },
          itemCount: _imgList.length,
          autoplay: true,
          autoplayDelay: 3000,
          pagination: new SwiperPagination(),
        ),
      ),
    );
  }
}
