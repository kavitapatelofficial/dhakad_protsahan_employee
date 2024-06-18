// To parse this JSON data, do
//
//     final contractorResponse = contractorResponseFromJson(jsonString);

import 'dart:convert';

ContractorResponse contractorResponseFromJson(String str) => ContractorResponse.fromJson(json.decode(str));

String contractorResponseToJson(ContractorResponse data) => json.encode(data.toJson());

class ContractorResponse {
    dynamic message;
    bool? success;
    List<Datum>? data;

    ContractorResponse({
        this.message,
        this.success,
        this.data,
    });

    factory ContractorResponse.fromJson(Map<String, dynamic> json) => ContractorResponse(
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
    dynamic id;
    String? name;
    String? number;
    String? alternateNumber;
    String? address;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? image;
    String? cId;
    dynamic availablePoints;
    List<Allocation>? allocations;
    List<dynamic>? redemptions;

    Datum({
        this.id,
        this.name,
        this.number,
        this.alternateNumber,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.cId,
        this.availablePoints,
        this.allocations,
        this.redemptions,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        alternateNumber: json["alternate_number"],
        address: json["address"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        image: json["image"],
        cId: json["c_id"],
        availablePoints: json["available_points"],
        allocations: json["allocations"] == null ? [] : List<Allocation>.from(json["allocations"]!.map((x) => Allocation.fromJson(x))),
        redemptions: json["redemptions"] == null ? [] : List<dynamic>.from(json["redemptions"]!.map((x) => x)),
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
        "c_id": cId,
        "available_points": availablePoints,
        "allocations": allocations == null ? [] : List<dynamic>.from(allocations!.map((x) => x.toJson())),
        "redemptions": redemptions == null ? [] : List<dynamic>.from(redemptions!.map((x) => x)),
    };
}

class Allocation {
    dynamic id;
    String? customerId;
    String? points;
    String? productPoints;
    String? productId;
    String? userId;
    String? quantity;
    DateTime? date;
    DateTime? createdAt;
    DateTime? updatedAt;

    Allocation({
        this.id,
        this.customerId,
        this.points,
        this.productPoints,
        this.productId,
        this.userId,
        this.quantity,
        this.date,
        this.createdAt,
        this.updatedAt,
    });

    factory Allocation.fromJson(Map<String, dynamic> json) => Allocation(
        id: json["id"],
        customerId: json["customer_id"],
        points: json["points"],
        productPoints: json["product_points"],
        productId: json["product_id"],
        userId: json["user_id"],
        quantity: json["quantity"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "points": points,
        "product_points": productPoints,
        "product_id": productId,
        "user_id": userId,
        "quantity": quantity,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
