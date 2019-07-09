import 'package:flutter/material.dart';
import 'package:flutter_jdshop/tabs/cartpage.dart';
import 'package:flutter_jdshop/tabs/categorypage.dart';
import 'package:flutter_jdshop/tabs/homepage.dart';
import 'package:flutter_jdshop/tabs/userpage.dart';

class Tabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  var _currentIndex = 0;
  List _pages = [HomePage(), CategoryPage(), CartPage(), UserPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("jdshop"),
      ),
      body: this._pages[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //解决多个item不显示的问题
          fixedColor: Colors.red,
          //选中的颜色
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text("分类")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("购物车")),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), title: Text("我的")),
          ]),
    );
  }
}
