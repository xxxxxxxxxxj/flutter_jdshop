import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/services/serchhistory.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SerchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SerchPageState();
  }
}

class _SerchPageState extends State<SerchPage> {
  List<String> _hotTagList = List<String>();
  List<String> _historyList = List<String>();
  String _keywords;

  @override
  void initState() {
    super.initState();
    _hotTagList.add("笔记本");
    _hotTagList.add("电脑");
    _hotTagList.add("手机");
    _hotTagList.add("男装");
    _hotTagList.add("女装");
    _hotTagList.add("裤子");
    _hotTagList.add("鞋子");
    _hotTagList.add("你是猪吗？");
    _getHistoryData();
  }

  void _getHistoryData() async {
    var serchHistory = await SerchHistory.getSerchHistory();
    setState(() {
      this._historyList.clear();
      this._historyList.addAll(serchHistory);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.setHeight(70),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
          child: TextField(
            onChanged: (String value) {
              this._keywords = value;
            },
            style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
            autofocus: true, //自动获取焦点，弹起键盘
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
                Navigator.pushReplacementNamed(context, PageName.route_shoplist,
                    arguments: {"keywords": _keywords});
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
                "搜索",
                style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "热搜",
              style: TextStyle(
                  fontSize: ScreenAdapter.setSp(32), color: Colors.black),
            ),
          ),
          Divider(
            height: ScreenAdapter.setHeight(1),
            color: Colors.black26,
          ),
          //热搜标签
          _getHotTagWidget(),
          _getHistoryColumn(),
        ],
      ),
    );
  }

  _getHistoryColumn() {
    if (ObjectUtil.isNotEmpty(_historyList)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "历史搜索",
              style: TextStyle(
                  fontSize: ScreenAdapter.setSp(32), color: Colors.black),
            ),
          ),
          Divider(
            height: ScreenAdapter.setHeight(1),
            color: Colors.black26,
          ),
          //历史搜索
          _getHistoryWidget(),
          Divider(
            height: ScreenAdapter.setHeight(1),
            color: Colors.black26,
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenAdapter.setWidth(15),
                right: ScreenAdapter.setWidth(15),
                top: ScreenAdapter.setHeight(100),
                bottom: ScreenAdapter.setHeight(100)),
            height: ScreenAdapter.setHeight(90),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 1)),
            child: InkWell(
                onTap: () async {
                  await _showAlertDialog("");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Icon(Icons.delete), Text("清空历史搜索")],
                )),
          ),
        ],
      );
    } else {
      return Text("");
    }
  }

  _getHotTagWidget() {
    return Wrap(
      children: List.generate(_hotTagList.length, (index) {
        return Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.9),
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () async {
                await SerchHistory.addSerchHistory(_hotTagList[index]);
                Navigator.pushReplacementNamed(context, PageName.route_shoplist,
                    arguments: {"keywords": _hotTagList[index]});
              },
              child: Text(
                _hotTagList[index],
                style: TextStyle(fontSize: ScreenAdapter.setSp(24)),
              ),
            ));
      }),
    );
  }

  _getHistoryWidget() {
    return ListView.separated(
        //ListView和GridView嵌套问题，以下两个属性
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, PageName.route_shoplist,
                    arguments: {"keywords": _historyList[index]});
              },
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  height: ScreenAdapter.setHeight(80),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _historyList[index],
                          style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            iconSize: 20,
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _showAlertDialog(_historyList[index]);
                            }),
                      ),
                    ],
                  )));
        },
        // 这里用来定义分割线
        separatorBuilder: (context, index) {
          return Divider(
            height: ScreenAdapter.setHeight(1),
            color: Colors.black26,
          );
        },
        itemCount: _historyList.length);
  }

  _showAlertDialog(value) async {
    var result = await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息!"),
            content: ObjectUtil.isNotEmpty(value)
                ? Text("您确定要删除${value}吗?")
                : Text("您确定要清空搜索历史吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  print("取消");
                  Navigator.pop(context, 'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  if (ObjectUtil.isNotEmpty(value)) {
                    await SerchHistory.removeSerchHistory(value);
                  } else {
                    await SerchHistory.clearSerchHistory();
                  }
                  this._getHistoryData();
                  Navigator.pop(context, "Ok");
                },
              )
            ],
          );
        });
  }
}
