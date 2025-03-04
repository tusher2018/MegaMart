import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/demo_for_today.dart';
import 'package:flutter_ecommerce_155e5/navigation/custom_navigation.dart';
import 'package:flutter_ecommerce_155e5/Presentation/password_reset_screen.dart';
import 'package:flutter_ecommerce_155e5/Presentation/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final loginValidityKey = GlobalKey<FormState>();

  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) {
          slideNavigationPushAndRemoveUntil(const DemoForToday(), context);
        },
      );

      // Successfully signed in
      CustomWidgets.snackBarCustom(context,
          massage: "Signed in with Google successfully!");
      // Navigate to the desired page or perform other actions
    } catch (e) {
      CustomWidgets.snackBarCustom(context, massage: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: loginValidityKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 30),
                ),
                const Text("add your details to login"),
                const SizedBox(height: 30),
                CustomWidgets.textFormFieldCustom(
                    text: "Email",
                    controller: emailController,
                    validatorFunction: (value) {
                      return CustomWidgets.emailValidity(value);
                    }),
                const SizedBox(height: 20),
                CustomWidgets.textFormFieldCustom(
                    text: "Password",
                    controller: passwordController,
                    validatorFunction: (value) {
                      return CustomWidgets.passwordValidity(value);
                    }),
                const SizedBox(height: 20),
                CustomWidgets.elevatedButtonCustom(
                    hintText: "Login",
                    onPressedButton: () {
                      loginProcess(context);
                      // slideNavigationPushAndRemoveUntil(
                      //     const DemoForToday(), context);
                    }),
                const SizedBox(height: 10),
                InkWell(
                  child: const Text("Forget your password?"),
                  onTap: () {
                    CustomWidgets.pageRouteCustom(context,
                        onlyPush: true, pageName: PasswordReset());
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text("or Login With"),
                const SizedBox(height: 20),
                CustomWidgets.iconButtonCustom(
                    imageIconpath: "assets/images/google.png",
                    hintText: "Login with Google",
                    fontSize: 14,
                    fontColour: Colors.black,
                    onPressedButton: _signInWithGoogle,
                    colour: Colors.white),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    InkWell(
                      child: const Text("  Sign Up"),
                      onTap: () =>
                          slideNavigationPushAndRemoveUntil(SignUp(), context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginProcess(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        CustomWidgets.progressBarCustom(context);
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          slideNavigationPushAndRemoveUntil(const DemoForToday(), context);
        });
      } on FirebaseException {
        CustomWidgets.snackBarCustom(context,
            massage: "Email & Password not matched");
      }
    }
  }
}
