// To parse this JSON data, do
//
//     final redemptionResponse = redemptionResponseFromJson(jsonString);

import 'dart:convert';

RedemptionResponse redemptionResponseFromJson(String str) => RedemptionResponse.fromJson(json.decode(str));

String redemptionResponseToJson(RedemptionResponse data) => json.encode(data.toJson());

class RedemptionResponse {
    dynamic message;
    bool? success;
    List<Datum>? data;

    RedemptionResponse({
        this.message,
        this.success,
        this.data,
    });

    factory RedemptionResponse.fromJson(Map<String, dynamic> json) => RedemptionResponse(
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
    int? customerId;
    int? pointUsed;
    int? giftId;
    int? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Contractor? contractor;
    Gift? gift;

    Datum({
        this.id,
        this.customerId,
        this.pointUsed,
        this.giftId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.contractor,
        this.gift,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        customerId: json["customer_id"],
        pointUsed: json["point_used"],
        giftId: json["gift_id"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        contractor: json["contractor"] == null ? null : Contractor.fromJson(json["contractor"]),
        gift: json["gift"] == null ? null : Gift.fromJson(json["gift"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "point_used": pointUsed,
        "gift_id": giftId,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "contractor": contractor?.toJson(),
        "gift": gift?.toJson(),
    };
}

class Contractor {
    int? id;
    String? name;
    String? number;
    String? alternateNumber;
    String? address;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? image;

    Contractor({
        this.id,
        this.name,
        this.number,
        this.alternateNumber,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.image,
    });

    factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        alternateNumber: json["alternate_number"],
        address: json["address"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
        "alternate_number": alternateNumber,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "image": image,
    };
}

class Gift {
    int? id;
    String? name;
    String? image;
    String? points;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? price;

    Gift({
        this.id,
        this.name,
        this.image,
        this.points,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.price,
    });

    factory Gift.fromJson(Map<String, dynamic> json) => Gift(
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
