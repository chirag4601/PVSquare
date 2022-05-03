import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pvsquare/constants/color.dart';
import 'package:pvsquare/controller/hudController.dart';
import 'package:pvsquare/controller/isOtpInvalidController.dart';
import 'package:pvsquare/utils/authService.dart';
import 'package:pvsquare/constants/radius.dart';
import 'package:pvsquare/constants/spaces.dart';

class OTPInputField extends StatefulWidget {
  String _verificationCode = '';

  OTPInputField(this._verificationCode, {Key? key}) : super(key: key);
  @override
  _OTPInputFieldState createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  HudController hudController = Get.put(HudController());
  AuthService authService = AuthService();
  IsOtpInvalidController isOtpInvalidController =
  Get.put(IsOtpInvalidController());

  @override
  Widget build(BuildContext context) {

    return OTPTextField(
      fieldStyle: FieldStyle.box,
      outlineBorderRadius: radius_1,
      margin: EdgeInsets.only(left: space_2),
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: white,
        enabledBorderColor: blueTitleColor,
        focusBorderColor: blueTitleColor,
      ),
      length: 6,
      width: MediaQuery.of(context).size.width / 1.2,
      fieldWidth: space_8,
      style: const TextStyle(fontSize: 17),
      onCompleted: (pin) {
        hudController.updateHud(true);
        // providerData.updateSmsCode(pin);
        authService.manualVerification(
            // smsCode: providerData.smsCode,
            verificationId: widget._verificationCode);

        // providerData.updateInputControllerLengthCheck(true);
        // providerData.clearAll();
      },
      onChanged: (value) {
        setState(() {});
        if (value.length == 6) {
          isOtpInvalidController.updateIsOtpInvalid(false);
        }
        print("changed to - ${value.length}");
      },
    );
  }
}
