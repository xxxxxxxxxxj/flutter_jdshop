import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_jdshop/util/log_util.dart';

class GoodsDetailSecond extends StatefulWidget {
  String _id;

  GoodsDetailSecond(this._id);

  @override
  State<StatefulWidget> createState() {
    return _GoodsDetailSecondState();
  }
}

class _GoodsDetailSecondState extends State<GoodsDetailSecond>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  int _progress = 0;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrl: ApiConfig.GOODS_DETAIL_WEBVIEW + "?id=" + widget._id,
      onProgressChanged: (InAppWebViewController controller, int progress) {
        LogUtil.e(progress);
        setState(() {
          if (progress == 100) {
            _isLoading = false;
          } else {
            _isLoading = true;
          }
          this._progress = progress;
        });
      },
    );
  }

  Widget _progressBar() {
    print(_progress);
    return SizedBox(
      height: _isLoading ? 2 : 0,
      child: LinearProgressIndicator(
        value: _isLoading ? _progress / 100 : 1,
        backgroundColor: Color(0xfff3f3f3),
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
