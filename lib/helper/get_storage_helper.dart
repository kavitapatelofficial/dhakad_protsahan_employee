import 'package:dashboard_flutter/models/login_response.dart';
import 'package:get_storage/get_storage.dart';


final box = GetStorage();

class GetStorageHelper {
  static setinitialdata() {
    box.writeIfNull('is_logged_in', false);
    box.writeIfNull('user_id', "");
    box.writeIfNull('name', "");
    box.writeIfNull('email', "");
    box.writeIfNull('labName', "");
    box.writeIfNull('labId', ""); 
    box.writeIfNull('access_token', "");
  }

  static setdata(LoginResponse loginResponse) {
    box.write('is_logged_in', true);
    box.write('user_id', loginResponse.data!.id);
    box.write('name', loginResponse.data!.name);
    box.write('email', loginResponse.data!.email);
    box.write('phone', loginResponse.data!.phone);
     box.write('otp', loginResponse.data!.otp);
    box.write('access_token', loginResponse.data!.token);
  }
}