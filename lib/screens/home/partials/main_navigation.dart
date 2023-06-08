import 'package:flutter/material.dart';
import 'package:portfolio/screens/home/partials/navigation_button.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int hoverIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NavigationButton(
          title: 'Home',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () {

          },
          index: 0,
          currentIndex: hoverIndex,
        ),
        NavigationButton(
          title: 'Works',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () {

          },
          index: 1,
          currentIndex: hoverIndex,
        ),
        NavigationButton(
          title: 'Skills',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () {

          },
          index: 2,
          currentIndex: hoverIndex,
        ),
        NavigationButton(
          title: 'About',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () {

          },
          index: 3,
          currentIndex: hoverIndex,
        ),
      ],
    );
  }
}
