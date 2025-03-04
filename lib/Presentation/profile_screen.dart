import 'package:flutter_ecommerce_155e5/Admin%20Pages/app_amdin_helper.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/loation_model.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  late DistrictModel destrict;
  late int destrictIndex;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  LocationModel? location = FullBDLocations;
  //  LocationModel(destricts: [
  //   DistrictModel(destrict: "Dhaka", upazilas: [
  //     UpazilaModel(upazila: "b", areas: ["c", "d", "e", "f"]),
  //     UpazilaModel(upazila: "g", areas: ["h", "i", "j", "k"]),
  //     UpazilaModel(upazila: "l", areas: [
  //       "m",
  //       "n",
  //       "o",
  //     ])
  //   ]),
  //   DistrictModel(destrict: "Khulna", upazilas: [
  //     UpazilaModel(upazila: "q", areas: ["r", "s", "t", "u"]),
  //     UpazilaModel(upazila: "v", areas: ["w", "x", "y", "z"]),
  //     UpazilaModel(upazila: "a1", areas: [
  //       "b1",
  //       "c1",
  //       "d1",
  //     ])
  //   ]),
  //   DistrictModel(destrict: "e1", upazilas: [
  //     UpazilaModel(upazila: "f1", areas: ["g1", "h1", "i1", "j1"]),
  //     UpazilaModel(upazila: "k1", areas: ["l1", "m1", "n1", "o1"]),
  //     UpazilaModel(upazila: "p1", areas: [
  //       "q1",
  //       "r1",
  //       "s1",
  //     ])
  //   ])
  // ]);

  bool isLocationLoaded = false;

  @override
  void initState() {
    super.initState();
    locationLoaderCaller();
  }

  void locationLoaderCaller() async {
    // location = await CustomBackEnd.firebaseLocationLoader();
    isLocationLoaded = true;
    destrictIndex = 0;
    destrict = location!.destricts[destrictIndex];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: const [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(Icons.shopping_bag),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: (location != null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(minRadius: 50),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Edit Profile"),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Hi there {name}",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Text("Sign out"),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                        child: CustomWidgets.textFormFieldCustom(
                            text: "Name",
                            controller: nameController,
                            validatorFunction: (value) {
                              CustomWidgets.nameValidity(value);
                            })),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                        child: CustomWidgets.textFormFieldCustom(
                            text: "Phone Number",
                            controller: numberController,
                            keyboardType: TextInputType.phone,
                            validatorFunction: (value) {
                              CustomWidgets.numberValidity(value);
                            })),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      height: 55,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          border: Border.all(color: Colors.red, width: 1),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              onChanged: (value) {
                                destrictIndex =
                                    location!.destricts.indexWhere((element) {
                                  return element.destrict == value;
                                });
                                destrict = location!.destricts[destrictIndex];
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                        child: CustomWidgets.textFormFieldCustom(
                            text: "Email",
                            controller: emailController,
                            suffixText: "optional",
                            validatorFunction: (value) {
                              CustomWidgets.emailValidity(value);
                            })),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                        child: CustomWidgets.textFormFieldCustom(
                            text: "Password",
                            controller: passwordController,
                            validatorFunction: (value) {
                              CustomWidgets.passwordValidity(value);
                            })),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomWidgets.elevatedButtonCustom(
                        hintText: "Save", onPressedButton: () {}),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
