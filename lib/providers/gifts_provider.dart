import 'package:dashboard_flutter/models/gift_response.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:flutter/material.dart';

class GiftProvider extends ChangeNotifier {
  late GiftResponse _getGift;
  GiftResponse get getGift => _getGift;

  late List<Datum> _getDueGift;
  List<Datum> get getDueGift => _getDueGift;
  BaseClient baseClient = BaseClient();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchGifts() async {
    _isLoading = true;

    var res =
        await baseClient.get(true, Endpoints.baseUrl, Endpoints.getlistGift);
    print("=========2=object =================   ==== $res");
    if (res != null) {
      _getGift = giftResponseFromJson(res);

      _isLoading = false;
    } else {
      _isLoading = false;

      throw Exception('Failed to load posts');
    }
    _isLoading = false;
    notifyListeners();
  }
}
