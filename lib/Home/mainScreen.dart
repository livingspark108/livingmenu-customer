import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Cart/cart.dart';
import 'package:living_menu_mobile/DineIn/dineIn.dart';
import 'package:living_menu_mobile/Explore/explore.dart';
import 'package:living_menu_mobile/Reward/rewardInfo.dart';
import 'package:living_menu_mobile/Reward/rewards.dart';
import 'package:living_menu_mobile/Settings/settings.dart';

import 'homeScreen.dart';

class  MainScreen extends StatefulWidget {
const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  late double w, h;

  int _selectedIndex = 0; // Current selected index of the bottom nav bar

  // List of screens that are linked to the BottomNavigationBar
  final List<Widget> _screens = [
    HomeScreen(),
    DineIn(),
    Explore(),
    // RewardInfo(),
    Rewards(),
    Settings(),
  ];

  final List<Map<String, dynamic>> _bottomNavBarItems = [
    {
      'label': 'Home',
      'icon': 'assets/icons/bottom_home_unselected.png', // Path to your custom icon
      'selectedIcon': 'assets/icons/bottom_home_selected.png',
      'selectedBackground': 'assets/images/bottom_home_bg.png',// Path to your selected icon
    },
    {
      'label': 'Dine In',
      'icon': 'assets/icons/bottom_dinein_unselected.png',
      'selectedIcon': 'assets/icons/bottom_dinein_selected.png',
      'selectedBackground': 'assets/images/bottom_dinein_bg.png',
    },
    {
      'label': 'Explore',
      'icon': 'assets/icons/bottom_explore_unselected.png',
      'selectedIcon': 'assets/icons/bottom_explore_selected.png',
      'selectedBackground': 'assets/images/bottom_explore_bg.png',
    },
    {
      'label': 'Reward',
      'icon': 'assets/icons/bottom_reward_unselected.png',
      'selectedIcon': 'assets/icons/bottom_reward_selected.png',
      'selectedBackground': 'assets/images/bottom_reward_bg.png',
    },
    {
      'label': 'Settings',
      'icon': 'assets/icons/bottom_settings_unselected.png',
      'selectedIcon': 'assets/icons/bottom_settings_selected.png',
      'selectedBackground': 'assets/images/bottom_settings_bg.png',
    },
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // _navigateTo(_bottomNavBarItems[index]['label']);
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _screens[_selectedIndex], // Show the selected screen
      bottomNavigationBar: Container(
        height: h * 0.134, // Set fixed height for the BottomNavigationBar
        child: BottomNavigationBar(
          elevation: 0,
          items: _bottomNavBarItems.map((item) {
            int index = _bottomNavBarItems.indexOf(item);
            bool isSelected = _selectedIndex == index;

            return BottomNavigationBarItem(
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  // Show background image only for the selected icon + label

                  if (isSelected)
                    Positioned(
                      child: Image.asset(
                        item['selectedBackground'], // Background image for the selected item
                        width: 60,
                        height: 60,
                      ),
                    ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        isSelected ? item['selectedIcon'] : item['icon'], // Change icon when selected
                        width: 24, // Adjust icon size
                        height: 24,
                      ),
                      SizedBox(height: 5,),
                      Text(
                        item['label'],
                        style: TextStyle(
                          color: isSelected ? Color(0xFF001FFF) : Colors.black, // Change label color when selected
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              label: '', // Remove default label
            );
          }).toList(),
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF001FFF), // Change selected icon & label color
          unselectedItemColor: Colors.black, // Change unselected icon & label color
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed, // Ensure all items are shown
        ),
      ),
    );
  }
}
