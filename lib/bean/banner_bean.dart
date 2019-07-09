class BannerBean {
  String _imgUrl;
  int _point;
  String _backup;

  @override
  String toString() {
    return 'BannerBean{_imgUrl: $_imgUrl, _point: $_point, _backup: $_backup}';
  }

  BannerBean.name();

  BannerBean(this._imgUrl, this._point, this._backup);

  String get imgUrl => _imgUrl;

  set imgUrl(String value) {
    _imgUrl = value;
  }

  int get point => _point;

  String get backup => _backup;

  set backup(String value) {
    _backup = value;
  }

  set point(int value) {
    _point = value;
  }
}
