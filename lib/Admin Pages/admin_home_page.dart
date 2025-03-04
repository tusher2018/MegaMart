import 'package:flutter_ecommerce_155e5/Admin%20Pages/addCatagory.dart';
import 'package:flutter_ecommerce_155e5/Admin%20Pages/app_amdin_helper.dart';
import 'package:flutter_ecommerce_155e5/Admin%20Pages/iteam_customization.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/loation_model.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/menu_model.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_backend.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_text.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/demo_for_today.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  MenuModelFirebaseSetData? myMenuIteamList;

  LocationModel? myLocations = FullBDLocations;

  void menuLoaderCaller() async {
    myMenuIteamList = await CustomBackEnd.firebaseMenuLoader();
    // myLocations = await CustomBackEnd.firebaseLocationLoader();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    menuLoaderCaller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home Page'),
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width, 20),
            child: InkWell(
              onTap: () {
                CustomWidgets.pageRouteCustom(context,
                    onlyPush: true,
                    pageName: AddCatagory(
                        myMenuIteamList: myMenuIteamList,
                        enable: true,
                        myLocations: FullBDLocations));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add), Text("Add a catagory")],
              ),
            )),
      ),
      body: (myMenuIteamList != null && myMenuIteamList!.menuIteamList != null)
          ? ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  height: 2,
                  color: Colors.black,
                );
              },
              itemCount: myMenuIteamList!.menuIteamList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                            myMenuIteamList!.menuIteamList![index].menuName
                                .toString(),
                            size: 18.0),
                        InkWell(
                          onTap: () {
                            CustomWidgets.pageRouteCustom(context,
                                onlyPush: true,
                                pageName: AddCatagory(
                                    myMenuIteamList: myMenuIteamList,
                                    enable: false,
                                    catagoriName: myMenuIteamList!
                                        .menuIteamList![index].menuName
                                        .toString(),
                                    myLocations: myLocations));
                          },
                          child: const CircleAvatar(
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: 250,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 10,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: myMenuIteamList!
                            .menuIteamList![index].iteams!.length,
                        itemBuilder: (context, index2) {
                          MenuIteamModel iteam = myMenuIteamList!
                              .menuIteamList![index].iteams![index2];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.teal.shade50,
                            ),
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        CustomWidgets.pageRouteCustom(context,
                                            onlyPush: true,
                                            pageName: IteamCustomization(
                                              myMenuIteamList: myMenuIteamList,
                                              catagoryName: myMenuIteamList!
                                                  .menuIteamList![index]
                                                  .menuName
                                                  .toString(),
                                              iteam: iteam,
                                            )).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            height: 200,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10.0),
                                                      bottomRight:
                                                          Radius.circular(10.0),
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                      topRight: Radius.circular(
                                                          30.0)),
                                              child: CachedNetworkImage(
                                                width: 200,
                                                height: 200,
                                                imageUrl: iteam.iteamImagePath!
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: customText(
                                                iteam.iteamName.toString(),
                                                size: 16.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        myMenuIteamList!
                                            .menuIteamList![index].iteams!
                                            .removeAt(index2);

                                        deleteMenuIteam();
                                      },
                                      child: const CircleAvatar(
                                        child: Icon(Icons.delete_forever),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                      onTap: () {
                                        CustomWidgets.pageRouteCustom(context,
                                            onlyPush: true,
                                            pageName: IteamCustomization(
                                              myMenuIteamList: myMenuIteamList,
                                              catagoryName: myMenuIteamList!
                                                  .menuIteamList![index]
                                                  .menuName
                                                  .toString(),
                                              iteam: iteam,
                                            ));
                                      },
                                      child: customText(
                                        "Edit",
                                        color: Colors.red,
                                      )),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                );
              },
            )
          : Container(),
      drawer: Drawer(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset("assets/images/bs_logo.png", height: 100),
            ),
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        "https://scontent.fdac5-1.fna.fbcdn.net/v/t39.30808-6/415052404_1792805927834061_3173579390469850681_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=lnQRwviNzqsAX-Xw3xr&_nc_ht=scontent.fdac5-1.fna&oh=00_AfAUmEGXFxy2LFKHymyXR-AYeGl0MCxNBDY_wG-0nTcmGg&oe=65CCC4D2",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              ),
              title: customTextMain('Shakil Sheikh'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {},
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: customTextMain("All Menus"),
            ),
            const Divider(),
            ListTile(
              title: customTextMain('Home Page'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: customTextMain('User App'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                CustomWidgets.pageRouteCustom(context,
                    pageName: const DemoForToday());
              },
            ),
            ListTile(
              title: customTextMain('Terms & Conditions'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {},
            ),
            ListTile(
              title: customTextMain('Signout', color: Colors.redAccent),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void deleteMenuIteam() {
    FirebaseFirestore.instance
        .collection("Menus")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(myMenuIteamList!.toMap())
        .then(((value) {
      setState(() {});
    }));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
