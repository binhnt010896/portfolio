import 'package:flutter/material.dart';
import 'package:portfolio/constants/metrics.dart';

class SkillStackItem extends StatelessWidget {
  final String title;
  final String description;
  final String iconAsset;
  const SkillStackItem({Key? key, required this.title, required this.description, required this.iconAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSP ? 24.0 : 48.0, vertical: isSP ? 24.0 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconAsset, height: 36),
          SizedBox(height: 16),
          Text(title, style: theme.textTheme.headlineMedium, textAlign: TextAlign.center),
          SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
