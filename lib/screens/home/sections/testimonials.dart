import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/data/images.dart';
import 'dart:js' as js;

import 'package:readmore/readmore.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({Key? key}) : super(key: key);

  @override
  State<TestimonialSection> createState() =>
      _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {

  final _controller = PageController(
    initialPage: 0,
  );

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPage = (_controller.page ?? 0).round();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    ThemeData theme = Theme.of(context);
    return Container(
        width: size.width,
        padding: EdgeInsets.only(left: 48, right: 48, top: 56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child:
              Text('Testimonials', style: theme.textTheme.headlineLarge),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text('Hear from some of my amazing supervisors.'),
            ),
            if (!isSP)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _renderTestimonialItem(
                      'Trong Dinh, CTO of Tokoin',
                      '“George is one of the finest engineers I’ve had the privilege of collaborating with. He possesses a robust technical background and excels in communication. He effortlessly tackles new technical challenges with a strong commitment, consistently delivering high-quality solutions.”',
                      AssetImages.trongDinh,
                      'https://www.linkedin.com/in/trongdth/',
                  ),
                  const SizedBox(width: 24),
                  _renderTestimonialItem(
                      'Nikita Devy Haryono,\nProduct Manager of Ralali',
                      '“Working alongside Binh has been an absolute delight - his technical prowess, punctuality in task delivery, and commitment to meeting targets have consistently impressed our team. Binh\'s contributions extend beyond his coding skills; his ability to provide invaluable insights from multiple perspectives has greatly enriched the quality of our work and led to innovative solutions. His friendly and collaborative nature make him not only a wonderful coworker but also a supportive team player, always willing to lend a hand to his colleagues. In all aspects, Binh embodies the ideal developer and teammate, and I wholeheartedly recommend him as a true asset to any project or team fortunate enough to have him.”',
                      AssetImages.nikita,
                      'https://www.linkedin.com/in/nikita-devy-haryono/',
                  ),
                  // const SizedBox(width: 24),
                  // Expanded(child: _renderTestimonialItem(
                  //   'Someone',
                  //   '“Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vel dolor vitae lacus luctus mollis. Cras porttitor sagittis mi vel posuere. Donec dapibus rutrum tortor, in porttitor justo elementum”',
                  //   null
                  // )),
                ],
              )
            else
              Column(
                children: [
                  ExpandablePageView(
                    controller: _controller,
                    children: [
                      _renderTestimonialItem(
                        'Trong Dinh, CTO of Tokoin',
                        '“George is one of the finest engineers I’ve had the privilege of collaborating with. He possesses a robust technical background and excels in communication. He effortlessly tackles new technical challenges with a strong commitment, consistently delivering high-quality solutions.”',
                        AssetImages.trongDinh,
                        'https://www.linkedin.com/in/trongdth/',
                        true
                      ),
                      _renderTestimonialItem(
                        'Nikita Devy Haryono, Product Manager of Ralali',
                        '“Working alongside Binh has been an absolute delight - his technical prowess, punctuality in task delivery, and commitment to meeting targets have consistently impressed our team. Binh\'s contributions extend beyond his coding skills; his ability to provide invaluable insights from multiple perspectives has greatly enriched the quality of our work and led to innovative solutions. His friendly and collaborative nature make him not only a wonderful coworker but also a supportive team player, always willing to lend a hand to his colleagues. In all aspects, Binh embodies the ideal developer and teammate, and I wholeheartedly recommend him as a true asset to any project or team fortunate enough to have him.”',
                        AssetImages.nikita,
                        'https://www.linkedin.com/in/nikita-devy-haryono/',
                        true
                      ),
                      // _renderTestimonialItem(
                      //   'Someone',
                      //   '“Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vel dolor vitae lacus luctus mollis. Cras porttitor sagittis mi vel posuere. Donec dapibus rutrum tortor, in porttitor justo elementum”',
                      //   null,
                      //   true
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: PageViewDotIndicator(
                      currentItem: currentPage,
                      count: 2,
                      unselectedColor: Theme.of(context).colorScheme.secondary,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      duration: const Duration(milliseconds: 200),
                      boxShape: BoxShape.circle,
                      onItemClicked: (index) {
                        _controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ],
              )
          ],
        ));
  }

  _renderTestimonialItem(String person, String quote, String? image, String linkedIn, [bool isSp = false]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      width: !isSp ? 400 : null,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0x33FBFCFC)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              OctoImage(
                image: AssetImage(image ?? AssetImages.flutterLogoWhite),
                placeholderBuilder: OctoPlaceholder.blurHash('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                errorBuilder: OctoError.icon(color: Colors.red),
                width: 140,
                height: 140,
                fit: isSp ? BoxFit.fitWidth : BoxFit.cover
              ),
              Expanded(child: Container())
            ],
          ),
          const SizedBox(height: 24),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadMoreText(
                quote,
                trimLines: 5,
                trimMode: TrimMode.Line,
                delimiter: '...\t\t',
                lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 26),
              Text(
                '- $person',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  js.context.callMethod(
                      'open', [linkedIn]);
                },
                child: SvgPicture.asset(AssetImages.icLinkedIn, height: 28),
              )
            ],
          ),

        ],
      ),
    );
  }
}
