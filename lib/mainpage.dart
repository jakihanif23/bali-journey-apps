import 'package:custom_top_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:wisata_bali/icons/custom_icons_icons.dart';
import 'package:wisata_bali/pages/cartpage.dart';
import 'package:wisata_bali/pages/homepage.dart';
import 'package:wisata_bali/pages/packagetrip.dart';
import 'package:wisata_bali/pages/wishlistpage.dart';

import 'pages/searchpage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [Home(), Wishlist(), PackageTrip(), Search(), CartPage()];
  int current = 0;

  void onTap(int index) {
    setState(() {
      current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScaffold(
          children: pages,
          onItemTap: onTap,
          scaffold: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xff136068),
              selectedFontSize: 10,
              unselectedFontSize: 10,
              unselectedItemColor: Colors.grey,
              currentIndex: current,
              backgroundColor: Color(0xfff5f4f4),
              items: [
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.home_filled),
                    icon: Icon(Icons.home_outlined),
                    label: "Home"),
                BottomNavigationBarItem(
                    activeIcon: Icon(CustomIcons.heart),
                    icon: Icon(CustomIcons.heart_empty),
                    label: "Wishlist"),
                BottomNavigationBarItem(
                    activeIcon: Icon(CustomIcons.mountain),
                    icon: Icon(CustomIcons.mountain),
                    label: 'Package Trip'),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.saved_search_sharp),
                    icon: Icon(Icons.search),
                    label: "Search"),
                BottomNavigationBarItem(
                    activeIcon: Icon(Icons.shopping_cart),
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: "Cart"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
