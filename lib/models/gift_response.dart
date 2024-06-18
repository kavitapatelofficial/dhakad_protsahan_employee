// To parse this JSON data, do
//
//     final giftResponse = giftResponseFromJson(jsonString);

import 'dart:convert';

GiftResponse giftResponseFromJson(String str) => GiftResponse.fromJson(json.decode(str));

String giftResponseToJson(GiftResponse data) => json.encode(data.toJson());

class GiftResponse {
    dynamic message;
    bool? success;
    List<Datum>? data;

    GiftResponse({
        this.message,
        this.success,
        this.data,
    });

    factory GiftResponse.fromJson(Map<String, dynamic> json) => GiftResponse(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? name;
    String? image;
    String? points;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? price;

    Datum({
        this.id,
        this.name,
        this.image,
        this.points,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.price,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        points: json["points"],
        description: json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "points": points,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "price": price,
    };
}
