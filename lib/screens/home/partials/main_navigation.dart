import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/screens/home/partials/navigation_button.dart';

class MainNavigation extends StatefulWidget {

  final ScrollController scrollController;

  const MainNavigation({Key? key, required this.scrollController}) : super(key: key);

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
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NavigationButton(
          title: 'Home',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () => widget.scrollController.animateTo(0, duration: 500.ms, curve: Curves.easeInBack),
          index: 0,
          currentIndex: hoverIndex,
        ),
        NavigationButton(
          title: 'Works',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () => widget.scrollController.animateTo(size.height*1.4, duration: 500.ms, curve: Curves.easeInBack),
          index: 1,
          currentIndex: hoverIndex,
        ),
        NavigationButton(
          title: 'Contact me',
          onHover: (index) => setState(() => hoverIndex = index),
          onPress: () => widget.scrollController.animateTo(size.height*3.8, duration: 500.ms, curve: Curves.easeInBack),
          index: 2,
          currentIndex: hoverIndex,
        ),
      ],
    );
  }
}
