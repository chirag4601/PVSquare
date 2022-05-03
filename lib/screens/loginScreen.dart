import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pvsquare/constants/color.dart';
import 'package:pvsquare/constants/fontSize.dart';
import 'package:pvsquare/constants/fontWeights.dart';
import 'package:pvsquare/constants/radius.dart';
import 'package:pvsquare/constants/spaces.dart';
import 'package:pvsquare/controller/hudController.dart';
import 'package:pvsquare/controller/loginTextController.dart';
import 'package:pvsquare/screens/otpVerificationScreen.dart';
import 'package:pvsquare/widgets/phoneNumberTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  HudController hudController = Get.put(HudController());
  LoginTextController loginTextController = Get.put(LoginTextController());

  @override
  void initState() {
    super.initState();
    hudController.updateHud(
        false); // so that if user press the back button in between verification verifying stop
  }

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: MediaQuery.of(context).size.height / 3,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: space_7),
                        child: Text(
                          'Welcome To PVSquare',
                          style: TextStyle(
                            fontSize: size_10,
                            fontWeight: boldWeight,
                            color: black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            space_0, space_3, space_0, space_6),
                        child: Text(
                          'A 6-digit OTP will be sent via SMS to verify your number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: regularWeight,
                            fontSize: size_6,
                            color: lightNavyBlue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: space_9, right: space_9),
                        child: Form(
                          key: _formKey,
                          child: const PhoneNumberTextField(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: space_9,
                        margin: EdgeInsets.fromLTRB(
                            space_8, space_11, space_8, space_0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(space_10),
                          child: Obx(
                            () => ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      loginTextController.isValidNumber.value
                                          ? MaterialStateProperty.all<Color>(
                                              Colors.red)
                                          : MaterialStateProperty.all<Color>(
                                              Colors.grey),
                                ),
                                child: const Text(
                                  'Send OTP',
                                  style: TextStyle(
                                    color: white,
                                  ),
                                ),
                                onPressed:
                                    loginTextController.isValidNumber.value
                                        ? () {
                                            Get.to(() => (OtpVerificationScreen(
                                                loginTextController
                                                    .mobileNumber.value)));
                                          }
                                        : () {}),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
