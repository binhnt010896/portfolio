import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/screens/home/partials/header.dart'
    deferred as deferred_header;
import 'package:portfolio/screens/home/sections/cta.dart'
    deferred as deferred_cta;
import 'package:portfolio/screens/home/sections/main_visual.dart'
    deferred as deferred_main_visual;
import 'package:portfolio/screens/home/sections/selected_projects.dart'
    deferred as deferred_selected_projects;
import 'package:scroll_to_id/scroll_to_id.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());

  final Future<void> loadHeader = deferred_header.loadLibrary();
  final Future<void> loadMainVisual = deferred_main_visual.loadLibrary();
  final Future<void> loadSelectedProjects =
      deferred_selected_projects.loadLibrary();
  final Future<void> loadCTA = deferred_cta.loadLibrary();

  @override
  void initState() {
    super.initState();
    _homeController.getScrollController().addListener(() {
      if (_homeController.getScrollController().offset > 100 &&
          !_homeController.getShouldScrollToTop()) {
        _homeController.setShouldScrollToTop(true);
      }
      if (_homeController.getScrollController().offset <= 100 &&
          _homeController.getShouldScrollToTop()) {
        _homeController.setShouldScrollToTop(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
          preferredSize: Size(size.width, 90),
          child: FutureBuilder(
            future: loadHeader,
            builder: (context, snapshot) => deferred_header.Header(),
          ),
        ),
        floatingActionButton: _homeController.getShouldScrollToTop()
            ? FloatingActionButton(
                elevation: 0,
                hoverElevation: 0,
                child: Icon(Icons.arrow_upward_rounded),
                onPressed: () {
                  _homeController.scrollToOffset(0);
                },
              )
            : null,
        extendBodyBehindAppBar: true,
        body: InteractiveScrollViewer(
          scrollToId: _homeController.scrollToId.value,
          children: [
            ScrollContent(
              id: 'main_visual',
              child: FutureBuilder(
                future: loadMainVisual,
                builder: (context, snapshot) =>
                    deferred_main_visual.MainVisualSection(),
              ),
            ),
            ScrollContent(
              id: 'selected_projects',
              child: FutureBuilder(
                future: loadSelectedProjects,
                builder: (context, snapshot) =>
                    deferred_selected_projects.SelectedProjectsSection(),
              ),
            ),
            ScrollContent(
              id: 'cta',
              child: FutureBuilder(
                future: loadCTA,
                builder: (context, snapshot) => deferred_cta.CTASection(),
              ),
            ),
          ],
          // child: SingleChildScrollView(
          //   controller: _homeController.getScrollController(),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
