import 'package:flutter/material.dart';
import 'package:portfolio/helpers/scroll_overseer.dart';
import 'package:portfolio/screens/home/partials/header.dart';
import 'package:portfolio/screens/home/sections/contact.dart';
import 'package:portfolio/screens/home/sections/educations.dart';
import 'package:portfolio/screens/home/sections/selected_projects.dart';
import 'package:portfolio/screens/home/sections/skill_stack.dart';
import 'package:portfolio/screens/home/sections/main_visual.dart';
import 'package:provider/provider.dart';
import 'package:snapping_page_scroll/snapping_page_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      Provider.of<ScrollOverseer>(context, listen: false).updatePage(pageController.page ?? 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            Header(onContactPressed: () {
              pageController.jumpToPage(4);
            })
          ];
        },
        body: SnappingPageScroll(
          scrollDirection: Axis.vertical,
          controller: pageController,
          children: [
            MainVisualSection(),
            SkillStackSection(),
            EducationSection(),
            SelectedProjectsSection(),
            ContactSection()
          ],
        ),
      ),
    );
  }
}
