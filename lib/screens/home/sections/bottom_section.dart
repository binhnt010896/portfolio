import 'package:flutter/material.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          Image.asset('assets/images/logo_no_text_white.png', height: 96),
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
              FlutterLogo(size: 24),
              FlutterLogo(size: 24),
              FlutterLogo(size: 24),
            ],
          )
        ],
      ),
    );
  }
}
