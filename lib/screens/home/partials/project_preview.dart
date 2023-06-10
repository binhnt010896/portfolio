import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:go_router/go_router.dart';

class ProjectPreview extends StatelessWidget {

  final String title;
  final String description;
  final String logoPath;
  final String illustrationPath;
  final String companyName;
  final String detailPath;
  final String appStoreUrl;
  final String playStoreUrl;

  const ProjectPreview({Key? key, required this.title, required this.description, required this.logoPath, required this.illustrationPath, required this.companyName, required this.detailPath, required this.appStoreUrl, required this.playStoreUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(logoPath, height: 72),
                ),
                Text(title, style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary)),
                SizedBox(height: 16),

                RichText(
                  text: TextSpan(
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary),
                      text: 'by   ',
                      children: [
                        TextSpan(
                            text: companyName,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFE75B59)
                            )
                        )
                      ]
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary),
                  textScaleFactor: size.width/1440,
                ),
                TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.only(top: 36))
                  ),
                  onPressed: () {
                    context.go(detailPath);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('View Case', style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontSize: 18,
                          fontWeight: FontWeight.w900
                      )),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Icon(Icons.arrow_right_alt, color: theme.colorScheme.secondary),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    GestureDetector(
                      child: Image.asset('assets/images/download_appstore.png', height: 48),
                      onTap: () {
                        js.context.callMethod('open', [appStoreUrl]);
                      },
                    ),
                    GestureDetector(
                      child: Image.asset('assets/images/download_playstore.png', height: 40),
                      onTap: () {
                        js.context.callMethod('open', [playStoreUrl]);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: size.height*0.6
              ),
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(illustrationPath, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
