import 'package:flutter/material.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/screens/home/partials/skill_stack_item.dart';

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

  Widget _renderPCSkillStack() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SkillStackItem(
            title: 'Mobile App Developer',
            description: 'With three years of expertise in creating robust and user-friendly applications, I excel in designing and implementing innovative solutions.',
            iconAsset: 'assets/images/ic_mb_dev.png',
          ),
        ),
        _renderVerticalDivider(),
        Expanded(
          child: SkillStackItem(
            title: 'Front-end Developer',
            description: 'A strong eye for design and proficiency in building engaging and responsive web interfaces using Flutter\'s versatile framework',
            iconAsset: 'assets/images/ic_fe_dev.png',
          ),
        ),
        _renderVerticalDivider(),
        Expanded(
          child: SkillStackItem(
            title: 'Flutter App Developer',
            description: 'Skilled in utilizing Flutter\'s cross-platform capabilities, I am dedicated to delivering high-quality mobile experiences tailored to meet clients\' needs.',
            iconAsset: 'assets/images/ic_flt_dev.png',
          ),
        ),
      ],
    );
  }

  Widget _renderSPSkillStack() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SkillStackItem(
            title: 'Mobile App Developer',
            description: 'With three years of expertise in creating robust and user-friendly applications, I excel in designing and implementing innovative solutions.',
            iconAsset: 'assets/images/ic_mb_dev.png',
          ),
        ),
        _renderHorizontalDivider(),
        Expanded(
          child: SkillStackItem(
            title: 'Front-end Developer',
            description: 'A strong eye for design and proficiency in building engaging and responsive web interfaces using Flutter\'s versatile framework',
            iconAsset: 'assets/images/ic_fe_dev.png',
          ),
        ),
        _renderHorizontalDivider(),
        Expanded(
          child: SkillStackItem(
            title: 'Flutter App Developer',
            description: 'Skilled in utilizing Flutter\'s cross-platform capabilities, I am dedicated to delivering high-quality mobile experiences tailored to meet clients\' needs.',
            iconAsset: 'assets/images/ic_flt_dev.png',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    return Container(
      width: isSP ? size.width*.5 : size.width*0.8,
      height: isSP ? 900 : 400,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        image: DecorationImage(
          image: AssetImage('assets/images/vertical_skillstack_bg.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter
        ),
      ),
      child: isSP
        ? _renderSPSkillStack()
        : _renderPCSkillStack()
    );
  }
}
