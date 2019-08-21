import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';

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

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        appBar: AppBar(
          leading:
              IconButton(icon: Icon(Icons.center_focus_weak), onPressed: () {}),
          centerTitle: true,
          title: InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageName.route_serch);
            },
            child: Container(
              height: ScreenAdapter.setHeight(70),
              padding: EdgeInsets.only(left: ScreenAdapter.setWidth(20)),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.8),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    size: 15,
                  ),
                  Text(
                    "笔记本",
                    style: TextStyle(
                        fontSize: ScreenAdapter.setSp(26),
                        color: Colors.black45),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.message), onPressed: () {})
          ],
        ),
        body: Text("我的"));
  }
}
