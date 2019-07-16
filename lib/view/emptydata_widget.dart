import 'package:flutter/material.dart';
import 'package:flutter_jdshop/res/styles.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/util/utils.dart';

class EmptyDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Image.asset(
          Utils.getImgPath("ic_data_empty"),
          width: ScreenAdapter.setWidth(180),
          height: ScreenAdapter.setHeight(180),
        ),
        Gaps.vGap10,
        new Text(
          "空空如也～",
          style: TextStyles.listContent2,
        ),
      ],
    );
  }
}
