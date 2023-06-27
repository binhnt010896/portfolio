import 'package:flutter/material.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/data/data.dart';
import 'package:portfolio/data/images.dart';
import 'package:portfolio/models/skill_stack.dart';
import 'package:portfolio/screens/home/partials/skill_stack_item.dart';
import 'package:portfolio/widgets/custom_column_row.dart';

class SkillStackSection extends StatefulWidget {
  const SkillStackSection({Key? key}) : super(key: key);

  @override
  State<SkillStackSection> createState() => _SkillStackSectionState();
}

class _SkillStackSectionState extends State<SkillStackSection> {
  Widget _renderVerticalDivider() {
    return VerticalDivider(
      width: 8,
      thickness: 1,
      color: Color(0xFF30374F),
      endIndent: 72,
    );
  }

  Widget _renderHorizontalDivider() {
    return Divider(
      height: 24,
      thickness: 1,
      color: Color(0xFF30374F),
    );
  }

  static GeneratedData data = GeneratedData();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    return Container(
        width: isSP ? size.width * .9 : size.width * 0.8,
        height: isSP ? 960 : 400,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          image: DecorationImage(
              image: AssetImage(AssetImages.verticalSkillStackBg),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter),
        ),
        child: CustomColumnRow(
          crossAxisAlignment:
              isSP ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          separator:
              isSP ? _renderHorizontalDivider() : _renderVerticalDivider(),
          listType: isSP ? ListType.COLUMN : ListType.ROW,
          children: [
            for (Skill skill in data.skills)
              Expanded(
                child: SkillStackItem(
                  title: skill.title,
                  description: skill.description,
                  iconAsset: skill.iconAsset,
                ),
              )
          ],
        ));
  }
}
