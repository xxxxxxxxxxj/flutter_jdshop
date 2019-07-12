import 'package:flutter/material.dart';

class ShopListPage extends StatefulWidget {
  Map arguments;

  ShopListPage({this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _ShopListPageState();
  }
}

class _ShopListPageState extends State<ShopListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品列表"),
      ),
      body: ListView.separated(itemBuilder: (context,index){

      }, separatorBuilder: (context,index){

      }, itemCount: 20),
    );
  }
}
