import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/prodcutbean.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/view/netimage_widget.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  String _submitTxt = "结算";
  List<ProductData> _productList = new List<ProductData>();
  bool _allSelect = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _productList.add(new ProductData.name(
          "阿斯顿 v 山东 v 浓缩的女哦收到女说；的 v 浓缩的女哦收到女哦收到 v受到恐怖 v 开始打包 v 开始打包 v",
          "380",
          "http://192.168.0.252/static/avatar/1440747789538_1235.png",
          100,
          false));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: ScreenAdapter.setHeight(100)),
          child: ListView.separated(
              itemBuilder: (context, index) {
                ProductData productData = _productList[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      productData.isSelect = !productData.isSelect;
                      _allSelect = _productList.every((localProductData) {
                        return localProductData.isSelect;
                      });
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: ScreenAdapter.setWidth(15),
                        right: ScreenAdapter.setWidth(15),
                        top: ScreenAdapter.setHeight(15),
                        bottom: ScreenAdapter.setHeight(15)),
                    width: ScreenAdapter.setWidth(750),
                    height: ScreenAdapter.setHeight(210),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                            activeColor: Colors.pink,
                            value: productData.isSelect,
                            onChanged: (value) {}),
                        Container(
                          margin: EdgeInsets.only(
                              right: ScreenAdapter.setWidth(20)),
                          width: ScreenAdapter.setWidth(180),
                          height: ScreenAdapter.setHeight(180),
                          child: NetImage(_productList[index].pic),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  productData.title,
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.setSp(28),
                                      color: Colors.black54),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "¥" + productData.price,
                                        style: TextStyle(
                                            fontSize: ScreenAdapter.setSp(26),
                                            color: Colors.red),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: ScreenAdapter.setWidth(164),
                                        height: ScreenAdapter.setHeight(45),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black26,
                                                width:
                                                    ScreenAdapter.setWidth(1))),
                                        child: Row(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  productData.num--;
                                                });
                                              },
                                              child: Container(
                                                width:
                                                    ScreenAdapter.setWidth(45),
                                                height:
                                                    ScreenAdapter.setHeight(45),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border(
                                                        right: BorderSide(
                                                            color:
                                                                Colors.black26,
                                                            width: ScreenAdapter
                                                                .setWidth(1)))),
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontSize:
                                                          ScreenAdapter.setSp(
                                                              20),
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: ScreenAdapter.setWidth(70),
                                              height:
                                                  ScreenAdapter.setHeight(45),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                      right: BorderSide(
                                                          color: Colors.black26,
                                                          width: ScreenAdapter
                                                              .setWidth(1)))),
                                              child: Text(
                                                "${productData.num}",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.setSp(24),
                                                    color: Colors.black54),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  productData.num++;
                                                });
                                              },
                                              child: Container(
                                                width:
                                                    ScreenAdapter.setWidth(45),
                                                height:
                                                    ScreenAdapter.setHeight(45),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(
                                                      fontSize:
                                                          ScreenAdapter.setSp(
                                                              20),
                                                      color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: ScreenAdapter.setHeight(1),
                  color: Colors.black26,
                );
              },
              itemCount: _productList.length),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          color: Colors.black12,
                          width: ScreenAdapter.setWidth(2)))),
              height: ScreenAdapter.setHeight(100),
              width: ScreenAdapter.setWidth(750),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.red,
                          height: ScreenAdapter.setHeight(100),
                          width: ScreenAdapter.setWidth(200),
                          child: Text(
                            _submitTxt,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdapter.setSp(26)),
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _allSelect = !_allSelect;
                          for (int i = 0; i < _productList.length; i++) {
                            if (_allSelect) {
                              _productList[i].isSelect = true;
                            } else {
                              _productList[i].isSelect = false;
                            }
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: ScreenAdapter.setHeight(100),
                        margin: EdgeInsets.only(
                            left: ScreenAdapter.setWidth(15),
                            right: ScreenAdapter.setWidth(15)),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                                activeColor: Colors.pink,
                                value: _allSelect,
                                onChanged: (value) {}),
                            Text(
                              "全选",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.setSp(28),
                                  color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }
}
