import 'package:flutter/material.dart';
import 'package:portfolio/screens/home/partials/contact_button.dart';
import 'package:portfolio/screens/home/partials/main_navigation.dart';

class Header extends StatefulWidget {

  final VoidCallback onContactPressed;
  const Header({Key? key, required this.onContactPressed}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: Padding(
        padding: EdgeInsets.only(left: 24),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: Image.asset(
              'assets/images/header_logo_inverted.png',
              fit: BoxFit.contain,
              height: 90,
            ),
          ),
        ),
      ),
      actions: [
        ContactButton(
          onPressed: widget.onContactPressed
        )
      ],
      title: MainNavigation(),
      toolbarHeight: 90,
      leadingWidth: 160,
    );
  }
}
