import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/view/progressview_widget.dart';

class NetImage extends StatelessWidget {
  String _imgUrl;

  NetImage(this._imgUrl);

  @override
  Widget build(BuildContext context) {
    if (ObjectUtil.isNotEmpty(_imgUrl)) {
      if (!_imgUrl.startsWith("http://") && !_imgUrl.startsWith("https://")) {
        _imgUrl = ApiConfig.BASE_URL + _imgUrl;
      }
      _imgUrl = _imgUrl.replaceAll('\\', '/');
      return CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: _imgUrl,
        placeholder: (context, url) => new ProgressView(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      );
    } else {
      return Text("");
    }
  }
}
