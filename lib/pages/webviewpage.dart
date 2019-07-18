import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/res/color.dart';
import 'package:flutter_jdshop/res/strings.dart';
import 'package:flutter_jdshop/res/styles.dart';
import 'package:flutter_jdshop/util/utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  String _title;
  String _url;

  //获取h5页面标题
  Future<String> getWebTitle() async {
    String script = 'window.document.title';
    var title = await _flutterWebviewPlugin.evalJavascript(script);
    setState(() {
      this._title = title;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _url = widget.arguments["url"];
    _title = IntlUtil.getString(context, Ids.loading);
    /**
     * 监听web页加载状态
     */
    _flutterWebviewPlugin.onStateChanged
        .listen((WebViewStateChanged webViewState) async {
      switch (webViewState.type) {
        case WebViewState.finishLoad:
          handleJs();
          getWebTitle();
          break;
        case WebViewState.shouldStart:
          break;
        case WebViewState.startLoad:
          break;
        case WebViewState.abortLoad:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBarWidget(),
      body: WebviewScaffold(
        url: _url,
        scrollBar: false,
        withZoom: false,
      ),
    );
  }

  Widget _getAppBarWidget() {
    return AppBar(
      title: Text(
        _title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () {
          _flutterWebviewPlugin.goBack();
        },
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
                                  IntlUtil.getString(context, Ids.open_browser),
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

  @override
  void dispose() {
    _flutterWebviewPlugin.dispose();
    super.dispose();
  }

  void handleJs() {
    _flutterWebviewPlugin.evalJavascript("abc(${_title}')").then((result) {});
  }
}
