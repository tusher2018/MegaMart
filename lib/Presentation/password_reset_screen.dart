import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordReset extends StatelessWidget {
  PasswordReset({super.key});
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Reset Password",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Please enter your email to receive a"),
            const Text("code to create a new password via email"),
            const SizedBox(
              height: 50,
            ),
            Form(
                key: formKey,
                child: CustomWidgets.textFormFieldCustom(
                    text: "Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validatorFunction: (value) {
                      return CustomWidgets.emailValidity(value);
                    })),
            const SizedBox(
              height: 25,
            ),
            CustomWidgets.elevatedButtonCustom(
                hintText: "Send",
                onPressedButton: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: emailController.text);
                      CustomWidgets.snackBarCustom(
                        context,
                        massage: "Password reset email sent!",
                      );
                    } on FirebaseAuthException catch (e) {
                      CustomWidgets.snackBarCustom(
                        context,
                        massage: e.message ?? "An error occurred",
                      );
                    }
                  } else {
                    CustomWidgets.snackBarCustom(
                      context,
                      massage: "Please enter a valid email",
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
