import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:portfolio/constants/metrics.dart';

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
                children: [
                  Expanded(child: _renderTestimonialItem(1),),
                  const SizedBox(width: 24),
                  Expanded(child: _renderTestimonialItem(2),),
                  const SizedBox(width: 24),
                  Expanded(child: _renderTestimonialItem(3),),
                ],
              )
            else
              Column(
                children: [
                  SizedBox(
                    height: size.height*.7,
                    width: size.width,
                    child: PageView(
                      controller: _controller,
                      children: [
                        _renderTestimonialItem(1),
                        _renderTestimonialItem(2),
                        _renderTestimonialItem(3),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: PageViewDotIndicator(
                      currentItem: currentPage,
                      count: 3,
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

  _renderTestimonialItem(index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
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
              Expanded(
                child: Image.network("https://picsum.photos/seed/$index/500/500"),
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
              Text(
                '“Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse vel dolor vitae lacus luctus mollis. Cras porttitor sagittis mi vel posuere. Donec dapibus rutrum tortor, in porttitor justo elementum in”',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 26),
              Text(
                'Trong Dinh, CTO of Tokoin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
