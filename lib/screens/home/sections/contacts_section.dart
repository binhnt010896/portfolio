import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/screens/home/widgets/contact_card.dart';
import 'package:portfolio/screens/home/widgets/contact_form.dart';
import 'package:portfolio/screens/home/widgets/reveal_on_scroll.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/section_heading.dart';

/// `# contacts` — a short blurb beside the "Message me here" card.
class ContactsSection extends StatelessWidget {
  const ContactsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final blurb =
        SelectableText(PortfolioData.contactsBlurb, style: AppTextStyles.body);

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(child: SectionHeading(title: 'contacts', index: 5)),
          const SizedBox(height: 8),
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RevealOnScroll(child: blurb),
                const SizedBox(height: 24),
                const RevealOnScroll(
                  delay: Duration(milliseconds: 90),
                  child: ContactCard(),
                ),
                const SizedBox(height: 24),
                const RevealOnScroll(
                  delay: Duration(milliseconds: 180),
                  child: ContactForm(),
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: RevealOnScroll(
                    from: RevealFrom.left,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        blurb,
                        const SizedBox(height: 24),
                        const ContactCard(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                const Expanded(
                  flex: 2,
                  child: RevealOnScroll(
                    from: RevealFrom.right,
                    delay: Duration(milliseconds: 120),
                    child: ContactForm(),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
