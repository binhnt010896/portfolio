import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/controllers/home_controller.dart';
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

  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _homeController.getScrollController().addListener(() {
      if (_homeController.getScrollController().offset > 100 && !_homeController.getShouldScrollToTop()) {
        _homeController.setShouldScrollToTop(true);
      }
      if (_homeController.getScrollController().offset <= 100 && _homeController.getShouldScrollToTop()) {
        _homeController.setShouldScrollToTop(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: Size(size.width, 90),
          child: Header(),
        ),
        floatingActionButton: _homeController.getShouldScrollToTop() ? FloatingActionButton(
          elevation: 0,
          hoverElevation: 0,
          child: Icon(Icons.arrow_upward_rounded),
          onPressed: () {
            _homeController.scrollToOffset(0);
          },
        ) : null,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          controller: _homeController.getScrollController(),
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
      ),
    );
  }
}
