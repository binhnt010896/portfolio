import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:go_router/go_router.dart';
import 'package:octo_image/octo_image.dart';
import 'package:portfolio/constants/metrics.dart';
import 'package:portfolio/data/images.dart';
import 'package:portfolio/helpers/ga.dart';

class ProjectPreview extends StatelessWidget {
  final String title;
  final String description;
  final String illustrationPath;
  final String companyName;
  final String companyLink;
  final String detailPath;
  final String appStoreUrl;
  final String playStoreUrl;
  final bool isImageFirst;
  final List<String> stackSkills;

  const ProjectPreview(
      {Key? key,
      required this.title,
      required this.description,
      required this.illustrationPath,
      required this.companyName,
      required this.companyLink,
      required this.detailPath,
      required this.appStoreUrl,
      required this.playStoreUrl,
      this.isImageFirst = false,
      this.stackSkills = const []})
      : super(key: key);

  Widget _buildStack({required String label, required BuildContext context}) {
    ThemeData theme = Theme.of(context);
    return Chip(
      backgroundColor: theme.colorScheme.secondary,
      labelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      label: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Text(label, style: theme.textTheme.labelSmall),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    bool isSP = size.width <= MOBILE_MAX_WIDTH;
    final projectTiles = [
      Expanded(
        flex: isSP ? 2 : 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(color: theme.colorScheme.onPrimary)),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('by $companyName', style: theme.textTheme.labelMedium),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      sendAnalyticsEvent(GAEvent.CLICK_COMPANY_SITE,
                          {GAParam.COMPANY_SITE: companyLink});
                      js.context.callMethod('open', [companyLink]);
                    },
                    child: Image.asset(AssetImages.icOpenInNewTab),
                  )
                ],
              ),
              SizedBox(height: 24),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    InkWell(
                      child: Image.asset(AssetImages.icDlAppStore, height: 40),
                      onTap: () {
                        sendAnalyticsEvent(GAEvent.CLICK_DOWNLOAD_PLATFORM,
                            {GAParam.DOWNLOAD_PLATFORM_URL: appStoreUrl});
                        js.context.callMethod('open', [appStoreUrl]);
                      },
                    ),
                    SizedBox(width: 16),
                    InkWell(
                      child: Image.asset(AssetImages.icDlPlayStore, height: 40),
                      onTap: () {
                        sendAnalyticsEvent(GAEvent.CLICK_DOWNLOAD_PLATFORM,
                            {GAParam.DOWNLOAD_PLATFORM_URL: appStoreUrl});
                        js.context.callMethod('open', [playStoreUrl]);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.justify,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.onPrimary),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 24),
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: [
                  for (String stack in stackSkills)
                    _buildStack(context: context, label: stack),
                ],
              ),
              /// TODO: Go to Detail
              // TextButton(
              //   style: ButtonStyle(
              //       padding: MaterialStateProperty.all(EdgeInsets.only(top: 36))
              //   ),
              //   onPressed: () {
              //     context.go(detailPath);
              //   },
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text('View Case', style: theme.textTheme.headlineSmall?.copyWith(
              //           fontWeight: FontWeight.w600
              //       )),
              //       Padding(
              //         padding: const EdgeInsets.only(top: 6, left: 8),
              //         child: Icon(Icons.arrow_forward, color: theme.colorScheme.onPrimary),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: isSP ? 1 : 2,
        child: Container(
          constraints: BoxConstraints(maxHeight: size.height * 0.6),
          width: isSP ? size.width : null,
          padding:
              EdgeInsets.symmetric(horizontal: isSP ? 18 : 36, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: OctoImage(
              image: AssetImage(illustrationPath),
              placeholderBuilder: OctoPlaceholder.blurHash('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
              errorBuilder: OctoError.icon(color: Colors.red),
              fit: isSP ? BoxFit.fitWidth : BoxFit.cover
            ),
          ),
        ),
      ),
    ];
    return Container(
      padding: EdgeInsets.all(16),
      height: isSP ? 600 : null,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24)),
      child: isSP
          ? Column(
              children: (isImageFirst || isSP)
                  ? projectTiles.reversed.toList()
                  : projectTiles)
          : Row(
              children: (isImageFirst || isSP)
                  ? projectTiles.reversed.toList()
                  : projectTiles),
    );
  }
}
