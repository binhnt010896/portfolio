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

/// A challenge met during a project and how it was resolved — the
/// "findings" part of a case study.
class Finding {
  final String problem;
  final String resolution;
  const Finding({required this.problem, required this.resolution});
}

/// The long-form narrative behind a featured project. Projects with a
/// [CaseStudy] get a dedicated `/works/<slug>` page and an immersive row in
/// the projects section; the others stay as compact cards.
class CaseStudy {
  final String overview;
  final String role;
  final String duration;
  final String teamContext;

  /// One merged "what-i-did" list: scope-level bullets first, concrete
  /// builds after. (Replaces the old responsibilities/contributions split,
  /// which overlapped.)
  final List<String> highlights;
  final List<Finding> findings;
  final String outcome;

  /// Extra screenshots shown on the detail page (the hero uses
  /// [Project.imageAsset]).
  final List<String> gallery;
  const CaseStudy({
    required this.overview,
    required this.role,
    required this.duration,
    required this.teamContext,
    required this.highlights,
    required this.findings,
    required this.outcome,
    this.gallery = const [],
  });
}

/// A testimonial from a colleague/supervisor, linking to their LinkedIn.
class Testimonial {
  final String name;
  final String title;
  final String quote;
  final String avatarAsset;
  final String linkedinUrl;
  const Testimonial({
    required this.name,
    required this.title,
    required this.quote,
    required this.avatarAsset,
    required this.linkedinUrl,
  });
}

/// A showcased project.
class Project {
  /// URL identifier for the case-study page (`/works/<slug>`).
  final String slug;
  final String title;
  final String description;
  final List<String> tags;
  final String? imageAsset;
  final String? liveUrl;
  final String? appStoreUrl;
  final String? playStoreUrl;
  final CaseStudy? caseStudy;
  const Project({
    required this.slug,
    required this.title,
    required this.description,
    required this.tags,
    this.imageAsset,
    this.liveUrl,
    this.appStoreUrl,
    this.playStoreUrl,
    this.caseStudy,
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

  // ---------------------------------------------------------------------------
  // NOTE(binh): The CaseStudy blocks below are DRAFT copy — the My-T Wallet
  // one is based on your notes, the others are extrapolated from the short
  // card descriptions. Review every line — especially roles, durations, team
  // context, tags, and findings — and replace with the real story before
  // shipping.
  // ---------------------------------------------------------------------------
  static const List<Project> projects = [
    Project(
      slug: 'thomson-touch',
      title: 'Thomson Touch',
      description:
          'Patient-facing app assisting users during hospital admission at '
          'Thomson Medical — pre-admission flows, appointment tracking, and '
          'in-centre navigation.',
      tags: ['Flutter', 'Dart', 'Firebase'],
      imageAsset: ImagesDirectory.thomsonTouch,
      caseStudy: CaseStudy(
        overview:
            'Thomson Touch is the patient-facing companion app for Thomson '
            'Medical in Singapore. It guides patients through hospital '
            'admission — pre-admission paperwork, appointment tracking, and '
            'finding their way around the centre — so a stressful day feels a '
            'little more manageable.',
        role: 'Lead Software Engineer',
        duration: '2024 — present',
        teamContext:
            'Healthcare product squad at Thomson X with PM, designers, and '
            'backend engineers.',
        highlights: [
          'Building patient-facing features across the admission journey.',
          'Implemented pre-admission flows with multi-step form validation.',
          'Built appointment tracking backed by Firebase.',
          'Delivered in-centre navigation to guide patients around the '
              'hospital.',
        ],
        findings: [
          Finding(
            problem:
                'Healthcare apps handle sensitive patient data, and every '
                'flow touches regulated information.',
            resolution:
                'Treated data privacy as a first-class requirement — strict '
                'data handling on-device and careful review of what is '
                'stored, logged, and transmitted.',
          ),
          Finding(
            problem:
                'Users are often stressed, elderly, or unfamiliar with apps '
                'when arriving for admission.',
            resolution:
                'Kept flows short and forgiving: clear progress, plain '
                'language, and generous touch targets.',
          ),
        ],
        outcome:
            'In active use at Thomson Medical as part of the patient '
            'admission experience — and the work I do today.',
        gallery: [ImagesDirectory.thomsonTouch2],
      ),
    ),
    Project(
      slug: 'ralali-connect',
      title: 'Ralali Connect',
      description:
          'B2B social platform for SMEs that lets merchants set up a storefront '
          'and tap into the business community. 50k+ downloads.',
      tags: ['Flutter', 'VueJS', 'Dart', 'JS'],
      imageAsset: ImagesDirectory.ralaliConnect,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.ralali.konekto',
      appStoreUrl: 'https://apps.apple.com/id/app/ralali-connect/id1590298867',
      caseStudy: CaseStudy(
        overview:
            'Ralali Connect is a B2B social commerce platform where Indonesian '
            'SMEs set up a digital storefront, join business communities, and '
            'trade with each other. I worked on the mobile app from its early '
            'stages through its public launch on both stores.',
        role: 'Lead Software Engineer',
        duration: '2021 — 2022',
        teamContext:
            'Cross-functional squad with a PM, a designer, and backend engineers.',
        highlights: [
          'Built core storefront and community features in Flutter.',
          'Implemented the merchant storefront setup flow end-to-end.',
          'Built the community feed with post creation, media, and engagement.',
          'Translated Figma designs into responsive, pixel-consistent UI.',
          'Contributed to the VueJS web companion for merchant tooling.',
          'Prepared releases and store submissions for iOS and Android.',
        ],
        findings: [
          Finding(
            problem:
                'Feed performance degraded as media-heavy posts accumulated.',
            resolution:
                'Introduced list virtualisation and image caching, keeping '
                'scrolling smooth on low-end Android devices common among the '
                'user base.',
          ),
          Finding(
            problem:
                'Two clients (mobile + web) drifted apart in behaviour against '
                'the same APIs.',
            resolution:
                'Aligned on shared API contracts and error-handling conventions '
                'with the backend team, cutting cross-platform bug reports.',
          ),
        ],
        outcome:
            'Launched on the App Store and Play Store, growing past 50k+ '
            'downloads.',
      ),
    ),
    Project(
      slug: 'my-t-wallet',
      title: 'My-T Wallet',
      description:
          "Tokoin's digital wallet app — where a bug isn't a glitch, it's "
          "someone's money. 10k+ downloads on the Play Store.",
      tags: ['Mobile', 'FinTech'],
      imageAsset: ImagesDirectory.myTWallet,
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.tokoin.wallet',
      caseStudy: CaseStudy(
        overview:
            "My-T Wallet is Tokoin's digital wallet. Wallet software is "
            'unforgiving: every balance, transaction, and top-up is real '
            'user money, so there is no room for mistakes. I worked as a '
            'mobile developer on the app, building complementary features '
            'and maintaining features across the whole app.',
        role: 'Mobile developer',
        duration: '2019 — 2020',
        teamContext: 'Mobile team at Tokoin.',
        highlights: [
          'Developed complementary features around the core wallet.',
          'Maintained and hardened existing features across the app.',
          'Verified changes against real-money flows before every release.',
        ],
        findings: [
          Finding(
            problem:
                "A wallet is effectively a banking system — users' balances "
                'are on the line, and a small regression can cost real money.',
            resolution:
                'Worked defensively: careful change scoping, thorough '
                'regression testing around money flows, and double-checking '
                'every edge case before release.',
          ),
        ],
        outcome:
            'Live on the Play Store with 10k+ downloads, handling real user '
            'funds day to day.',
      ),
    ),
    Project(
      slug: 'ralali-agent',
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
      slug: 'pap-partners-portal',
      title: 'PAP — Partners Portal',
      description:
          "Web platform for managing Thomson Medical's partner doctors — "
          'onboarding, profile management, and partnership administration.',
      tags: ['Flutter Web', 'Dart'],
      imageAsset: ImagesDirectory.partnersPortal,
    ),
    Project(
      slug: 'pizza-4ps-delivery',
      title: "Pizza 4P's Delivery",
      description:
          'Delivery web application built against provided design specs and '
          'API endpoints.',
      tags: ['ReactJS', 'JS'],
      imageAsset: ImagesDirectory.pizza4Ps,
    ),
  ];

  static const List<Testimonial> testimonials = [
    Testimonial(
      name: 'Trong Dinh',
      title: 'CTO of Tokoin',
      quote:
          '“George is one of the finest engineers I’ve had the privilege of '
          'collaborating with. He possesses a robust technical background and '
          'excels in communication. He effortlessly tackles new technical '
          'challenges with a strong commitment, consistently delivering '
          'high-quality solutions.”',
      avatarAsset: ImagesDirectory.trongDinh,
      linkedinUrl: 'https://www.linkedin.com/in/trongdth/',
    ),
    Testimonial(
      name: 'Nikita Devy Haryono',
      title: 'Product Manager of Ralali',
      quote:
          '“Working alongside Binh has been an absolute delight - his '
          'technical prowess, punctuality in task delivery, and commitment to '
          'meeting targets have consistently impressed our team. Binh\'s '
          'contributions extend beyond his coding skills; his ability to '
          'provide invaluable insights from multiple perspectives has greatly '
          'enriched the quality of our work and led to innovative solutions. '
          'His friendly and collaborative nature make him not only a '
          'wonderful coworker but also a supportive team player, always '
          'willing to lend a hand to his colleagues. In all aspects, Binh '
          'embodies the ideal developer and teammate, and I wholeheartedly '
          'recommend him as a true asset to any project or team fortunate '
          'enough to have him.”',
      avatarAsset: ImagesDirectory.nikita,
      linkedinUrl: 'https://www.linkedin.com/in/nikita-devy-haryono/',
    ),
  ];

  /// Featured projects (those with a full case study) in display order.
  static List<Project> get featuredProjects =>
      projects.where((p) => p.caseStudy != null).toList();

  /// The remaining projects shown as compact cards.
  static List<Project> get otherProjects =>
      projects.where((p) => p.caseStudy == null).toList();

  /// Looks up a project by its URL [slug]; returns null when unknown.
  static Project? projectBySlug(String slug) {
    for (final p in projects) {
      if (p.slug == slug) return p;
    }
    return null;
  }

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
