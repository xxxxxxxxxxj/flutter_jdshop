import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/util/utils.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _isLogin = false;
  String _userName;
  String _userMemberName;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: ScreenAdapter.setHeight(220),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Utils.getImgPath("user_bg", format: "jpg"),
                  ),
                  fit: BoxFit.cover)),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: ScreenAdapter.setWidth(20),
                    right: ScreenAdapter.setWidth(20)),
                child: InkWell(
                    onTap: () {
                      if (_isLogin) {
                      } else {}
                    },
                    child: ClipOval(
                      child: Image.asset(
                        Utils.getImgPath("user"),
                        fit: BoxFit.cover,
                        width: ScreenAdapter.setWidth(100),
                        height: ScreenAdapter.setHeight(100),
                      ),
                    )),
              ),
              Expanded(
                  flex: 1,
                  child: _isLogin
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "用户名：${Utils.getStr(_userName)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.setSp(30)),
                            ),
                            Divider(
                              height: ScreenAdapter.setHeight(15),
                              color: Colors.transparent,
                            ),
                            Text(
                              "${Utils.getStr(_userMemberName)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenAdapter.setSp(30)),
                            ),
                          ],
                        )
                      : Text(
                          "登录/注册",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenAdapter.setSp(30)),
                        )),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            if (_isLogin) {
            } else {}
          },
          child: ListTile(
            leading: Icon(
              Icons.assignment,
              color: Colors.red,
            ),
            title: Text("全部订单"),
          ),
        ),
        Divider(
          height: ScreenAdapter.setHeight(1),
          color: Colors.black38,
        ),
        InkWell(
            onTap: () {
              if (_isLogin) {
              } else {}
            },
            child: ListTile(
              leading: Icon(
                Icons.payment,
                color: Colors.green,
              ),
              title: Text("待付款"),
            )),
        Divider(
          height: ScreenAdapter.setHeight(1),
          color: Colors.black38,
        ),
        InkWell(
            onTap: () {
              if (_isLogin) {
              } else {}
            },
            child: ListTile(
              leading: Icon(
                Icons.local_car_wash,
                color: Colors.orange,
              ),
              title: Text("待收货"),
            )),
        Container(
            width: double.infinity,
            height: ScreenAdapter.setHeight(20),
            color: Color.fromRGBO(242, 242, 242, 0.9)),
        InkWell(
            onTap: () {
              if (_isLogin) {
              } else {}
            },
            child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: Colors.lightGreen,
              ),
              title: Text("我的收藏"),
            )),
        Divider(
          height: ScreenAdapter.setHeight(1),
          color: Colors.black38,
        ),
        InkWell(
            onTap: () {
              if (_isLogin) {
              } else {}
            },
            child: ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.black54,
              ),
              title: Text("在线客服"),
            )),
        Divider(
          height: ScreenAdapter.setHeight(1),
          color: Colors.black38,
        ),
      ],
    ));
  }

  Future scan() async {
    try {
      String barcode = await scanner.scan();
      LogUtil.e("barcode = ${barcode}");
    } on Exception catch (e) {
      LogUtil.e("错误 = ${e.toString()}");
    }
  }
}
