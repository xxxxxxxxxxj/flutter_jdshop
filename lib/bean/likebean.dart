class LikeBean {
  String _imgUrl;
  int _point;
  String _backup;
  String _title;

  LikeBean.name();

  LikeBean(this._imgUrl, this._point, this._backup, this._title);

  String get imgUrl => _imgUrl;

  set imgUrl(String value) {
    _imgUrl = value;
  }

  int get point => _point;

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
