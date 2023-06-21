import 'package:flutter/material.dart';
import 'package:portfolio/screens/home/partials/project_preview.dart';

class SelectedProjectsSection extends StatefulWidget {
  const SelectedProjectsSection({Key? key}) : super(key: key);

  @override
  State<SelectedProjectsSection> createState() => _SelectedProjectsSectionState();
}

class _SelectedProjectsSectionState extends State<SelectedProjectsSection> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text('Selected Works', style: theme.textTheme.headlineLarge),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text('Here are a few projects I\'ve worked on.'),
            ),
            Column(
              children: [
                ProjectPreview(
                  title: 'Ralali Connect',
                  description: 'Ralali Connect mobile application allows merchants to setup storefront and gain access to the business community.',
                  companyName: 'Ralali',
                  detailPath: 'projects/ralali-connect',
                  illustrationPath: 'assets/images/ralaliconnect.png',
                  playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ralali.konekto',
                  appStoreUrl: 'https://apps.apple.com/id/app/ralali-connect/id1590298867',
                  stackSkills: ['Dart', 'Flutter', 'JavaScript', 'VueJS']
                ),
                SizedBox(height: 24),
                ProjectPreview(
                  title: 'Ralali Agent',
                  description: 'Ralali Agent is a platform which helps user earn commission in their spare time via surveys, promotions, and product sales.',
                  companyName: 'Ralali',
                  detailPath: 'projects/ralali-agent',
                  illustrationPath: 'assets/images/ralaliagent.png',
                  playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ralali.bigagent.android',
                  appStoreUrl: 'https://apps.apple.com/tc/app/ralali-agent-iniwaktunyagerak/id1623070818',
                  isImageFirst: true,
                  stackSkills: ['React Native'],
                ),
                SizedBox(height: 24),
                ProjectPreview(
                  title: 'CJ LIFE',
                  description: 'CJ LIFE assists user in collectively managing various insurances they have subscribed to, as well as contract details, insurance premiums and contract period.',
                  companyName: 'CJトラスト株式会社',
                  detailPath: 'projects/cj-life',
                  illustrationPath: 'assets/images/cjtrust.jpeg',
                  playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cjtrust.cjlife',
                  appStoreUrl: 'https://apps.apple.com/jp/app/cj-life/id1558960279',
                  stackSkills: ['Dart', 'Flutter'],
                ),
              ],
            )
          ],
        )
    );
  }
}
