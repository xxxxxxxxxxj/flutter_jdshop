import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/tabs/cartpage.dart';
import 'package:flutter_jdshop/pages/tabs/categorypage.dart';
import 'package:flutter_jdshop/pages/tabs/homepage.dart';
import 'package:flutter_jdshop/pages/tabs/userpage.dart';
import 'package:flutter_jdshop/res/strings.dart';
import 'package:fluintl/fluintl.dart';

class Tabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  var _currentIndex = 0;
  List<Widget> _pages = [HomePage(), CategoryPage(), CartPage(), UserPage()];
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("jdshop"),
      ),
      /*body: IndexedStack(
        //保存页面状态，原理是一次性加载所有的页面（不灵活，不推荐使用）
        index: _currentIndex,
        children: this._pages,
      ),*/
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //解决多个item不显示的问题
          fixedColor: Colors.red,
          //选中的颜色
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
              _pageController.jumpToPage(_currentIndex);
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(IntlUtil.getString(context, Ids.titleHome))),
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: Text(IntlUtil.getString(context, Ids.titleCategory))),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text(IntlUtil.getString(context, Ids.titleShopCart))),
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                title: Text(IntlUtil.getString(context, Ids.titleMy))),
          ]),
    );
  }
}
