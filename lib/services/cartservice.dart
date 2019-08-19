import 'package:flutter_jdshop/bean/prodcutbean.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/util/sp_util.dart';

class CartService {
  //添加商品到购物车
  static addCart(ProductData productData) async {
    List<ProductData> cartList = new List<ProductData>();
    List<ProductData> list = await SpUtil.getObjList(
        SPKey.key_cartlist, (v) => ProductData.fromJson(v));
    if (ObjectUtil.isNotEmpty(list)) {
      if (!isContains(list, productData.sId)) {
        cartList.add(productData);
      }
      cartList.addAll(list);
    } else {
      cartList.add(productData);
    }
    await SpUtil.putObjectList(SPKey.key_cartlist, cartList);
  }

  //删除一件商品
  static removeCart(ProductData productData) async {
    try {
      List<ProductData> cartList = new List<ProductData>();
      List<ProductData> list = await SpUtil.getObjList(
          SPKey.key_cartlist, (v) => ProductData.fromJson(v));
      cartList.addAll(list);
      cartList.remove(getIndex(cartList, productData.sId));
      await SpUtil.putObjectList(SPKey.key_cartlist, cartList);
    } catch (e) {
      LogUtil.e(e.toString());
    }
  }

  //清空购物车
  static clearCart() async {
    try {
      await SpUtil.remove(SPKey.key_cartlist);
    } catch (e) {
      LogUtil.e(e.toString());
    }
  }

  //获取购物车数据
  static Future<List<ProductData>> getCart() async {
    try {
      List<ProductData> list = await SpUtil.getObjList(
          SPKey.key_cartlist, (v) => ProductData.fromJson(v));
      return list;
    } catch (e) {
      LogUtil.e(e.toString());
      return [];
    }
  }

  static bool isContains(List<ProductData> list, String sId) {
    bool isContains = false;
    for (int i = 0; i < list.length; i++) {
      if (sId == list[i].sId) {
        isContains = true;
        break;
      }
    }
    return isContains;
  }

  static int getIndex(List<ProductData> list, String sId) {
    int index = 0;
    for (int i = 0; i < list.length; i++) {
      if (sId == list[i].sId) {
        index = i;
        break;
      }
    }
    return index;
  }
}
