class HotBean {
  String _imgUrl;
  int _point;
  String _backup;
  String _title;
  double _price;
  double _listPrice;

  HotBean.name();

  HotBean(this._imgUrl, this._point, this._backup, this._title, this._price,
      this._listPrice);

  String get imgUrl => _imgUrl;

  set imgUrl(String value) {
    _imgUrl = value;
  }

  int get point => _point;

  double get listPrice => _listPrice;

  set listPrice(double value) {
    _listPrice = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get backup => _backup;

  set backup(String value) {
    _backup = value;
  }

  set point(int value) {
    _point = value;
  }
}
