
class Foods {
  String? name;
  String? avatar;
  String? detail;
  String? price;
  String? id;
  int? like;

  Foods({this.name, this.avatar, this.detail, this.price,  this.id,  this.like});

  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    detail = json['detail'];
    price = json['price'];
    like = json['like'] == true ? 1 : 0;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    data['detail'] = detail;
    data['price'] = price;
    data['like'] = like ;
    data['id'] = id;
    return data;
  }
}
