import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dashboard_flutter/models/error_model.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:dashboard_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'app_exceptions.dart';

class BaseClient {
  static const int timeOutDuration = 60;
  Future<dynamic> get(bool isSecure, String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      print("===========url============" + baseUrl + api);
      var response = isSecure
          ? await http.get(
              uri,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${Endpoints.box.read('access_token')}'
              },
            ).timeout(const Duration(seconds: timeOutDuration))
          : await http.get(
              uri,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ).timeout(const Duration(seconds: timeOutDuration));
      print(response.statusCode);
      print("========response.body============${response.body}===========");
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(
      bool isSecure, String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);

    print("===========url============" + baseUrl + api);
    print("===========payload=============" + payload);
    try {
      final response = isSecure
          ? await http
              .post(uri,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization':
                        'Bearer ${Endpoints.box.read('access_token')}'
                  },
                  body: payload)
              .timeout(const Duration(seconds: timeOutDuration))
          : await http
              .post(uri,
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: payload)
              .timeout(const Duration(seconds: timeOutDuration));
      print(response.statusCode);

      print(response.body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  Future<dynamic> postMultipart(
    bool isSecure,
    String baseUrl,
    String api,
    Map<String, dynamic> fields,
    List<XFile> files,
  ) async {
    var uri = Uri.parse(baseUrl + api);

    var request = http.MultipartRequest('POST', uri);

    // Add fields to the request
    fields.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    // Add files to the request
    if (files.isNotEmpty) {
      for (var file in files) {
        print("=====image===================${file.path}==============");
        request.files
            .add(await http.MultipartFile.fromPath('image', '${file.path}'));
      }
    }

    // Set headers
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      if (isSecure)
        'Authorization': 'Bearer ${Endpoints.box.read('access_token')}',
    });

    try {
      final response = await request
          .send()
          .timeout(const Duration(seconds: timeOutDuration));
      final responseStream = await response.stream.toBytes();
      final responseBody = utf8.decode(responseStream);

      print(response.statusCode);
      print(responseBody);

      return _processResponse(http.Response(responseBody, response.statusCode));
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    // print("==response=========${response.body}=================");
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);

        return responseJson;

      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        var data = jsonDecode(response.body);
        Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.accentGreen,
          textColor: Colors.white,
        );

        return responseJson;

      case 400:
        ErrorModel errorModel =
            errorModelFromJson(utf8.decode(response.bodyBytes));
        Fluttertoast.showToast(
          msg: errorModel.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalOrange,
          textColor: Colors.white,
        );
        return utf8.decode(response.bodyBytes);
      case 401:
        var responseJson = utf8.decode(response.bodyBytes);
        // var data = jsonDecode(response.body);
        // data['message'] == null
        //     ? SizedBox()
        //     : Fluttertoast.showToast(
        //         msg: data['message'] == null ? "" : data['message'],
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.SNACKBAR,
        //         timeInSecForIosWeb: 2,
        //         backgroundColor: AppColor.neturalOrange,
        //         textColor: Colors.white,
        //       );
        return responseJson;
      case 403:
        ErrorModel errorModel =
            errorModelFromJson(utf8.decode(response.bodyBytes));

        Fluttertoast.showToast(
          msg: errorModel.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalOrange,
          textColor: Colors.white,
        );
        return utf8.decode(response.bodyBytes);
      case 404:
        var responseJson = utf8.decode(response.bodyBytes);
        var data = jsonDecode(response.body);
        data['message'] == null
            ? SizedBox()
            : Fluttertoast.showToast(
                msg: data['message'] == null ? "" : data['message'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 2,
                backgroundColor: AppColor.neturalOrange,
                textColor: Colors.white,
              );
        return responseJson;
      case 422:
        ErrorModel errorModel =
            errorModelFromJson(utf8.decode(response.bodyBytes));
        Fluttertoast.showToast(
          msg: errorModel.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalOrange,
          textColor: Colors.white,
        );
        return utf8.decode(response.bodyBytes);
      case 500:
        ErrorModel errorModel =
            errorModelFromJson(utf8.decode(response.bodyBytes));
        Fluttertoast.showToast(
          msg: errorModel.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalOrange,
          textColor: Colors.white,
        );
        return utf8.decode(response.bodyBytes);
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
