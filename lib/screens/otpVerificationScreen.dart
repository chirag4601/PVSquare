import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pvsquare/constants/color.dart';
import 'package:pvsquare/controller/hudController.dart';
import 'package:pvsquare/controller/isOtpInvalidController.dart';
import 'package:pvsquare/controller/timerController.dart';
import 'package:pvsquare/screens/homeScreen.dart';
import 'package:pvsquare/utils/authService.dart';
import 'package:pvsquare/constants/fontSize.dart';
import 'package:pvsquare/constants/fontWeights.dart';
import 'package:pvsquare/constants/radius.dart';
import 'package:pvsquare/constants/spaces.dart';
import 'package:pvsquare/widgets/otpInputField.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen(this.phoneNumber, {Key? key}) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//objects
  AuthService authService = AuthService();

  //keys
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //variables
  String _verificationCode = '';
  late int _forceResendingToken = 0;

  //controllers

  TimerController timerController = Get.put(TimerController());
  HudController hudController = Get.put(HudController());
  IsOtpInvalidController isOtpInvalidController =
      Get.put(IsOtpInvalidController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: bidBackground,
            ),
            Positioned(
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: space_8, bottom: space_12),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/1.4,
                      height: MediaQuery.of(context).size.height/3,
                      child: const Image(
                        image: AssetImage("assets/images/PVSquare.jpg"),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius_3),
                            topRight: Radius.circular(radius_3))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.3,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          space_0, size_12, space_0, size_0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                space_2, space_0, space_0, space_4),
                            child: Text(
                              'OTP Verification',
                              style: TextStyle(
                                fontSize: size_10,
                                fontWeight: boldWeight,
                                color: black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: space_5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'OTP sent to',
                                  style: TextStyle(
                                    fontSize: size_6,
                                    fontWeight: regularWeight,
                                    color: darkCharcoal,
                                  ),
                                ),
                                Text(' +91${widget.phoneNumber} ',
                                    style: TextStyle(
                                        fontSize: size_7,
                                        fontWeight: regularWeight,
                                        color: black,
                                        fontFamily: "Roboto")),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    ' Change',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: size_6,
                                      fontWeight: regularWeight,
                                      color: bidBackground,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OTPInputField(_verificationCode),
                          Padding(
                              padding: EdgeInsets.only(top: space_3),
                              child: Obx(
                                () => Container(
                                  child:
                                      isOtpInvalidController.isOtpInvalid.value
                                          ? const Text(
                                              'Wrong OTP. Try Again!',
                                              style: TextStyle(
                                                letterSpacing: 0.5,
                                                color: red,
                                              ),
                                            )
                                          : const Text(""),
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: space_3),
                            child: Obx(
                              () => Container(
                                child: timerController.timeOnTimer.value == 0
                                    ? Obx(
                                        () => TextButton(
                                          onPressed: () {
                                            timerController.startTimer();
                                            hudController.updateHud(true);

                                            _verifyPhoneNumber();
                                          },
                                          child: Text(
                                            'Resend OTP ',
                                            style: TextStyle(
                                              letterSpacing: 0.5,
                                              color: timerController
                                                      .resendButton.value
                                                  ? navygreen
                                                  : unselectedGrey,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Obx(
                                        () => Text(
                                          'Resend OTP in ${timerController.timeOnTimer}',
                                          style: TextStyle(
                                            letterSpacing: 0.5,
                                            color: veryDarkGrey,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: space_5),
                            child: Obx(
                              () => Container(
                                child: hudController.showHud.value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text("Verifying OTP"),
                                          SizedBox(
                                            width: space_1,
                                          ),
                                          SizedBox(
                                            width: space_3,
                                            height: space_3,
                                            child:
                                                const CircularProgressIndicator(
                                              strokeWidth: 1,
                                            ),
                                          )
                                        ],
                                      )
                                    : const Text(""),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    timerController.startTimer();
    isOtpInvalidController.updateIsOtpInvalid(false);
    // hudController.updateHud(false);
    _verifyPhoneNumber();
  }

  void _verifyPhoneNumber() async {
    // try {
    await FirebaseAuth.instance.verifyPhoneNumber(
        //this value changes runtime
        forceResendingToken: _forceResendingToken,
        phoneNumber: '+91${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          hudController.updateHud(true);
          await FirebaseAuth.instance.signInWithCredential(credential);
          timerController.cancelTimer();
          Get.offAll(() => const HomeScreen());
        },
        verificationFailed: (FirebaseAuthException e) {
          hudController.updateHud(false);
        },
        codeSent: (String? verificationId, int? resendToken) {
          setState(() {
            _forceResendingToken = resendToken!;
            _verificationCode = verificationId!;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          if (mounted) {
            hudController.updateHud(false);
            timerController.cancelTimer();
            setState(() {
              _verificationCode = verificationId;
            });
          }
        },
        timeout: const Duration(seconds: 60));
    // } catch (e) {
    //   hudController.updateHud(false);
    // }
  }
} // class end
