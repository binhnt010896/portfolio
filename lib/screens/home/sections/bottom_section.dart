import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/data/images.dart';
import 'dart:js' as js;

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(AssetImages.logoWhite, height: 96),
          SizedBox(height: 16),
          Text(
            'Crafting Cross-Platform Excellence\nwith Dart and Flutter!',
            style: theme.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => js.context.callMethod('open', ['https://github.com/binhnt010896/']),
                child: SvgPicture.asset(AssetImages.icGithub, height: 28),
              ),
              SizedBox(width: 24),
              GestureDetector(
                onTap: () => js.context.callMethod('open', ['https://www.linkedin.com/in/binhnt010896/']),
                child: SvgPicture.asset(AssetImages.icLinkedIn, height: 28),
              )
            ],
          )
        ],
      ),
    );
  }
}
