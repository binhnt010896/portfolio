import 'package:flutter/material.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/data/images.dart';
import 'package:portfolio/screens/home/sections/bottom_section.dart';
import 'package:portfolio/screens/home/sections/contact_modal.dart';
import 'package:portfolio/widgets/action_button.dart';

class CTASection extends StatelessWidget {
  const CTASection({Key? key}) : super(key: key);

  Widget renderCTA(context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    return Container(
      decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(8)),
      padding: isSP ? EdgeInsets.all(24) : EdgeInsets.all(60),
      child: isSP ? _renderSPCTA(context) : _renderPCCTA(context),
    );
  }

  Widget _renderPCCTA(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            'Start a Project',
            style: theme.textTheme.displayLarge
                ?.copyWith(color: Color(0xFF30374F)),
          ),
        ),
        Flexible(
          flex: 1,
          child: Center(
            child: Text(
              'Interested in working together? We should queue up a time to chat. I’ll buy the coffee.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: Color(0xFF30374F)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: ActionButton(
              text: 'Let\'s Connect',
              icon: Icon(
                Icons.front_hand_outlined,
                size: 16,
              ),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  builder: (context) => ContactModal(),
                );
              }),
        ),
      ],
    );
  }

  Widget _renderSPCTA(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Start a Project',
          style:
              theme.textTheme.displayLarge?.copyWith(color: Color(0xFF30374F)),
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            'Interested in working together? We should queue up a time to chat.\nI’ll buy the coffee.',
            style:
                theme.textTheme.bodyMedium?.copyWith(color: Color(0xFF30374F)),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 24),
        ActionButton(
            text: 'Let\'s Connect',
            icon: Icon(
              Icons.front_hand_outlined,
              size: 16,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                builder: (context) => ContactModal(),
              );
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              width: size.width,
              height: isSP ? size.height / 3 : size.height / 2.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetImages.mainVisualBg),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter),
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height * .8,
            )
          ],
        ),
        Positioned(
          top: (isSP ? size.height / 3 : size.height / 2.5) - 60,
          width: size.width * .8,
          child: Column(
            children: [
              renderCTA(context),
              SizedBox(
                height: 96,
              ),
              BottomSection()
            ],
          ),
        ),
      ],
    );
  }
}
