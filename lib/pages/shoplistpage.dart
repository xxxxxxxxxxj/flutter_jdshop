import 'package:flutter/material.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/view/netimage.dart';
import 'package:flutter_tags/selectable_tags.dart';

class ShopListPage extends StatefulWidget {
  Map arguments;

  ShopListPage({this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _ShopListPageState();
  }
}

class _ShopListPageState extends State<ShopListPage> {
  List<Tag> _tags = new List<Tag>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _tags.add(new Tag(title: "4g4g4g4g4g4g", active: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("商品列表"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.setWidth(20),
                    ScreenAdapter.setHeight(20),
                    ScreenAdapter.setWidth(20),
                    ScreenAdapter.setHeight(20)),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.only(right: ScreenAdapter.setWidth(20)),
                      width: ScreenAdapter.setWidth(180),
                      height: ScreenAdapter.setHeight(180),
                      child: NetImage(
                          "https://www.itying.com/images/flutter/list2.jpg"),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
                          ),
                          SelectableTags(
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 0),
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
                            "¥3333",
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
          itemCount: 20),
    );
  }
}
