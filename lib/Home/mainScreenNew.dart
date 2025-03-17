import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'homeScreen.dart';

class MainScreenNew extends StatefulWidget {
  const MainScreenNew({Key? key}) : super(key: key);

  @override
  State<MainScreenNew> createState() => _MainScreenNewState();
}

class _MainScreenNewState extends State<MainScreenNew> {
  late PersistentTabController _controller;
  // _controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();

  }

  // Define the screens for each tab
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
    ];
  }

  // Define the items for the BottomNavigationBar
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: _buildIcon(
          'assets/icons/bottom_home_unselected.png',
          'assets/icons/bottom_home_selected.png',
          'assets/images/bottom_home_bg.png',
          _controller.index == 0,
        ),
        title: ("Home"),
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: _buildIcon(
          'assets/icons/bottom_dinein_unselected.png',
          'assets/icons/bottom_dinein_selected.png',
          'assets/images/bottom_dinein_bg.png',
          _controller.index == 1,
        ),
        title: ("Dine In"),
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: _buildIcon(
          'assets/icons/bottom_explore_unselected.png',
          'assets/icons/bottom_explore_selected.png',
          'assets/images/bottom_explore_bg.png',
          _controller.index == 2,
        ),
        title: ("Explore"),
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: _buildIcon(
          'assets/icons/bottom_reward_unselected.png',
          'assets/icons/bottom_reward_selected.png',
          'assets/images/bottom_reward_bg.png',
          _controller.index == 3,
        ),
        title: ("Reward"),
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: _buildIcon(
          'assets/icons/bottom_settings_unselected.png',
          'assets/icons/bottom_settings_selected.png',
          'assets/images/bottom_settings_bg.png',
          _controller.index == 4,
        ),
        title: ("Settings"),
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
    ];
  }

  // Build the icon with the selected background
  Widget _buildIcon(String unselectedIcon, String selectedIcon, String selectedBackground, bool isSelected) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isSelected)
          Positioned(
            child: Image.asset(
              selectedBackground, // Show background image for the selected item
              width: 60,
              height: 60,
            ),
          ),
        Image.asset(
          isSelected ? selectedIcon : unselectedIcon, // Change icon based on selection
          width: 24,
          height: 24,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller, // Persistent controller
      screens: _buildScreens(), // Screens corresponding to each tab
      items: _navBarsItems(), // Custom items for bottom navigation
      navBarStyle: NavBarStyle.style1, // Use the simplest nav bar style
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      /*itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),

      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),*/
      onItemSelected: (index) {
        setState(() {
          _controller.index = index;// Update the selected index
        });
      },
    );
  }
}

/*class PersistentTabController {
}*/

// Additional Screens that are navigated from Bottom Navigation Tabs
