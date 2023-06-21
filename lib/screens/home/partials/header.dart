import 'package:flutter/material.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/screens/home/partials/contact_button.dart';
import 'package:portfolio/screens/home/partials/main_navigation.dart';

class Header extends StatefulWidget {

  final ScrollController scrollController;
  const Header({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    return AppBar(
      backgroundColor: isSP
        ? Colors.transparent
        : theme.colorScheme.background,
      elevation: 0,
      toolbarHeight: 80,
      flexibleSpace: Container(
        decoration:
        BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main_visual_bg.png'),
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 48),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Image.asset(
              'assets/images/logo_no_text.png',
              fit: BoxFit.contain,
              height: 50,
            ),
          ),
        ),
      ),
      centerTitle: isSP,
      actions: isSP ? [] : [
        Padding(
          padding: EdgeInsets.only(top: 28, right: 36),
          child: MainNavigation(
            scrollController: widget.scrollController,
          ),
        )
      ],
    );
  }
}
