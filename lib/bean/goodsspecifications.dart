class GoodsSpecifications {
  String _title;
  List<GoodsSpecificationsData> _dataList;

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  List<GoodsSpecificationsData> get dataList => _dataList;

  set dataList(List<GoodsSpecificationsData> value) {
    _dataList = value;
  }

  GoodsSpecifications(this._title, this._dataList);

  GoodsSpecifications.name();
}

class GoodsSpecificationsData {
  int _id;
  String _title;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  GoodsSpecificationsData(this._id, this._title);

  GoodsSpecificationsData.name();
}
