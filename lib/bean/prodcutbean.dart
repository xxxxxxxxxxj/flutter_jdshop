class ProductBean {
  List<ProductData> result;

  ProductBean({this.result});

  ProductBean.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<ProductData>();
      json['result'].forEach((v) {
        result.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  String sId;
  String title;
  String cid;
  Object price;
  String oldPrice;
  String pic;
  String sPic;
  String attr;
  int num;
  bool isSelect;

  @override
  String toString() {
    return 'ProductData{sId: $sId, title: $title, cid: $cid, price: $price, oldPrice: $oldPrice, pic: $pic, sPic: $sPic, attr: $attr, num: $num, isSelect: $isSelect}';
  }

  ProductData.name(this.sId,this.title, this.price, this.pic,this.attr, this.num, this.isSelect);

  ProductData(
      {this.sId,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.pic,
      this.sPic});

  ProductData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    pic = json['pic'];
    sPic = json['s_pic'];
    attr = json['attr'];
    num = json['num'];
    isSelect = json['isSelect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['pic'] = this.pic;
    data['s_pic'] = this.sPic;
    data['attr'] = this.attr;
    data['num'] = this.num;
    data['isSelect'] = this.isSelect;
    return data;
  }
}
