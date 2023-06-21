import 'package:flutter/material.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/screens/home/partials/header.dart';
import 'package:portfolio/screens/home/sections/cta.dart';
import 'package:portfolio/screens/home/sections/main_visual.dart';
import 'package:portfolio/screens/home/sections/selected_projects.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ScrollController scrollController = ScrollController();
  bool shouldShowScrollToTop = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset > 100 && !shouldShowScrollToTop) {
        setState(() => shouldShowScrollToTop = true);
      }
      if (scrollController.offset <= 100 && shouldShowScrollToTop) {
        setState(() => shouldShowScrollToTop = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 90),
        child: Header(
          scrollController: scrollController,
        ),
      ),
      floatingActionButton: shouldShowScrollToTop ? FloatingActionButton(
        child: Icon(Icons.arrow_upward_rounded),
        onPressed: () {
          scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeInBack);
        },
      ) : null,
      extendBodyBehindAppBar: isSP,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainVisualSection(),
            SelectedProjectsSection(),
            CTASection(),
          ],
        ),
      ),
    );
  }
}
