import 'package:flutter/material.dart';
import 'package:portfolio/screens/home/partials/3d_logo.dart';
import 'package:portfolio/screens/home/partials/section_wrapper.dart';
import 'dart:js' as js;

class MainVisualSection extends StatefulWidget {
  const MainVisualSection({Key? key}) : super(key: key);

  @override
  State<MainVisualSection> createState() => _MainVisualSectionState();
}

class _MainVisualSectionState extends State<MainVisualSection> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SectionWrapper(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 36),
        height: MediaQuery.of(context).size.height-90,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, I\'m Bình, but you can call me George. I\'m a Flutter Developer based in 🇻🇳',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 36
                    ),
                    textScaleFactor: size.width/1440,
                  ),
                  MaterialButton(
                      color: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.onSecondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 5,
                      onPressed: () {
                        js.context.callMethod('open', ['https://drive.google.com/file/d/1bTONVku2cbuvuodYJYuhWGAnA6MvNoWe/view?usp=sharing']);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                        child: Text('Download my CV', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      )
                  )
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  height: size.width*0.35,
                  width: size.width*0.35,
                  child: RotatingModel(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
