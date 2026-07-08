import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/url_helper.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';

/// A bordered "Message me here" card listing each contact channel as an
/// icon + handle row.
class ContactCard extends StatelessWidget {
  const ContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText('Message me here', style: AppTextStyles.bold),
            const SizedBox(height: 16),
            for (final social in PortfolioData.socials)
              _ContactRow(
                iconAsset: social.iconAsset,
                handle: social.handle,
                url: social.url,
              ),
          ],
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String iconAsset;
  final String handle;
  final String url;

  const _ContactRow({
    required this.iconAsset,
    required this.handle,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: CursorTarget(
        child: GestureDetector(
          onTap: () => openUrl(url),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconAsset,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.gray,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  handle,
                  style: AppTextStyles.bodyWhite,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
