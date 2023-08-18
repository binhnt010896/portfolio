import 'package:flutter/material.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/data/images.dart';
import 'package:portfolio/helpers/ga.dart';
import 'package:portfolio/screens/home/sections/bottom_section.dart'
    deferred as deferred_bottom_section;
import 'package:portfolio/screens/home/sections/contact_modal.dart'
    deferred as deferred_contact_modal;
import 'package:portfolio/widgets/action_button.dart'
    deferred as deferred_action_button;

final Future<void> loadBottomSection = deferred_bottom_section.loadLibrary();
final Future<void> loadContactModal = deferred_contact_modal.loadLibrary();
final Future<void> loadActionButton = deferred_action_button.loadLibrary();

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

  Widget _renderActionButton(context) {
    return FutureBuilder(
      future: loadActionButton,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return deferred_action_button.ActionButton(
              text: 'Let\'s Connect',
              icon: Icon(
                Icons.front_hand_outlined,
                size: 16,
              ),
              onPressed: () {
                sendAnalyticsEvent(GAEvent.CLICK_LETS_CONNECT_MODAL, {});
                showModalBottomSheet<void>(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  builder: (context) => FutureBuilder(
                    future: loadContactModal,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return deferred_contact_modal.ContactModal();
                      }
                      return Container();
                    }
                  ),
                );
              });
        }
        return Container();
      },
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
        Flexible(flex: 1, child: _renderActionButton(context)),
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
        _renderActionButton(context)
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
              FutureBuilder(
                future: loadBottomSection,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return deferred_bottom_section.BottomSection();
                  }
                  return Container();
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
