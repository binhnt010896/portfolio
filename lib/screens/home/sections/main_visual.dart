import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/data/images.dart';
import 'package:portfolio/helpers/ga.dart';
import 'package:portfolio/screens/home/sections/skill_stack.dart';
import 'dart:js' as js;

import 'package:portfolio/widgets/action_button.dart';

class MainVisualSection extends StatefulWidget {
  const MainVisualSection({Key? key}) : super(key: key);

  @override
  State<MainVisualSection> createState() => _MainVisualSectionState();
}

enum LogoName { FLUTTER, REACT }

class _MainVisualSectionState extends State<MainVisualSection> {
  bool onHoverReact = false;
  bool onHoverFlutter = true;

  Widget _renderBackgroundImage(String imageName, LogoName type) {
    Size size = MediaQuery.of(context).size;
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    if (isSP) {
      return Image.asset(imageName,
          color: Color(0xFF434C55),
          height: type == LogoName.FLUTTER ? 600 : 200);
    }
    return Image.asset(imageName, color: Color(0xFF434C55), height: 200)
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(delay: 1500.ms, duration: 1500.ms)
        .moveY(begin: 20, end: 0, duration: 1500.ms)
        .moveY(begin: 0, end: 20, delay: 0.ms, duration: 1500.ms)
        .animate(
          target: type == LogoName.FLUTTER ? 1 : 0,
        )
        .blur(begin: Offset(0, 5))
        .scaleXY(end: 3, duration: 600.ms)
        .animate(
          target: type == LogoName.REACT ? 1 : 0,
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    double mainVisualHeight = 1000;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        /// React and Flutter Logo
        Container(
          height: 1000,
          padding: EdgeInsets.only(top: isSP ? 0 : 120),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _renderBackgroundImage(
                    AssetImages.reactLogoWhite, LogoName.REACT),
              ),
              Expanded(
                child: _renderBackgroundImage(
                    AssetImages.flutterLogoWhite, LogoName.FLUTTER),
              ),
            ],
          ),
        ),

        /// Image Background
        Column(
          children: [
            Container(
              height: mainVisualHeight,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AssetImages.mainVisualBg),
                      fit: BoxFit.cover)),
            ),
            Container(height: isSP ? 900 : 300)
          ],
        ),

        /// Content
        Positioned(
            top: 120,
            child: SizedBox(
              width: isSP ? size.width - 16 : size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Mobile Developer\n(Dart - Flutter)',
                      style: theme.textTheme.headlineLarge,
                      textAlign: TextAlign.center),
                  SizedBox(height: 16),
                  isSP
                      ? Container()
                      : Text(
                          'Unlocking Possibilities Across iOS and Android Platforms\nDelivering Exceptional Mobile Experiences with Dart and Flutter.',
                          textAlign: TextAlign.center),
                  Container(
                    padding: EdgeInsets.only(top: 24, bottom: 24, left: 24),
                    height: 200,
                    width: 200,
                    child: Badge(
                      label: SvgPicture.asset(AssetImages.badge, height: 48),
                      backgroundColor: Colors.transparent,
                      largeSize: 24,
                      alignment: Alignment.bottomRight,
                      offset: Offset(-54, 0),
                      child: Image.asset(AssetImages.avatar),
                    ),
                  ),
                  Text('Hi, I\'m Binh.\nBut you can call me George!',
                      style: theme.textTheme.headlineLarge,
                      textAlign: TextAlign.center),
                  SizedBox(height: 16),
                  SizedBox(
                    width: isSP ? size.width - 32 : size.width * .36,
                    child: Text(
                      '4+ years of experience as Mobile Application Developer with Computer Science B/S. Hands-on leadership experience, proficient in both extensive cross-functional collaboration and working independently.\n\nResearch-driven approach to problem-solving with intuitive knowledge to acquire new technologies & industry trends for professional advancement. ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 36),
                  ActionButton(
                      text: 'Download Resume',
                      icon: Icon(
                        Icons.download_rounded,
                        size: 16,
                      ),
                      onPressed: () {
                        sendAnalyticsEvent(GAEvent.CLICK_DOWNLOAD_CV, {});
                        js.context.callMethod('open', [
                          'https://drive.google.com/file/d/10bFBc6bL27yH70KjqqzUobxtccVNkagj/view'
                        ]);
                      }),
                  SizedBox(height: 48),
                  SkillStackSection()
                ],
              ),
            )),

        /// Hover detector
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Expanded(
        //       child: Container(
        //         height: size.height,
        //         margin: EdgeInsets.symmetric(horizontal: size.width*0.15),
        //         child: MouseRegion(
        //           onEnter: (event) {
        //             setState(() {
        //               onHoverReact = true;
        //               onHoverFlutter = false;
        //             });
        //           },
        //           onExit: (event) {
        //             onHoverReact = false;
        //           },
        //           child: Container(),
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: Container(
        //         height: size.height,
        //         margin: EdgeInsets.symmetric(horizontal: size.width*0.15),
        //         child: MouseRegion(
        //           onEnter: (event) {
        //             setState(() {
        //               onHoverFlutter = true;
        //               onHoverReact = false;
        //             });
        //           },
        //           onExit: (event) {
        //             onHoverFlutter = false;
        //           },
        //           child: Container(),
        //         ),
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
