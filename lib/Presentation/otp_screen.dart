import 'package:flutter_ecommerce_155e5/Admin%20Pages/app_amdin_helper.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/Presentation/login_screen.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/signup-model.dart';
import 'package:flutter_ecommerce_155e5/Presentation/new_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTP extends StatelessWidget {
  final String verificationId, number, email, password, name, location;
  final bool fromSignUp;

  OTP(
      {required this.verificationId,
      required this.name,
      required this.location,
      required this.number,
      required this.email,
      required this.password,
      this.fromSignUp = false,
      super.key});
  final TextEditingController otpController = TextEditingController();
  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "We have sent an OTP to",
              style: TextStyle(fontSize: 22),
            ),
            const Text(
              "your Mobile",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                "Please check your mobile number ${number.substring(3, 7)}*****${number.substring(number.length - 2)}",
                style: const TextStyle(fontSize: 12)),
            Text(
                (fromSignUp)
                    ? "continue to Create your account"
                    : "continue to reset your password",
                style: const TextStyle(fontSize: 12)),
            const SizedBox(
              height: 50,
            ),
            Form(
                key: fromKey,
                child: CustomWidgets.textFormFieldCustom(
                    text: "OTP",
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    validatorFunction: (value) {})),
            const SizedBox(
              height: 25,
            ),
            CustomWidgets.elevatedButtonCustom(
                hintText: "Send",
                onPressedButton: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: otpController.text.toString());
                    CustomWidgets.progressBarCustom(context);

                    await FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((phoneCredential) {
                      print(email);
                      if (email.isNotEmpty && password.isNotEmpty) {
                        AuthCredential emailCredential =
                            EmailAuthProvider.credential(
                                email: email, password: password);
                        phoneCredential.user
                            ?.linkWithCredential(emailCredential)
                            .then((value) {
                          String userId = value.user!.uid.toString();
                          SignupModel signupModel = SignupModel(
                              name: name,
                              location: location,
                              id: userId,
                              phoneNumber: number,
                              email: email,
                              appId: appId);

                          DocumentReference database = FirebaseFirestore
                              .instance
                              .collection("Users Collections")
                              .doc(userId);
                          database.set(signupModel.dataToMap()).then((value) {
                            CustomWidgets.pageRouteCustom(context,
                                pageName: Login());
                          });
                        });
                      } else {
                        CustomWidgets.pageRouteCustom(context,
                            pageName: NewPassword(
                              user: phoneCredential.user!,
                            ));
                      }
                    });
                  } catch (ex) {
                    CustomWidgets.snackBarCustom(context,
                        massage: "code not matched");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
