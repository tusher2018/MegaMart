import 'package:flutter_ecommerce_155e5/Presentation/color.dart';
import 'package:flutter_ecommerce_155e5/Presentation/menu_iteam_details_page.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_backend.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_text.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/iteam_model.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/menu_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FoodMenu extends StatefulWidget {
  const FoodMenu({super.key});

  @override
  _FoodMenu createState() => _FoodMenu();
}

class _FoodMenu extends State<FoodMenu> {
  PageController pageController = PageController();
  MenuModelFirebaseSetData? menuIteamList;
  //     MenuModelFirebaseSetData(menuIteamList: [
  //   MenuModel(menuName: "breakfast", uid: "0123", iteams: [
  //     MenuIteamModel(iteamName: "b1", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b2", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b3", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b4", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b5", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b6", iteamImagePath: "aaa"),
  //   ]),
  //   MenuModel(menuName: "Dinner", uid: "234", iteams: [
  //     MenuIteamModel(iteamName: "d1", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d2", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d3", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d4", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d5", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d6", iteamImagePath: "aaa"),
  //   ]),
  //   MenuModel(menuName: "desert", uid: "0123", iteams: [
  //     MenuIteamModel(iteamName: "b1", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b2", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b3", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b4", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b5", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b6", iteamImagePath: "aaa"),
  //   ]),
  //   MenuModel(menuName: "lunch", uid: "234", iteams: [
  //     MenuIteamModel(iteamName: "d1", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d2", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d3", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d4", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d5", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d6", iteamImagePath: "aaa"),
  //   ]),
  //   MenuModel(menuName: "milk", uid: "0123", iteams: [
  //     MenuIteamModel(iteamName: "b1", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b2", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b3", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b4", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b5", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b6", iteamImagePath: "aaa"),
  //   ]),
  //   MenuModel(menuName: "food", uid: "234", iteams: [
  //     MenuIteamModel(iteamName: "d1", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d2", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d3", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d4", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d5", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d6", iteamImagePath: "aaa"),
  //   ]),
  //   MenuModel(menuName: "mango", uid: "0123", iteams: [
  //     MenuIteamModel(iteamName: "b1", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b2", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b3", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b4", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b5", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "b6", iteamImagePath: "aaa"),
  //   ]),
  //   MenuModel(menuName: "Dinner", uid: "234", iteams: [
  //     MenuIteamModel(iteamName: "d1", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d2", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d3", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d4", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d5", iteamImagePath: "aaa"),
  //     MenuIteamModel(iteamName: "d6", iteamImagePath: "aaa"),
  //   ]),
  // ]);

  List<IteamModel>? iteamList;
  bool isCartLoaded = false;

  @override
  void initState() {
    super.initState();
    MenuLoaderCaller();
    cartListLoaderCaller();
  }

  void cartListLoaderCaller() async {
    iteamList = await CustomBackEnd.fetchCartIteamModelsFromFirestore();
    isCartLoaded = true;
    setState(() {});
  }

  void MenuLoaderCaller() async {
    menuIteamList = await CustomBackEnd.firebaseMenuLoader();
    setState(() {});
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.maxFinite, 80),
            child: (menuIteamList != null)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            itemCount: menuIteamList!.menuIteamList!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20, top: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          menuIteamList!
                                              .menuIteamList![index].menuName!,
                                          style: TextStyle(
                                            color: selectedIndex == index
                                                ? primaryColor
                                                : Colors
                                                    .black, // Change text color based on selectedIndex
                                          ),
                                        ),
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.only(top: 4),
                                          height: 2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              menuIteamList!
                                                  .menuIteamList!.length,
                                          color: selectedIndex == index
                                              ? primaryColor
                                              : Colors.transparent,
                                        ),
                                      ],
                                    )),
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    pageController.animateToPage(index,
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.ease);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        const Card(
                          shadowColor: Colors.black,
                          child: SizedBox(
                            height: 5,
                            width: double.infinity,
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox()),
        body: (menuIteamList != null)
            ? PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                controller: pageController,
                itemCount: menuIteamList!.menuIteamList!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    // color: Colors.blue,
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 150 / 250, crossAxisCount: 2),
                      itemCount: menuIteamList!
                          .menuIteamList![selectedIndex].iteams!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print(isCartLoaded);
                            if (isCartLoaded == false) {
                              // showDialog(
                              //   context: context,
                              //   barrierColor: Colors.transparent,
                              //   builder: (context) {
                              //     return const Center(
                              //       child: CircularProgressIndicator(),
                              //     );
                              //   },
                              // );
                            } else {
                              CustomWidgets.slideNavigationLeftToRightPush(
                                  MenuIteamDetailsPage(
                                      iteamList: iteamList ?? [],
                                      iteamModel: menuIteamList!
                                          .menuIteamList![selectedIndex]
                                          .iteams![index]),
                                  context);
                            }
                          },
                          child: iteamDesign(menuIteamList!
                              .menuIteamList![selectedIndex].iteams![index]),
                        );
                      },
                    ),
                  );
                })
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

Widget iteamDesign(MenuIteamModel iteamModel) {
  return Card(
    margin: const EdgeInsets.all(8.0),
    child: Container(
      width: 150,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
                width: 150,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: iteamModel.iteamImagePath.toString()),
                )),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(iteamModel.iteamName.toString(),
                    size: 16,
                    fontWeigth: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                customText(
                  iteamModel.description.toString(),
                  size: 12,
                  maxline: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                customText(
                  'BDT: ${iteamModel.price.toString()}',
                  size: 14,
                  color: primaryColor,
                ),
                Visibility(
                  visible: (iteamModel.discount != null ||
                      (iteamModel.discount ?? 0.0) > 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        'Discount:',
                        size: 14,
                        color: Colors.green,
                      ),
                      customText(
                        '${iteamModel.discount}%',
                        size: 14,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
