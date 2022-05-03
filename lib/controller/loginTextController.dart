import 'package:get/get.dart';

class LoginTextController extends GetxController {
  RxBool isValidNumber = false.obs;
  RxString mobileNumber = "".obs;

  void updateValidity(bool value) {
    isValidNumber.value = value;
  }
  void updateMobileNumber(String value){
    mobileNumber.value = value;
  }
}
