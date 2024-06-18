import 'package:dashboard_flutter/models/contractor_response.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:flutter/material.dart';

class ContractorProvider extends ChangeNotifier {
  late ContractorResponse _getContractor;
  ContractorResponse get getContractor => _getContractor;
  BaseClient baseClient = BaseClient();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchContractors() async {
    _isLoading = true;

    var res =
        await baseClient.get(true, Endpoints.baseUrl, Endpoints.getContractor);

    if (res != null) {
      _getContractor = contractorResponseFromJson(res);
      _isLoading = false;
    } else {
      _isLoading = false;

      throw Exception('Failed to load posts');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchContractors(String name) async {
    var res = await baseClient.get(
        true, Endpoints.baseUrl, Endpoints.getContractor + "?search=$name");
    print("=========2=object =================   ==== $res");
    if (res != null) {
      _getContractor = contractorResponseFromJson(res);
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
