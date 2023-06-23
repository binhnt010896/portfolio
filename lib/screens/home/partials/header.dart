import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/data/images.dart';
import 'package:portfolio/screens/home/partials/main_navigation.dart';

class Header extends StatefulWidget {

  const Header({Key? key}) : super(key: key);

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
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 80,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetImages.mainVisualBg),
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
            child: SvgPicture.asset(AssetImages.logoPrimary, height: 50, fit: BoxFit.contain),
          ),
        ),
      ),
      centerTitle: isSP,
      actions: isSP ? [] : [
        Padding(
          padding: EdgeInsets.only(top: 28, right: 36),
          child: MainNavigation(),
        )
      ],
    );
  }
}
