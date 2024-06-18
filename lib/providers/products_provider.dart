import 'package:dashboard_flutter/models/product_response.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  BaseClient baseClient = BaseClient();

  ProductResponse? _getProduct;
  ProductResponse? get getProduct => _getProduct;

  late List<Datum> _getDueProduct;
  List<Datum> get getDueProduct => _getDueProduct;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProduct() async {
    _isLoading = true;

    var res =
        await baseClient.get(true, Endpoints.baseUrl, Endpoints.getProduct);

    if (res != null) {
      _getProduct = productResponseFromJson(res);

      _isLoading = false;
    } else {
      throw Exception('Failed to load posts');
    }
    _isLoading = false;
    notifyListeners();
  }
}
