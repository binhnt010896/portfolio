/// Centralised asset paths.
///
/// RULE: No inline image paths on pages. Always reference an entry here, e.g.
/// `Image.asset(ImagesDirectory.avatar)`.
class ImagesDirectory {
  ImagesDirectory._();

  static const String _base = 'assets/images';

  // Profile / branding
  static const String avatar = '$_base/avatar.png';
  static const String logoNoText = '$_base/logo_no_text.png';
  static const String headerLogo = '$_base/header_logo.png';
  static const String headerLogoInverted = '$_base/header_logo_inverted.png';
  static const String mainVisual = '$_base/main_visual.png';
  static const String iphoneMockup = '$_base/iphone_mockup.png';

  // Tech logos
  static const String flutterLogoWhite = '$_base/flutter_logo_white.png';
  static const String reactLogoWhite = '$_base/react_logo_white.png';

  // Education
  static const String fuas = '$_base/fuas.jpeg';
  static const String educationBg = '$_base/education_bg.jpeg';
  static const String contactBg = '$_base/contact_bg.jpeg';

  // Store badges
  static const String downloadAppStore = '$_base/download_appstore.png';
  static const String downloadPlayStore = '$_base/download_playstore.png';

  // Project screenshots
  static const String ralaliConnect = '$_base/ralaliconnect.png';
  static const String ralaliAgent = '$_base/ralaliagent.png';
  static const String pizza4Ps = '$_base/pizza4ps.png';
  static const String partnersPortal = '$_base/partners_portal.jpeg';
  static const String thomsonTouch = '$_base/thomson_touch.png';
  static const String thomsonTouch2 = '$_base/thomson_touch2.jpeg';
  static const String myTWallet = '$_base/t-wallet.jpeg';

  // Project logos
  static const String ralaliConnectLogo = '$_base/ralaliconnect_logo.webp';
  static const String ralaliAgentLogo = '$_base/ralaliagent_logo.webp';
  static const String myTWalletLogo = '$_base/t-wallet-logo.png';

  // Testimonial avatars
  static const String trongDinh = '$_base/trong_dinh.jpeg';
  static const String nikita = '$_base/nikita.jpeg';

  // Social / UI icons (svg)
  static const String _icons = 'assets/icons';
  static const String iconGithub = '$_icons/github.svg';
  static const String iconLinkedin = '$_icons/linkedin.svg';
  static const String iconEmail = '$_icons/email.svg';
}
