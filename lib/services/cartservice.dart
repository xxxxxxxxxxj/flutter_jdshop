import 'package:flutter_jdshop/bean/prodcutbean.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/util/sp_util.dart';

class CartService {
  //添加商品到购物车
  static Future<bool> addCart(ProductData productData) async {
    bool isAdd = false;
    List<ProductData> cartList = new List<ProductData>();
    List<ProductData> list = await SpUtil.getObjList(
        SPKey.key_cartlist, (v) => ProductData.fromJson(v));
    if (ObjectUtil.isNotEmpty(list)) {
      if (!isContains(list, productData.sId)) {
        isAdd = true;
        cartList.add(productData);
      } else {
        isAdd = false;
      }
      cartList.addAll(list);
    } else {
      isAdd = true;
      cartList.add(productData);
    }
    await SpUtil.putObjectList(SPKey.key_cartlist, cartList);
    return isAdd;
  }

  //修改购物车数量
  static updateCartNum(ProductData productData, int num) async {
    List<ProductData> cartList = new List<ProductData>();
    List<ProductData> list = await SpUtil.getObjList(
        SPKey.key_cartlist, (v) => ProductData.fromJson(v));
    cartList.addAll(list);
    cartList[getIndex(cartList, productData.sId)].num = num;
    await SpUtil.putObjectList(SPKey.key_cartlist, cartList);
  }

  //修改购物车选中状态
  static updateCartState(ProductData productData, bool isSelect) async {
    List<ProductData> cartList = new List<ProductData>();
    List<ProductData> list = await SpUtil.getObjList(
        SPKey.key_cartlist, (v) => ProductData.fromJson(v));
    cartList.addAll(list);
    cartList[getIndex(cartList, productData.sId)].isSelect = isSelect;
    await SpUtil.putObjectList(SPKey.key_cartlist, cartList);
  }

  //修改购物车选中状态
  static updateCartStateAll(bool isSelect) async {
    List<ProductData> cartList = new List<ProductData>();
    List<ProductData> list = await SpUtil.getObjList(
        SPKey.key_cartlist, (v) => ProductData.fromJson(v));
    cartList.addAll(list);
    for (int i = 0; i < cartList.length; i++) {
      cartList[i].isSelect = isSelect;
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
