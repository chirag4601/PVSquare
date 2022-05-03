import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pvsquare/controller/hudController.dart';
import 'package:pvsquare/controller/isOtpInvalidController.dart';
import 'package:pvsquare/controller/timerController.dart';
import 'package:pvsquare/screens/homeScreen.dart';
import 'package:pvsquare/screens/loginScreen.dart';

class AuthService {
  HudController hudController = Get.put(HudController());
  TimerController timerController = Get.put(TimerController());
  IsOtpInvalidController isOtpInvalidController =
  Get.put(IsOtpInvalidController());

  Future signOut() async {
    try {
      Get.to(() => LoginScreen());
      return FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void manualVerification({String? verificationId, String? smsCode}) async {
    print('verificationId in manual func: $smsCode');
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: smsCode!))
          .then((value) async {
        if (value.user != null) {
          print('hud false due to try in manual verification');
          hudController.updateHud(false);
          timerController.cancelTimer();

          Get.offAll(() => const HomeScreen());

        }
      });
    } catch (e) {
      // FocusScope.of(context).unfocus();

      print('hud false due to catch in manual verification');

      hudController.updateHud(false);
      // Get.to(() => NewLoginScreen());
      isOtpInvalidController.updateIsOtpInvalid(true);
      // Get.snackbar('Invalid Otp', 'Please Enter the correct OTP',
      //     colorText: white, backgroundColor: black_87);
    }
  }
}
