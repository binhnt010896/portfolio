import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/screens/home/partials/navigation_button.dart';

class MainNavigation extends StatefulWidget {

  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int hoverIndex = -1;
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NavigationButton(
          title: 'Home',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () => _homeController.scrollToOffset(0),
          index: 0,
          currentIndex: hoverIndex,
        ),
        NavigationButton(
          title: 'Works',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () => _homeController.scrollToOffset(1200),
          index: 1,
          currentIndex: hoverIndex,
        ),
        NavigationButton(
          title: 'Contact me',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () => _homeController.scrollToOffset(3000),
          index: 2,
          currentIndex: hoverIndex,
        ),
      ],
    );
  }
}
