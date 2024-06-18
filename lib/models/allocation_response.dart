// To parse this JSON data, do
//
//     final allocationResponse = allocationResponseFromJson(jsonString);

import 'dart:convert';

AllocationResponse allocationResponseFromJson(String str) => AllocationResponse.fromJson(json.decode(str));

String allocationResponseToJson(AllocationResponse data) => json.encode(data.toJson());

class AllocationResponse {
    dynamic message;
    bool? success;
    List<Datum>? data;

    AllocationResponse({
        this.message,
        this.success,
        this.data,
    });

    factory AllocationResponse.fromJson(Map<String, dynamic> json) => AllocationResponse(
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
    String? customerId;
    String? points;
    String? productPoints;
    String? productId;
    String? userId;
    String? quantity;
    DateTime? createdAt;
    DateTime? updatedAt;
    Detail? detail;
    Contractor? contractor;

    Datum({
        this.id,
        this.customerId,
        this.points,
        this.productPoints,
        this.productId,
        this.userId,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.detail,
        this.contractor,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        customerId: json["customer_id"],
        points: json["points"],
        productPoints: json["product_points"],
        productId: json["product_id"],
        userId: json["user_id"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
        contractor: json["contractor"] == null ? null : Contractor.fromJson(json["contractor"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "points": points,
        "product_points": productPoints,
        "product_id": productId,
        "user_id": userId,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "detail": detail?.toJson(),
        "contractor": contractor?.toJson(),
    };
}

class Contractor {
    int? id;
    String? name;
    String? number;
    dynamic alternateNumber;
    dynamic address;
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

class Detail {
    List<String>? products;
    List<List<String>>? productsDeatils;
    List<int>? productPoints;
    List<String>? quantity;

    Detail({
        this.products,
        this.productsDeatils,
        this.productPoints,
        this.quantity,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        products: json["products"] == null ? [] : List<String>.from(json["products"]!.map((x) => x)),
        productsDeatils: json["products_deatils"] == null ? [] : List<List<String>>.from(json["products_deatils"]!.map((x) => List<String>.from(x.map((x) => x)))),
        productPoints: json["product_points"] == null ? [] : List<int>.from(json["product_points"]!.map((x) => x)),
        quantity: json["quantity"] == null ? [] : List<String>.from(json["quantity"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x)),
        "products_deatils": productsDeatils == null ? [] : List<dynamic>.from(productsDeatils!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "product_points": productPoints == null ? [] : List<dynamic>.from(productPoints!.map((x) => x)),
        "quantity": quantity == null ? [] : List<dynamic>.from(quantity!.map((x) => x)),
    };
}
