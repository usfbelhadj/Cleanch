import 'package:flutter/material.dart';
import 'package:myflutter/src/features/app/events/events_page.dart';
import 'package:myflutter/src/features/app/profile/user_profile.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import 'package:url_launcher/url_launcher.dart';

class BottomNavBarCurvedFb1 extends StatefulWidget {
  final VoidCallback onLocationButtonPressed;
  final VoidCallback onServicesButtonPressed;
  final bool isHomeScreen;
  final VoidCallback onReportButtonPressed; // Add this callback

  const BottomNavBarCurvedFb1({
    Key? key,
    required this.onLocationButtonPressed,
    required this.onServicesButtonPressed,
    required this.isHomeScreen,
    required this.onReportButtonPressed, // Add this line
  }) : super(key: key);

  @override
  _BottomNavBarCurvedFb1State createState() => _BottomNavBarCurvedFb1State();
}

class _BottomNavBarCurvedFb1State extends State<BottomNavBarCurvedFb1> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0; // Store the selected index

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    const secondaryColor = Color(0XFFA7A7A7);

    const selectedColor = Color.fromARGB(255, 5, 228, 98);

    var backgroundColor = Color(0XFFFFFFFF);

    return Material(
      color: Colors.transparent,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        margin: EdgeInsets.only(bottom: 20.0, left: 5.0, right: 0.0),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: NavBarIcon(
                  text: tr('EventsText'),
                  icon: Icons.warning_amber_outlined,
                  selected: _selectedIndex == 1, // Check if it's selected
                  onPressed: () {
                    if (ModalRoute.of(context)!.settings.name !=
                        EventsPage.routeName) {
                      setState(() {
                        _selectedIndex = 1; // Update the selected index
                        // go to user profile page
                        Navigator.pushNamed(context, EventsPage.routeName);
                      });
                    }
                  },
                  defaultColor: secondaryColor,
                  selectedColor: selectedColor,
                ),
              ),
              Flexible(
                flex: 0,
                fit: FlexFit.tight,
                child: Container(
                  height: 40, // Set the height of the divider container
                  child: VerticalDivider(
                    color: Colors.black, // Customize divider color
                    thickness: 1, // Customize divider thickness
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: NavBarIcon(
                  text: tr('MapTxt'),
                  icon: Icons.map_outlined,
                  selected: _selectedIndex == 2, // Check if it's selected
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2; // Update the selected index
                      // go to user profile page
                    });
                  },
                  defaultColor: secondaryColor,
                  selectedColor: selectedColor,
                ),
              ),
              Flexible(
                flex: 0,
                fit: FlexFit.tight,
                child: Container(
                  height: 40, // Set the height of the divider container
                  child: VerticalDivider(
                    color: Colors.black, // Customize divider color
                    thickness: 1, // Customize divider thickness
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: NavBarIcon(
                  text: tr('settingText'),
                  icon: Icons.settings_outlined,
                  selected: _selectedIndex == 3, // Check if it's selected
                  onPressed: () {
                    if (ModalRoute.of(context)!.settings.name !=
                        UserProfile.routeName) {
                      setState(() {
                        _selectedIndex = 3; // Update the selected index
                        // go to user profile page
                        Navigator.pushNamed(context, UserProfile.routeName);
                      });
                    }
                  },

                  defaultColor: secondaryColor,
                  selectedColor: selectedColor,
                ),
              ),
              Flexible(
                flex: 0,
                fit: FlexFit.tight,
                child: Container(
                  height: 40, // Set the height of the divider container
                  child: VerticalDivider(
                    color: Colors.black, // Customize divider color
                    thickness: 1, // Customize divider thickness
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: NavBarIcon(
                  text: tr('callTxt'),
                  icon: Icons.phone_outlined,
                  selected: _selectedIndex == 5, // Check if it's selected
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 5; // Update the selected index
                    });
                    String phoneNumber = "+41 79 123 45 67";
                    // ignore: deprecated_member_use
                    launch("tel:$phoneNumber");
                  },
                  defaultColor: secondaryColor,
                  selectedColor: selectedColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    Key? key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
    this.selectedColor = const Color(0xffFF8527),
    this.defaultColor = const Color.fromARGB(137, 219, 11, 11),
  }) : super(key: key);

  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
        side: BorderSide.none,
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20.0,
                color: Color(0XFFA7A7A7),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 10,
                  color: defaultColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
