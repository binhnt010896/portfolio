import 'package:flutter/material.dart';
import 'package:portfolio/screens/home/partials/section_wrapper.dart';

class EducationSection extends StatefulWidget {
  const EducationSection({Key? key}) : super(key: key);

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return SectionWrapper(
      child: Container(
        height: size.height - 90,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.black45,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/education_bg.jpeg',
            ),
            opacity: 0.5,
            fit: BoxFit.cover,
          )
        ),
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Text('Education', style: TextStyle(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w900,
                fontSize: 24
              )),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/images/fuas.jpeg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Frankfurt University of Applied Sciences', style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary)),
                      SizedBox(height: 16),
                      Text('In my educational journey, I proudly earned a Bachelor of Science in Computer Science from Frankfurt University of Applied Sciences. Throughout my time there, I excelled academically with a commendable GPA of 8.0 out of 10. This comprehensive program equipped me with a solid foundation in computer science, fostering my passion for technology and nurturing my problem-solving skills.', textAlign: TextAlign.justify, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}