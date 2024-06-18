// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
    String? message;
    bool? success;
    dynamic data;

    ErrorModel({
        this.message,
        this.success,
        this.data,
    });

    factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json["message"],
        success: json["success"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data,
    };
}
