import 'package:flutter_ecommerce_155e5/Presentation/color.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/Presentation/login_screen.dart';
import 'package:flutter_ecommerce_155e5/Presentation/signup_screen.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            //Image.asset("assets/images/splash_background.png"),
            Column(children: [
              Expanded(child: Image.asset("assets/images/bs_logo.png")),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                              text: "MEGA",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2),
                              children: [
                                TextSpan(
                                    text: " MART",
                                    style: TextStyle(
                                        color: blackColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2))
                              ]),
                        ),
                        const Text("Online Shop",
                            style: TextStyle(
                              fontSize: 11,
                              letterSpacing: 4,
                              height: 3,
                            )),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 250,
                      child: Column(
                        children: [
                          ListTile(
                              subtitle: Text(
                            "Discover the best product from our shop and fast delivery to your doorstep",
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 2,
                            child: CustomWidgets.elevatedButtonCustom(
                                hintText: "Login",
                                onPressedButton: () {
                                  CustomWidgets.pageRouteCustom(context,
                                      pageName: Login());
                                })),
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                            flex: 2,
                            child: SizedBox(
                                width: 250,
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: WidgetStateProperty.all(const BorderSide(
                                        color:
                                            primaryColor)), // Set border color to red
                                  ),
                                  child: const Text(
                                    "Create an Account",
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  onPressed: () {
                                    CustomWidgets.pageRouteCustom(context,
                                        pageName: SignUp());
                                  },
                                ))),
                        const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              )),
            ]),
          ],
        ),
      ),
    );
  }
}
