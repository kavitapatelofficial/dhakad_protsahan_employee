
import 'package:dashboard_flutter/models/allocation_response.dart';
import 'package:dashboard_flutter/services/base_client.dart';
import 'package:dashboard_flutter/utils/endpoints.dart';
import 'package:flutter/material.dart';

class AllocationProvider extends ChangeNotifier {
  late AllocationResponse _getAllocation;
  AllocationResponse get getAllocation => _getAllocation;
  BaseClient baseClient = BaseClient();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> fetchAllocations() async {
    _isLoading = true;

    var res =
        await baseClient.get(true, Endpoints.baseUrl, Endpoints.getAllocation);

    if (res != null) {
      _getAllocation = allocationResponseFromJson(res);
      _isLoading = false;
    } else {
      _isLoading = false;

      throw Exception('Failed to load posts');
    }
    _isLoading = false;
    notifyListeners();
  }
}
