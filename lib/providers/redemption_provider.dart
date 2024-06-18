import 'package:dashboard_flutter/models/redemption_response.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:flutter/material.dart';

class RedemptionProvider extends ChangeNotifier {
  late RedemptionResponse _getRedemption;
  RedemptionResponse get getRedemption => _getRedemption;
  BaseClient baseClient = BaseClient();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> fetchRedemptions() async {
    _isLoading = true;

    var res =
        await baseClient.get(true, Endpoints.baseUrl, Endpoints.getRedemption);

    if (res != null) {
      _getRedemption = redemptionResponseFromJson(res);
      _isLoading = false;
    } else {
      _isLoading = false;

      throw Exception('Failed to load posts');
    }
    _isLoading = false;
    notifyListeners();
  }
}
