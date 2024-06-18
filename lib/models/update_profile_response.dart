// To parse this JSON data, do
//
//     final pofileResponse = pofileResponseFromJson(jsonString);

import 'dart:convert';

PofileResponse pofileResponseFromJson(String str) => PofileResponse.fromJson(json.decode(str));

String pofileResponseToJson(PofileResponse data) => json.encode(data.toJson());

class PofileResponse {
    String? message;
    bool? success;
    Data? data;

    PofileResponse({
        this.message,
        this.success,
        this.data,
    });

    factory PofileResponse.fromJson(Map<String, dynamic> json) => PofileResponse(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    int? id;
    String? name;
    String? email;
    DateTime? emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? phone;
    int? status;
    String? tokenKey;

    Data({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.phone,
        this.status,
        this.tokenKey,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        phone: json["phone"],
        status: json["status"],
        tokenKey: json["token_key"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "phone": phone,
        "status": status,
        "token_key": tokenKey,
    };
}
