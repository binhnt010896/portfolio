import 'package:flutter/material.dart';
import 'package:portfolio/screens/home/partials/section_wrapper.dart';

class SkillStackSection extends StatefulWidget {
  const SkillStackSection({Key? key}) : super(key: key);

  @override
  State<SkillStackSection> createState() => _SkillStackSectionState();
}

class _SkillStackSectionState extends State<SkillStackSection> {
  Widget _buildItem(String imagePath, String name) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 48),
          Text(name, style: TextStyle(color: theme.colorScheme.onPrimary))
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return SectionWrapper(
      child: Container(
        height: 120,
        width: size.width,
        color: theme.colorScheme.secondary,
        padding: EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Text('Skill stacks', style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onPrimary
            )),
            SizedBox(height: 16),
            Text('Yeah, I know, there aren\'t many, but I\'m confident about what I do', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildItem('assets/images/flutter_logo_white.png', 'Flutter'),
                  _buildItem('assets/images/react_logo_white.png', 'React'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
