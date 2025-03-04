import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce_155e5/Admin%20Pages/admin_home_page.dart';
import 'package:flutter_ecommerce_155e5/Admin%20Pages/app_amdin_helper.dart';
import 'package:flutter_ecommerce_155e5/Presentation/aboutus.dart';
import 'package:flutter_ecommerce_155e5/Presentation/color.dart';
import 'package:flutter_ecommerce_155e5/Presentation/login_screen.dart';
import 'package:flutter_ecommerce_155e5/Presentation/myorders.dart';
import 'package:flutter_ecommerce_155e5/Presentation/treams_and_condition.dart';
import 'package:flutter_ecommerce_155e5/customWidgets/custom_text.dart';
import 'package:flutter_ecommerce_155e5/Presentation/menu_page.dart';
import 'package:flutter_ecommerce_155e5/Presentation/home_page.dart';
import 'package:flutter_ecommerce_155e5/Presentation/profile_screen.dart';
import 'package:flutter_ecommerce_155e5/Presentation/cart.dart';
import 'package:flutter_ecommerce_155e5/navigation/custom_navigation.dart';
import 'package:flutter/material.dart';

class DemoForToday extends StatefulWidget {
  const DemoForToday({super.key});

  @override
  State<DemoForToday> createState() => _DemoForTodayState();
}

class _DemoForTodayState extends State<DemoForToday> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0), // Adjust spacing between image and text
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set white background color
                  borderRadius: BorderRadius.circular(
                      50), // Add border radius for rounded corners if needed
                ),
                child: Image.asset(
                  'assets/images/bs_logo.png', // Your image URL
                  width: 40, // Set width as per your requirement
                  height: 40, // Set height as per your requirement
                ),
              ),
            ),
            customTextMain("Mega Mart", color: Colors.white, size: 21),
          ],
        ),
      ),
      body: <Widget>[
        const HomePage(),
        const FoodMenu(),
        const Cart(),
        const MyOrders()
      ][currentPageIndex],

      // bottomNavigationBar: BottomNavigation.bottomNavigationBar(context),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black,
        elevation: 20,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.redAccent[300],
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Image.asset(
              "assets/bottomNavigationAssets/home.png",
              height: 25,
              width: 25,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Image.asset(
              "assets/bottomNavigationAssets/menu.png",
              height: 25,
              width: 25,
            ),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Image.asset(
              "assets/bottomNavigationAssets/orders.png",
              height: 25,
              width: 25,
            ),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Image.asset(
              "assets/bottomNavigationAssets/orders.png",
              height: 25,
              width: 25,
            ),
            label: 'Orders',
          ),
        ],
      ),
      endDrawer: Drawer(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: Center(child: customTextMain("All Menus")),
            ),
            const Divider(),
            ListTile(
              title: customTextMain('Profile'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                Navigator.pop(context);
                slideNavigationPush(const Profile(), context);
              },
            ),
            ListTile(
              title: customTextMain('About Us'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                Navigator.pop(context);
                slideNavigationPush(const AboutUsPage(), context);
              },
            ),
            ListTile(
              title: customTextMain('Terms & Conditions'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                Navigator.pop(context);
                slideNavigationPush(const TermsAndConditionsPage(), context);
              },
            ),
            Visibility(
              visible: FirebaseAuth.instance.currentUser!.uid == appId,
              child: ListTile(
                title: customTextMain('Admin Panel', color: primaryColor),
                trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () {
                  Navigator.pop(context);
                  slideNavigationPush(const AdminHomePage(), context);
                },
              ),
            ),
            ListTile(
              title: customTextMain('Signout', color: Colors.redAccent),
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sign out failed: $e'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
