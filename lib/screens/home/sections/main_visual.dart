import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/screens/home/sections/skill_stack.dart';
import 'dart:js' as js;

import 'package:portfolio/widgets/action_button.dart';

class MainVisualSection extends StatefulWidget {
  const MainVisualSection({Key? key}) : super(key: key);

  @override
  State<MainVisualSection> createState() => _MainVisualSectionState();
}

enum LogoName {
  FLUTTER,
  REACT
}

class _MainVisualSectionState extends State<MainVisualSection> {

  bool onHoverReact = true;
  bool onHoverFlutter = false;

  Widget _renderBackgroundImage(String imageName, LogoName type) {
    return Image.asset(imageName, color: Color(0xFF434C55), height: 200).animate(
      onPlay: (controller) => controller.repeat(),
    ).shimmer(delay: 1500.ms, duration: 1500.ms).moveY(
        begin: 20,
        end: 0,
        duration: 1500.ms
    ).moveY(
        begin: 0,
        end: 20,
        delay: 0.ms,
        duration: 1500.ms
    ).animate(
      target: ((type == LogoName.REACT && onHoverReact) || (type == LogoName.FLUTTER && onHoverFlutter)) ? 1 : 0,
    ).shake(hz: 2, curve: Curves.easeInOutCubic)
    .scaleXY(end: 3, duration: 600.ms).animate(
      target: ((type == LogoName.REACT && onHoverReact) || (type == LogoName.FLUTTER && onHoverFlutter)) ? 1 : 0,
    ).blur(
      begin: Offset(0, 5)
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        Container(
          height: size.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _renderBackgroundImage('assets/images/react_logo_white.png', LogoName.REACT),
              ),
              Expanded(
                child: _renderBackgroundImage('assets/images/flutter_logo_white.png', LogoName.FLUTTER),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              height: size.height*(isSP ? 1.4 : 1),
              padding: EdgeInsets.symmetric(horizontal: 48),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/main_visual_bg.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Mobile Application Developer (Dart - Flutter)', style: theme.textTheme.headlineLarge, textAlign: TextAlign.center),
                  SizedBox(height: 16),
                  isSP ? Container() : Text('Unlocking Possibilities Across iOS and Android Platforms\nDelivering Exceptional Mobile Experiences with Dart and Flutter.', textAlign: TextAlign.center),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    height: size.height*0.3,
                    width: size.height*0.3,
                    child: Image.asset(
                      'assets/images/avatar.png',
                    ),
                  ),
                  Text('Hi, I\'m Binh. Nice to meet you', style: theme.textTheme.headlineLarge),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.18),
                    child: Text(
                      '4+ years of experience as Mobile Application Developer with Computer Science B/S. Hands-on leadership experience, proficient in both extensive cross-functional collaboration and working independently.\nResearch-driven approach to problem-solving with intuitive knowledge to acquire new technologies & industry trends for professional advancement. ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 36),
                  ActionButton(
                    text: 'Download Resume',
                    icon: Icon(Icons.download_rounded, size: 16,),
                    onPressed: () {
                      js.context.callMethod('open', ['https://drive.google.com/file/d/1bTONVku2cbuvuodYJYuhWGAnA6MvNoWe/view']);
                    }
                  )
                ],
              ),
            ),
            Container(height: isSP ? 900 : 300)
          ],
        ),
        Positioned(
          top: size.height-(isSP ? -180 : 36),
          child: SkillStackSection(),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: size.height,
                margin: EdgeInsets.symmetric(horizontal: size.width*0.15),
                child: MouseRegion(
                  onEnter: (event) {
                    setState(() {
                      onHoverReact = true;
                      onHoverFlutter = false;
                    });
                  },
                  onExit: (event) {
                    onHoverReact = false;
                  },
                  child: Container(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: size.height,
                margin: EdgeInsets.symmetric(horizontal: size.width*0.15),
                child: MouseRegion(
                  onEnter: (event) {
                    setState(() {
                      onHoverFlutter = true;
                      onHoverReact = false;
                    });
                  },
                  onExit: (event) {
                    onHoverFlutter = false;
                  },
                  child: Container(),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
