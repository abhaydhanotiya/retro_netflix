import 'package:retro_netflix/Screens/HomeScreen/Search/search.dart';
import 'package:retro_netflix/Screens/HomeScreen/shows.dart';
import 'package:flutter/material.dart';
import 'package:retro_netflix/Constants/constant.dart';
import 'package:retro_netflix/Screens/Settings/settings.dart';

class Home extends StatefulWidget {
  int? index;
  Home({required this.index});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final List<Widget> pages = [ShowsScreen(), SearchScreen(), Settings()];
  @override
  void initState() {
    super.initState();
    currentIndex = widget.index!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // Use IndexedStack to keep all pages in the widget tree but only render the selected one
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.blackColor,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.backgroundColor,
        onTap: (index) {
          // Use setState to trigger a rebuild and update the UI
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Shows',
            activeIcon: Icon(Icons.dashboard, color: AppColors.primaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            activeIcon: Icon(Icons.search, color: AppColors.primaryColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            activeIcon: Icon(Icons.settings, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
