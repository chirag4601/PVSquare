import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pvsquare/constants/borderWidth.dart';
import 'package:pvsquare/constants/color.dart';
import 'package:pvsquare/constants/fontSize.dart';
import 'package:pvsquare/constants/fontWeights.dart';
import 'package:pvsquare/constants/spaces.dart';
import 'package:pvsquare/controller/hudController.dart';
import 'package:pvsquare/controller/loginTextController.dart';

class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField({Key? key}) : super(key: key);

  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  HudController hudController = Get.put(HudController());
  LoginTextController loginTextController = Get.find<LoginTextController>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: borderWidth_20, color: backgroundGrey)),
          child: Row(children: [
            Padding(
              padding: EdgeInsets.only(left: space_1),
              child: SizedBox(
                width: space_3,
                height: space_3,
                child: const Image(
                  image: AssetImage("assets/images/indianFlag.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: space_1, top: space_2),
              child: SizedBox(
                width: space_5,
                height: space_5,
                child: Text(
                  "+91",
                  style: TextStyle(
                      fontWeight: regularWeight,
                      fontSize: size_6,
                      fontFamily: "Roboto"),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 2),
                height: space_6,
                width: space_1,
                child: CustomPaint(
                  foregroundPainter: LinePainter(),
                )),
            SizedBox(
              width: 200,
              child: TextFormField(
                onChanged: (String value) {
                  if (value.length == 10) {
                    loginTextController.updateValidity(true);
                  }
                  else{
                    loginTextController.updateValidity(false);
                  }
                  loginTextController.updateMobileNumber(value);
                  //   providerData.updateInputControllerLengthCheck(true);
                  //   providerData.updateButtonColor(activeButtonColor);
                  // } else {
                  //   providerData.updateInputControllerLengthCheck(false);
                  //   providerData.updateButtonColor(deactiveButtonColor);
                  // }
                  // providerData.updatePhoneController(_controller);
                },
                controller: _controller,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                maxLength: 10,
                validator: (value) =>
                value!.length == 10 ? null : 'EnterPhoneNumber'.tr,
                // 'Enter a valid Phone Number',
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: white,
                  hintText: 'Enter Phone Number',
                  hintStyle: TextStyle(color: darkCharcoal, fontSize: size_7),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  @override
  void initState() {
    hudController.updateHud(false);
    super.initState();
  }
}

class LinePainter extends CustomPainter {
  double? height;
  double? width;
  LinePainter({this.height, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = locationLineColor
      ..strokeWidth = width != null ? width! : 2;
    canvas.drawLine(
        const Offset(3, 1), Offset(3, height != null ? height! + 1 : 29), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
