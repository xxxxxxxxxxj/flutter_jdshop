import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/prodcutbean.dart';
import 'package:flutter_jdshop/event/event.dart';
import 'package:flutter_jdshop/services/cartservice.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/view/emptydata_widget.dart';
import 'package:flutter_jdshop/view/goodsnum_widget.dart';
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
  StreamSubscription<CartNumEvent> actionEventBus;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getCartData();
    actionEventBus = eventBus.on<CartNumEvent>().listen((event) {
      LogUtil.e(event.toString());
      if (event.flag == 2) {
        _productList[event.index].num = event.num;
        CartService.updateCartNum(_productList[event.index], event.num);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    actionEventBus.cancel();
  }

  void _getCartData() async {
    var _cartList = await CartService.getCart();
    LogUtil.e("_cartList = ${_cartList}");
    setState(() {
      this._productList.clear();
      this._productList.addAll(_cartList);
      _allSelect = _productList.every((localProductData) {
        return localProductData.isSelect;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ObjectUtil.isEmpty(_productList)
        ? EmptyDataWidget()
        : Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: ScreenAdapter.setHeight(100)),
                child: ListView.separated(
                    itemBuilder: (_, index) {
                      ProductData productData = _productList[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            productData.isSelect = !productData.isSelect;
                            _allSelect = _productList.every((localProductData) {
                              return localProductData.isSelect;
                            });
                          });
                          CartService.updateCartState(
                              productData, productData.isSelect);
                        },
                        child: Dismissible(
                            key: new Key("${index}"),
                            onDismissed: (direction) async {
                              await CartService.removeCart(productData);
                              //删除
                              Scaffold.of(context).showSnackBar(new SnackBar(
                                  duration: Duration(milliseconds: 1500),
                                  backgroundColor: Colors.red,
                                  content: new Text("删除成功")));
                              _getCartData();
                            },
                            confirmDismiss: (direction) async {
                              return _showAlertDialog(direction);
                            },
                            background: Container(
                              width: ScreenAdapter.setWidth(750),
                              height: ScreenAdapter.setHeight(210),
                              color: Colors.green,
                              // 这里使用 ListTile 因为可以快速设置左右两端的Icon
                              child: ListTile(
                                leading: Icon(
                                  Icons.bookmark,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              width: ScreenAdapter.setWidth(750),
                              height: ScreenAdapter.setHeight(210),
                              color: Colors.red,
                              // 这里使用 ListTile 因为可以快速设置左右两端的Icon
                              child: ListTile(
                                trailing: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: ScreenAdapter.setWidth(15),
                                  right: ScreenAdapter.setWidth(15),
                                  top: ScreenAdapter.setHeight(15),
                                  bottom: ScreenAdapter.setHeight(15)),
                              width: ScreenAdapter.setWidth(750),
                              height: ScreenAdapter.setHeight(210),
                              child: Row(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            productData.title,
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenAdapter.setSp(28),
                                                color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            productData.attr,
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenAdapter.setSp(26),
                                                color: Colors.black),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "¥${productData.price}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          ScreenAdapter.setSp(
                                                              26),
                                                      color: Colors.red),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: GoodsNumWidget(
                                                    2, productData.num, index),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            )),
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
                              CartService.updateCartStateAll(_allSelect);
                            },
                            child: Container(
                              height: ScreenAdapter.setHeight(100),
                              width: ScreenAdapter.setWidth(200),
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

  Future<bool> _showAlertDialog(DismissDirection direction) async {
    String _confirmContent = "";
    if (direction == DismissDirection.endToStart) {
      //删除
      _confirmContent = "您确定要删除吗?";
    } else if (direction == DismissDirection.startToEnd) {
      //收藏
      _confirmContent = "您确定要收藏吗?";
    }
    return await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("提示信息!"),
            content: Text(_confirmContent),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  if (direction == DismissDirection.endToStart) {
                    //删除
                    Navigator.of(context).pop(true);
                  } else if (direction == DismissDirection.startToEnd) {
                    //收藏
                    Scaffold.of(context).showSnackBar(new SnackBar(
                        duration: Duration(milliseconds: 1500),
                        backgroundColor: Colors.green,
                        content: new Text("收藏成功")));
                    Navigator.of(context).pop(false);
                  }
                },
              )
            ],
          );
        });
  }
}
