import 'package:flutter/material.dart';
import 'package:portfolio/helpers/scroll_overseer.dart';
import 'package:portfolio/screens/home/partials/project_preview.dart';
import 'package:portfolio/screens/home/partials/section_wrapper.dart';
import 'package:provider/provider.dart';

import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class SelectedProjectsSection extends StatefulWidget {
  const SelectedProjectsSection({Key? key}) : super(key: key);

  @override
  State<SelectedProjectsSection> createState() => _SelectedProjectsSectionState();
}

class _SelectedProjectsSectionState extends State<SelectedProjectsSection> {

  bool shouldActivateCards = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return SectionWrapper(
        child: IgnorePointer(
          ignoring: !(Provider.of<ScrollOverseer>(context, listen: true).currentPage == 3),
          child: Container(
              height: size.height - 90,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 36),
                    child: Text('Selected Works', style: TextStyle(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w900,
                        fontSize: 24
                    )),
                  ),
                  Container(
                    height: size.height - 240,
                    width: size.width,
                    child: StackedCardCarousel(
                      type: StackedCardCarouselType.fadeOutStack,
                      spaceBetweenItems: 1200,
                      items: [
                        ProjectPreview(
                          title: 'Ralali Connect',
                          description: 'Ralali Connect mobile application allows merchants to setup storefront and gain access to the business community.',
                          logoPath: 'assets/images/ralaliconnect_logo.webp',
                          companyName: 'Ralali',
                          detailPath: 'projects/ralali-connect',
                          illustrationPath: 'assets/images/ralaliconnect.png',
                          playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ralali.konekto',
                          appStoreUrl: 'https://apps.apple.com/id/app/ralali-connect/id1590298867',
                        ),
                        ProjectPreview(
                          title: 'Ralali Agent',
                          description: 'Ralali Agent is a platform which helps user earn commission in their spare time via surveys, promotions, and product sales.',
                          logoPath: 'assets/images/ralaliagent_logo.webp',
                          companyName: 'Ralali',
                          detailPath: 'projects/ralali-agent',
                          illustrationPath: 'assets/images/ralaliagent.png',
                          playStoreUrl: 'https://play.google.com/store/apps/details?id=com.ralali.bigagent.android',
                          appStoreUrl: 'https://apps.apple.com/tc/app/ralali-agent-iniwaktunyagerak/id1623070818',
                        ),
                        ProjectPreview(
                          title: 'CJ LIFE',
                          description: 'CJ LIFE assists user in collectively managing various insurances they have subscribed to, as well as contract details, insurance premiums and contract period.',
                          logoPath: 'assets/images/cjtrust_logo.webp',
                          companyName: 'CJトラスト株式会社',
                          detailPath: 'projects/cj-life',
                          illustrationPath: 'assets/images/cjtrust.jpeg',
                          playStoreUrl: 'https://play.google.com/store/apps/details?id=com.cjtrust.cjlife',
                          appStoreUrl: 'https://apps.apple.com/jp/app/cj-life/id1558960279',
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}
