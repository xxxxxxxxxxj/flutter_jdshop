import 'package:flutter/material.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';

class SerchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SerchPageState();
  }
}

class _SerchPageState extends State<SerchPage> {
  List<String> _hotTagList = List<String>();
  List<String> _historyList = List<String>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _hotTagList.add("笔记本");
      _historyList.add("电脑");
    }
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
            onTap: () {},
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
                left: ScreenAdapter.setWidth(10),
                right: ScreenAdapter.setWidth(10),
                top: ScreenAdapter.setHeight(100),
                bottom: ScreenAdapter.setHeight(100)),
            height: ScreenAdapter.setHeight(100),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 1)),
            child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Icon(Icons.delete), Text("清空历史搜索")],
                )),
          ),
        ],
      ),
    );
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
              onTap: () {},
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
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                height: ScreenAdapter.setHeight(80),
                child: Text(
                  _historyList[index],
                  style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
                ),
              ));
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
}
