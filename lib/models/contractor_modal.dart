// To parse this JSON data, do
//
//     final contractorModal = contractorModalFromJson(jsonString);

import 'dart:convert';

ContractorModal contractorModalFromJson(String str) => ContractorModal.fromJson(json.decode(str));

String contractorModalToJson(ContractorModal data) => json.encode(data.toJson());

class ContractorModal {
    String? message;
    bool? success;
    Data? data;

    ContractorModal({
        this.message,
        this.success,
        this.data,
    });

    factory ContractorModal.fromJson(Map<String, dynamic> json) => ContractorModal(
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
    dynamic emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? phone;
    int? status;
    dynamic tokenKey;
    int? demo;
    String? token;
    int? otp;

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
        this.demo,
        this.token,
        this.otp,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        phone: json["phone"],
        status: json["status"],
        tokenKey: json["token_key"],
        demo: json["demo"],
        token: json["token"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "phone": phone,
        "status": status,
        "token_key": tokenKey,
        "demo": demo,
        "token": token,
        "otp": otp,
    };
}
