import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/res/color.dart';
import 'package:flutter_jdshop/res/strings.dart';
import 'package:flutter_jdshop/res/styles.dart';
import 'package:flutter_jdshop/util/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class WebViewPage extends StatefulWidget {
  Map arguments;

  WebViewPage({this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  String _title;
  String _url;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _url = widget.arguments["url"];
    _title = IntlUtil.getString(context, Ids.loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: <Widget>[
          new PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: _onPopSelected,
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        value: "browser",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.language,
                                    color: Colours.gray_66,
                                    size: 22.0,
                                  ),
                                  Gaps.hGap10,
                                  Text(
                                    IntlUtil.getString(
                                        context, Ids.open_browser),
                                    style: TextStyles.listContent,
                                  )
                                ],
                              ),
                            ))),
                    new PopupMenuItem<String>(
                        value: "share",
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            dense: false,
                            title: new Container(
                              alignment: Alignment.center,
                              child: new Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.share,
                                    color: Colours.gray_66,
                                    size: 22.0,
                                  ),
                                  Gaps.hGap10,
                                  Text(
                                    IntlUtil.getString(context, Ids.share),
                                    style: TextStyles.listContent,
                                  )
                                ],
                              ),
                            ))),
                  ])
        ],
      ),
      body: new WebView(
        initialUrl: _url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  void _onPopSelected(String value) {
    switch (value) {
      case "browser":
        Utils.launchInBrowser(_url);
        break;
      case "share":
        Share.share('$_title : $_url');
        break;
      default:
        break;
    }
  }
}
