import 'package:portfolio/constants/images.dart';

/// A single social/contact link.
class SocialLink {
  final String label;
  final String handle;
  final String iconAsset;
  final String url;
  const SocialLink({
    required this.label,
    required this.handle,
    required this.iconAsset,
    required this.url,
  });
}

/// A showcased project.
class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String? imageAsset;
  final String? liveUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  const Project({
    required this.title,
    required this.description,
    required this.tags,
    this.imageAsset,
    this.liveUrl,
    this.appStoreUrl,
    this.playStoreUrl,
  });
}

/// A skill category card.
class SkillCategory {
  final String title;
  final List<String> items;
  const SkillCategory({required this.title, required this.items});
}

/// All of the portfolio's content in one place.
class PortfolioData {
  PortfolioData._();

  static const String name = 'Binh';
  static const String fullName = 'Thanh-Binh Nguyen';
  static const String role = 'Mobile & front-end developer';
  static const String location = 'Ho Chi Minh City, Vietnam';

  static const String heroHeadline = 'Binh is a mobile & front-end developer';
  static const String heroSubtitle =
      'He crafts responsive mobile and web apps where clean architecture meets great user experience.';
  static const String currentlyWorkingOn =
      'Currently building healthcare apps @ Thomson X';

  static const String quote =
      'I am not a perfectionist, but I like to feel that things are done well. More important than that, I feel an endless need to learn, to improve, to evolve.';
  static const String quoteAuthor = '- Cristiano Ronaldo';

  static const String aboutMe = "Hello, i'm Binh!\n\n"
      "I'm a frontend developer with 7+ years of experience building mobile and "
      "web applications across healthcare, B2B, and e-commerce domains. I'm "
      'comfortable owning features end-to-end — from architecture decisions all '
      'the way to AppStore deployment.\n\n'
      'I work mainly with Flutter, React, and NextJS, and I love collaborating '
      "with PMs, designers, and backend engineers in fast-moving teams. I'm "
      'always learning the newest technologies and frameworks.';

  static const String contactsBlurb =
      "I'm interested in mobile and front-end opportunities. However, if you "
      "have any other request or question, don't hesitate to reach out.";

  static const String email = 'binhnt.010896@gmail.com';

  static const List<SocialLink> socials = [
    SocialLink(
      label: 'GitHub',
      handle: 'binhnt010896',
      iconAsset: ImagesDirectory.iconGithub,
      url: 'https://github.com/binhnt010896',
    ),
    SocialLink(
      label: 'LinkedIn',
      handle: 'in/binhnt010896',
      iconAsset: ImagesDirectory.iconLinkedin,
      url: 'https://linkedin.com/in/binhnt010896',
    ),
    SocialLink(
      label: 'Email',
      handle: email,
      iconAsset: ImagesDirectory.iconEmail,
      url: 'mailto:$email',
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Ralali Connect',
      description:
          'B2B social platform for SMEs that lets merchants set up a storefront '
          'and tap into the business community. 50k+ downloads.',
      tags: ['Flutter', 'VueJS', 'Dart', 'JS'],
      imageAsset: ImagesDirectory.ralaliConnect,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.ralali.konekto',
      appStoreUrl: 'https://apps.apple.com/id/app/ralali-connect/id1590298867',
    ),
    Project(
      title: 'Ralali Agent',
      description:
          'Affiliate and reseller platform that helps users earn commission '
          'through surveys, promotions, and product sales. 100k+ downloads.',
      tags: ['React Native', 'JS'],
      imageAsset: ImagesDirectory.ralaliAgent,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.ralali.bigagent.android',
      appStoreUrl:
          'https://apps.apple.com/tc/app/ralali-agent-iniwaktunyagerak/id1623070818',
    ),
    Project(
      title: 'CJ LIFE',
      description:
          'Insurance management app to track contracts, premiums and periods. '
          'Owned full development and deployment to AppStore & PlayStore.',
      tags: ['Flutter', 'Dart'],
      imageAsset: ImagesDirectory.cjLife,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.cjtrust.cjlife',
      appStoreUrl: 'https://apps.apple.com/jp/app/cj-life/id1558960279',
    ),
    Project(
      title: 'Thomson Touch',
      description:
          'Patient-facing app assisting users during hospital admission at '
          'Thomson Medical — pre-admission flows, appointment tracking, and '
          'in-centre navigation.',
      tags: ['Flutter', 'Dart', 'Firebase'],
    ),
    Project(
      title: 'PAP — Partners Portal',
      description:
          "Web platform for managing Thomson Medical's partner doctors — "
          'onboarding, profile management, and partnership administration.',
      tags: ['Flutter Web', 'Dart'],
    ),
    Project(
      title: "Pizza 4P's Delivery",
      description:
          'Delivery web application built against provided design specs and '
          'API endpoints.',
      tags: ['ReactJS', 'JS'],
      imageAsset: ImagesDirectory.pizza4Ps,
    ),
  ];

  static const List<SkillCategory> skills = [
    SkillCategory(title: 'Languages', items: ['Dart', 'JavaScript']),
    SkillCategory(
      title: 'Frameworks',
      items: ['Flutter', 'ReactJS', 'NextJS', 'VueJS'],
    ),
    SkillCategory(
      title: 'State Management',
      items: ['GetX', 'Provider', 'Bloc-Cubit'],
    ),
    SkillCategory(
      title: 'Tools & Services',
      items: ['Firebase', 'PostHog', 'SpaceOCR', 'NodeJS', 'Retool'],
    ),
    SkillCategory(
      title: 'Deployment',
      items: ['AppStore', 'PlayStore', 'Firebase Hosting'],
    ),
  ];
}
