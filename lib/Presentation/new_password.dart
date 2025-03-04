// ignore_for_file: must_be_immutable

import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/Presentation/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatelessWidget {
  User user;

  NewPassword({required this.user, super.key});

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Center(
        child: Form(
          key: fromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "New Password",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter your email to receive a",
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                "link to create a new password via email",
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomWidgets.textFormFieldCustom(
                  text: "Password",
                  controller: passwordController,
                  validatorFunction: (value) {
                    CustomWidgets.passwordValidity(value);
                  }),
              const SizedBox(
                height: 25,
              ),
              CustomWidgets.textFormFieldCustom(
                  text: "Confirm Password",
                  controller: confirmPasswordController,
                  validatorFunction: (value) {
                    if (passwordController.text.toString() ==
                        value.toString()) {
                      return null;
                    } else {
                      return "password not matched";
                    }
                  }),
              const SizedBox(
                height: 25,
              ),
              CustomWidgets.elevatedButtonCustom(
                  hintText: "Send",
                  onPressedButton: () async {
                    if (!fromKey.currentState!.validate()) {
                      CustomWidgets.snackBarCustom(context,
                          massage: "please enter password");
                    } else {
                      await FirebaseAuth.instance.currentUser!
                          .updatePassword(passwordController.text);
                      CustomWidgets.pageRouteCustom(context, pageName: Login());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
