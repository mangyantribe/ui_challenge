// To parse this JSON data, do
//
//     final house = houseFromJson(jsonString);

import 'dart:convert';

List<House> houseFromJson(String str) => List<House>.from(json.decode(str).map((x) => House.fromJson(x)));

String houseToJson(List<House> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class House {
  int? id;
  String? tag;
  String? address;
  double? rating;
  bool? favorite;
  String? price;
  String? size;
  String? photo;
  String? description;
  List<String>? thumbnails;

  House({
    this.id,
    this.tag,
    this.address,
    this.rating,
    this.favorite,
    this.price,
    this.size,
    this.photo,
    this.description,
    this.thumbnails,
  });

  factory House.fromJson(Map<String, dynamic> json) => House(
    id: json["id"],
    tag: json["tag"],
    address: json["address"],
    rating: json["rating"]?.toDouble(),
    favorite: json["favorite"],
    price: json["price"],
    size: json["size"],
    photo: json["photo"],
    description: json["description"],
    thumbnails: List<String>.from(json["thumbnails"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tag": tag,
    "address": address,
    "rating": rating,
    "favorite": favorite,
    "price": price,
    "size": size,
    "photo": photo,
    "description": description,
    "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x)),
  };
}
