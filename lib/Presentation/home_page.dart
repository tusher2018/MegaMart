import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_ecommerce_155e5/Presentation/color.dart';
import 'package:flutter_ecommerce_155e5/Presentation/menu_iteam_details_page.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_backend.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_widgets.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/iteam_model.dart';
import 'package:flutter_ecommerce_155e5/modelsPages/menu_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuModelFirebaseSetData? menuIteamList;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: (menuIteamList == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (menuIteamList!.menuIteamList == null ||
                    menuIteamList!.menuIteamList!.isEmpty)
                ? Center(
                    child: customText("No iteams found"),
                  )
                : ListView.builder(
                    itemCount: menuIteamList!.menuIteamList!.length,
                    itemBuilder: (context, index) {
                      return buildCategorySection(
                          menuIteamList!.menuIteamList![index].menuName
                              .toString(),
                          menuIteamList!.menuIteamList![index],
                          index,
                          context);
                    },
                  ));
  }

  Widget buildCategorySection(String title, MenuModel menuModel,
      int sellectedIndex, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: customText(title, size: 18, fontWeigth: FontWeight.bold),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: menuModel.iteams!.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    print(isCartLoaded);
                    if (isCartLoaded == false) {
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    } else {
                      CustomWidgets.slideNavigationLeftToRightPush(
                          MenuIteamDetailsPage(
                              iteamList: iteamList ?? [],
                              iteamModel: menuIteamList!
                                  .menuIteamList![sellectedIndex]
                                  .iteams![index]),
                          context);
                    }
                  },
                  child: buildProductCard(context, menuModel.iteams![index]));
            },
          ),
        ),
      ],
    );
  }

  Widget buildProductCard(BuildContext context, MenuIteamModel menuIteamModel) {
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: menuIteamModel.iteamImagePath.toString()),
                  )),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(menuIteamModel.iteamName.toString(),
                      size: 16,
                      fontWeigth: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                  customText(
                    menuIteamModel.description.toString(),
                    size: 12,
                    maxline: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  customText(
                    'BDT: ${menuIteamModel.price ?? 0.0}',
                    size: 14,
                    color: primaryColor,
                  ),
                  Visibility(
                    visible: (menuIteamModel.discount != null ||
                        (menuIteamModel.discount ?? 0.0) > 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText(
                          'Discount:',
                          size: 14,
                          color: Colors.green,
                        ),
                        customText(
                          '${menuIteamModel.discount}%',
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
}
