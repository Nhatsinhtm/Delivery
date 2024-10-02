// To parse this JSON data, do
//
//     final foodsNew = foodsNewFromJson(jsonString);

import 'dart:convert';

List<FoodsNew> foodsNewFromJson(String str) => List<FoodsNew>.from(json.decode(str).map((x) => FoodsNew.fromJson(x)));

String foodsNewToJson(List<FoodsNew> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodsNew {
  String? name;
  String? avatar;
  String? detail;
  String? price;
  bool? like;
  String? id;

  FoodsNew({
     this.name,
     this.avatar,
     this.detail,
     this.price,
     this.like,
     this.id,
  });

  factory FoodsNew.fromJson(Map<String, dynamic> json) => FoodsNew(
    name: json["name"],
    avatar: json["avatar"],
    detail: json["detail"],
    price: json["price"],
    like: json["like"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "avatar": avatar,
    "detail": detail,
    "price": price,
    "like": like,
    "id": id,
  };
}
