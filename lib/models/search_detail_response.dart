// To parse this JSON data, do
//
//     final searchListRespons = searchListResponsFromJson(jsonString);

import 'dart:convert';

SearchListRespons searchListResponsFromJson(String str) => SearchListRespons.fromJson(json.decode(str));

String searchListResponsToJson(SearchListRespons data) => json.encode(data.toJson());

class SearchListRespons {
    bool? success;
    String? message;
    int? subCode;
    List<Datum>? data;

    SearchListRespons({
        this.success,
        this.message,
        this.subCode,
        this.data,
    });

    factory SearchListRespons.fromJson(Map<String, dynamic> json) => SearchListRespons(
        success: json["success"],
        message: json["message"],
        subCode: json["subCode"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "subCode": subCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? mrn2;
    String? firstName;
    String? middleName;
    String? lastName;
    String? birthday;
    String? gender;
    String? mobileNo;
    String? oldUhid;
    int? id;

    Datum({
        this.mrn2,
        this.firstName,
        this.middleName,
        this.lastName,
        this.birthday,
        this.gender,
        this.mobileNo,
        this.oldUhid,
        this.id,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        mrn2: json["mrn2"],
        firstName:json["firstName"]!,
        middleName: json["middleName"]!,
        lastName:json["lastName"]!,
        birthday: json["birthday"],
        gender: json["gender"]!,
        mobileNo: json["mobileNo"],
        oldUhid: json["oldUhid"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "mrn2": mrn2,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "birthday": birthday,
        "gender": gender,
        "mobileNo": mobileNo,
        "oldUhid": oldUhid,
        "id": id,
    };
}








