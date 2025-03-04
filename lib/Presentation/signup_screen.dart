// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce_155e5/Admin%20Pages/app_amdin_helper.dart';
import 'package:flutter_ecommerce_155e5/Presentation/color.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/Presentation/login_screen.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/loation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/signup-model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  LocationModel? location = FullBDLocations;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final signupValidityKey = GlobalKey<FormState>();

  late DistrictModel destrict;
  late int destrictIndex = 0;

  void locationLoaderCaller() async {
    // location = await CustomBackEnd.firebaseLocationLoader();
    destrictIndex = 0;
    destrict = location!.destricts[destrictIndex];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    destrict = location!.destricts[destrictIndex];
    // locationLoaderCaller();
  }

  void _signUpWithEmailPassword() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then(
        (value) {
          String userId = value.user!.uid.toString();
          SignupModel signupModel = SignupModel(
              name: nameController.text,
              location: destrict.destrict,
              id: userId,
              phoneNumber: numberController.text,
              email: emailController.text,
              appId: appId);

          DocumentReference database = FirebaseFirestore.instance
              .collection("Users Collections")
              .doc(userId);
          database.set(signupModel.dataToMap()).then((value) {
            CustomWidgets.pageRouteCustom(context, pageName: Login());
          });
        },
      );

      // Successfully signed up
      CustomWidgets.snackBarCustom(context, massage: "Signed up successfully!");
      // Navigate to the desired page or perform other actions
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomWidgets.snackBarCustom(context,
            massage: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        CustomWidgets.snackBarCustom(context,
            massage: "The account already exists for that email.");
      } else {
        CustomWidgets.snackBarCustom(context,
            massage: e.message ?? "Sign up failed");
      }
    } catch (e) {
      CustomWidgets.snackBarCustom(context, massage: e.toString());
    }
  }

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
          String userId = value.user!.uid.toString();
          SignupModel signupModel = SignupModel(
              name: nameController.text,
              location: destrict.destrict,
              id: userId,
              phoneNumber: numberController.text,
              email: emailController.text,
              appId: appId);

          DocumentReference database = FirebaseFirestore.instance
              .collection("Users Collections")
              .doc(userId);
          database.set(signupModel.dataToMap()).then((value) {
            CustomWidgets.pageRouteCustom(context, pageName: Login());
          });
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
        body: (location != null)
            ? Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: signupValidityKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 30),
                        ),
                        const Text("Add your details to sign up"),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomWidgets.textFormFieldCustom(
                            text: "Name",
                            controller: nameController,
                            validatorFunction: (value) {
                              return CustomWidgets.nameValidity(value);
                            }),
                        const SizedBox(height: 20),
                        Container(
                          width: 250,
                          height: 55,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F2),
                              border: Border.all(color: primaryColor, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text("Location:"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: DropdownButton(
                                  value: destrict.destrict,
                                  items: location!.destricts
                                      .map((DistrictModel destrictName) {
                                    return DropdownMenuItem(
                                        value: destrictName.destrict,
                                        child: Text(destrictName.destrict));
                                  }).toList(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  onChanged: (value) {
                                    destrictIndex = location!.destricts
                                        .indexWhere((element) {
                                      return element.destrict == value;
                                    });
                                    destrict =
                                        location!.destricts[destrictIndex];
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomWidgets.textFormFieldCustom(
                            text: "Email",
                            controller: emailController,
                            validatorFunction: (value) {
                              return CustomWidgets.emailValidity(value);
                            }),
                        const SizedBox(height: 20),
                        CustomWidgets.textFormFieldCustom(
                          text: "Phone number",
                          controller: numberController,
                        ),
                        const SizedBox(height: 20),
                        CustomWidgets.textFormFieldCustom(
                            text: "Password",
                            controller: passwordController,
                            validatorFunction: (value) {
                              return CustomWidgets.passwordValidity(value);
                            }),
                        const SizedBox(height: 30),
                        CustomWidgets.elevatedButtonCustom(
                            hintText: "Sign Up",
                            onPressedButton: () async {
                              if (signupValidityKey.currentState!.validate()) {
                                _signUpWithEmailPassword();
                              } else {
                                CustomWidgets.snackBarCustom(context,
                                    massage:
                                        "Enter all required fields with valid information");
                              }
                            }),
                        const SizedBox(height: 30),
                        const Text("or Sign Up With"),
                        const SizedBox(height: 20),
                        CustomWidgets.iconButtonCustom(
                            imageIconpath: "assets/images/google.png",
                            hintText: "Sign Up with Google",
                            fontSize: 14,
                            fontColour: Colors.black,
                            onPressedButton: _signInWithGoogle,
                            colour: Colors.white),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an Account?"),
                              InkWell(
                                child: const Text("  Login"),
                                onTap: () => CustomWidgets.pageRouteCustom(
                                    context,
                                    pageName: Login()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
