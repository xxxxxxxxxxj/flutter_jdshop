import 'package:dio/dio.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/prodcutbean.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/res/strings.dart';
import 'package:flutter_jdshop/services/serchhistory.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/util/utils.dart';
import 'package:flutter_jdshop/view/emptydata_widget.dart';
import 'package:flutter_jdshop/view/loading_widget.dart';
import 'package:flutter_jdshop/view/netimage_widget.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopListPage extends StatefulWidget {
  Map arguments;

  ShopListPage({this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _ShopListPageState();
  }
}

class _ShopListPageState extends State<ShopListPage>
    with TickerProviderStateMixin {
  List<Tag> _tags = new List<Tag>();
  TabController _tabController;
  List<String> _titleList = new List<String>();
  List<ProductData> _productList = new List<ProductData>();
  int _tabIndex = 0;
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  int _page = 1;
  int _pageSize = 10;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  bool _isEmpty = false;
  String _cid;
  String _keywords;
  TextEditingController _textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _cid = widget.arguments["cid"];
    _keywords = widget.arguments["keywords"];
    _textEditingController.text = _keywords;
    _tags.add(new Tag(title: "4g", active: false));
    _tags.add(new Tag(title: "热卖", active: false));
    _tags.add(new Tag(title: "新用户专享", active: false));
    _tags.add(new Tag(title: "10086", active: false));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  void _init() {
    _titleList.clear();
    _titleList.add(IntlUtil.getString(context, Ids.titleProductComprehensive));
    _titleList.add(IntlUtil.getString(context, Ids.titleProductSales));
    _titleList.add(IntlUtil.getString(context, Ids.titleProductPrice));
    _titleList.add(IntlUtil.getString(context, Ids.titleProductScreening));
    _tabController = new TabController(length: _titleList.length, vsync: this);
    _tabController.addListener(() {
      _tabIndex = _tabController.index;
      LogUtil.e("_tabIndex = ${_tabIndex}");
      if (_tabIndex == 0) {
      } else if (_tabIndex == 1) {
      } else if (_tabIndex == 2) {
      } else if (_tabIndex == 3) {
        _globalKey.currentState.openEndDrawer();
      }
    });
  }

  void _onRefresh() async {
    _getProductData(1, "");
  }

  void _onLoading() async {
    _getProductData(2, "");
  }

  _getProductData(int _flag, String _sort) async {
    if (_flag == 1) {
      //下拉刷新
      _page = 1;
      _productList.clear();
    }
    String _apiUrl = "";
    if (ObjectUtil.isNotEmpty(_cid)) {
      _apiUrl = ApiConfig.PRODUCT_LIST +
          "?page=${_page}&pageSize=${_pageSize}&cid=${_cid}&sort=${_sort}";
    } else if (ObjectUtil.isNotEmpty(_keywords)) {
      _apiUrl = ApiConfig.PRODUCT_LIST +
          "?page=${_page}&pageSize=${_pageSize}&search=${_keywords}&sort=${_sort}";
    }
    LogUtil.e("_apiUrl = " + _apiUrl);
    var dio = Dio();
    Response response = await dio.get(_apiUrl);
    var productBean = ProductBean.fromJson(response.data);
    print(response.data);
    if (_flag == 1) {
      //下拉刷新
      _refreshController.refreshCompleted();
    } else if (_flag == 2) {
      //上拉加载更多
      _refreshController.loadComplete();
    }
    if (productBean.result.length >= _pageSize) {
      _page++;
    } else {
      _refreshController.loadNoData();
    }
    setState(() {
      _productList.addAll(productBean.result);
    });
    if (_page == 1 && _productList.length <= 0) {
      setState(() {
        _isEmpty = true;
      });
    } else {
      setState(() {
        _isEmpty = false;
      });
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.setHeight(70),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
          child: TextField(
            controller: _textEditingController,
            onChanged: (String value) {
              setState(() {
                this._keywords = value;
              });
            },
            style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
            autofocus: false,
            //自动获取焦点，弹起键盘
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              if (ObjectUtil.isNotEmpty(_keywords)) {
                await SerchHistory.addSerchHistory(_keywords);
                FocusScope.of(context).requestFocus(FocusNode());
                _onRefresh();
              } else {
                Fluttertoast.showToast(msg: "请输入搜索关键字");
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: ScreenAdapter.setWidth(40),
                  right: ScreenAdapter.setWidth(40)),
              alignment: Alignment.center,
              child: Text(
                IntlUtil.getString(context, Ids.serch),
                style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
              ),
            ),
          )
        ],
      ),
      endDrawer: Drawer(
        child: Container(),
      ),
      body: Stack(
        children: <Widget>[
          _getIndicatorWidget(),
          _getListViewWidget(),
        ],
      ),
    );
  }

  _getIndicatorWidget() {
    return Container(
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.setHeight(98),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  //设置边框
                  color: Color.fromRGBO(233, 233, 233, 0.9),
                  width: ScreenAdapter.setWidth(2)))),
      child: TabBar(
        controller: _tabController,
        labelStyle: TextStyle(
            //up to your taste
            fontWeight: FontWeight.w700),
        indicatorSize: TabBarIndicatorSize.label,
        //makes it better
        labelColor: Colors.red,
        //Google's sweet blue
        unselectedLabelColor: Color(0xff5f6368),
        //niceish grey
        isScrollable: false,
        //up to your taste
        indicator: MD2Indicator(
            //it begins here
            indicatorHeight: 2,
            indicatorColor: Colors.red,
            indicatorSize:
                MD2IndicatorSize.tiny //3 different modes tiny-normal-full
            ),
        tabs: _getTabViewWidget(),
      ),
    );
  }

  List<Widget> _getTabViewWidget() {
    List<Widget> _tabList = new List<Widget>();
    for (int i = 0; i < _titleList.length; i++) {
      _tabList.add(new Tab(text: _titleList[i]));
    }
    return _tabList;
  }

  Widget _getListViewWidget() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.getScreenHeight(),
      margin: EdgeInsets.only(top: ScreenAdapter.setHeight(98)),
      child: _isEmpty
          ? EmptyDataWidget()
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = LoadingWidget();
                  } else if (mode == LoadStatus.loading) {
                    body = LoadingWidget();
                  } else if (mode == LoadStatus.failed) {
                    body = Text("Load Failed!Click retry!");
                  } else {
                    body = Text(
                      "--没有数据啦--",
                      style: TextStyle(
                          fontSize: ScreenAdapter.setSp(30),
                          color: Colors.black26),
                    );
                  }
                  return Container(
                    width: ScreenAdapter.getScreenWidth(),
                    alignment: Alignment.center,
                    height: ScreenAdapter.setHeight(50),
                    child: Center(child: body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PageName.route_gooddetail,
                            arguments: {"id": _productList[index].sId});
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdapter.setWidth(20),
                            ScreenAdapter.setHeight(20),
                            ScreenAdapter.setWidth(20),
                            ScreenAdapter.setHeight(20)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  right: ScreenAdapter.setWidth(20)),
                              width: ScreenAdapter.setWidth(180),
                              height: ScreenAdapter.setHeight(180),
                              child: NetImage(_productList[index].pic),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    Utils.getStr(_productList[index].title),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.setSp(26)),
                                  ),
                                  SelectableTags(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                    color: Colors.white30,
                                    activeColor: Colors.white30,
                                    textColor: Colors.black,
                                    textActiveColor: Colors.black,
                                    alignment: MainAxisAlignment.start,
                                    backgroundContainer: Colors.transparent,
                                    tags: _tags,
                                    fontSize: ScreenAdapter.setSp(20),
                                    columns: 10,
                                    // default 4
                                    symmetry: false,
                                    // default false
                                    onPressed: (tag) => LogUtil.e(tag),
                                  ),
                                  Text(
                                    "¥${Utils.getStr(_productList[index].price)}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.setSp(26),
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  // 这里用来定义分割线
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: ScreenAdapter.setHeight(1),
                      color: Colors.black26,
                    );
                  },
                  itemCount: _productList.length)),
    );
  }
}
