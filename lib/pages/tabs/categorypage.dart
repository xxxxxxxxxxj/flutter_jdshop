import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/categorybean.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/view/loading_widget.dart';
import 'package:flutter_jdshop/view/netimage_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  List<CategoryData> _leftList;
  List<CategoryData> _rightList;
  int _currentIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLeftData();
  }

  void _getLeftData() async {
    var dio = Dio();
    Response response = await dio.get(ApiConfig.CATEGORY);
    var categoryBean = CategoryBean.fromJson(response.data);
    print(response.data);
    setState(() {
      _leftList = categoryBean.result;
    });
    if (ObjectUtil.isNotEmpty(_leftList)) {
      _getRightData(_leftList[0].sId);
    }
  }

  void _getRightData(String _pid) async {
    var dio = Dio();
    Response response = await dio.get(ApiConfig.CATEGORY + "?pid=${_pid}");
    var categoryBean = CategoryBean.fromJson(response.data);
    print(response.data);
    setState(() {
      _rightList = categoryBean.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Row(
      children: <Widget>[
        _getLeftWidget(),
        _getRightWidget(),
      ],
    );
  }

  _getLeftWidget() {
    if (ObjectUtil.isNotEmpty(_leftList)) {
      return Container(
        width: ScreenAdapter.getScreenWidthDp() / 4,
        height: double.infinity,
        child: ListView.separated(
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                    _getRightData(_leftList[index].sId);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: ScreenAdapter.setHeight(120),
                  width: double.infinity,
                  color: _currentIndex == index
                      ? Color.fromRGBO(240, 246, 246, 0.9)
                      : Colors.white,
                  child: Text(
                    _leftList[index].title,
                    style: TextStyle(fontSize: ScreenAdapter.setSp(28)),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
            // 这里用来定义分割线
            separatorBuilder: (_, index) => Divider(
                  height: ScreenAdapter.setHeight(1),
                  color: Colors.black26,
                ),
            itemCount: _leftList.length),
      );
    } else {
      return LoadingWidget();
    }
  }

  _getRightWidget() {
    if (ObjectUtil.isNotEmpty(_rightList)) {
      return Expanded(
        flex: 1, //全部充满右边
        child: Container(
            color: Color.fromRGBO(240, 246, 246, 0.9),
            padding: EdgeInsets.only(
                left: ScreenAdapter.setWidth(20),
                right: ScreenAdapter.setWidth(20),
                top: ScreenAdapter.setHeight(20),
                bottom: ScreenAdapter.setHeight(20)),
            child: Container(
              padding: EdgeInsets.only(
                  left: ScreenAdapter.setWidth(20),
                  right: ScreenAdapter.setWidth(20),
                  top: ScreenAdapter.setHeight(20),
                  bottom: ScreenAdapter.setHeight(20)),
              color: Colors.white,
              child: GridView.builder(
                  itemCount: _rightList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: ScreenAdapter.setWidth(20),
                      childAspectRatio: 1 / 1.5,
                      crossAxisSpacing: ScreenAdapter.setHeight(20),
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Material(
                        //解决水波纹不显示的问题
                        child: Ink(
                            child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PageName.route_shoplist,
                            arguments: {"cid": _rightList[index].sId});
                      },
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenAdapter.setHeight(20)),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: NetImage(_rightList[index].pic),
                              )),
                          Text(
                            _rightList[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
                          )
                        ],
                      ),
                    )));
                  }),
            )),
      );
    } else {
      return LoadingWidget();
    }
  }
}
