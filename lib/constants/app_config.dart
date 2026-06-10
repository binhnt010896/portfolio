/// App-wide configuration values.
class AppConfig {
  AppConfig._();

  /// Web3Forms access key used by the contact form to deliver submissions to
  /// [PortfolioData.email].
  ///
  /// Get a free key (no account needed) at https://web3forms.com — enter your
  /// email and they send you the key. Paste it here.
  ///
  /// This key is safe to ship in the client: it can only deliver to the email
  /// you registered it with, and Web3Forms rate-limits and spam-filters it.
  static const String web3formsAccessKey =
      '8d632a39-f98f-4036-b524-2203d069f6ff';

  /// Web3Forms submission endpoint.
  static const String web3formsEndpoint = 'https://api.web3forms.com/submit';

  /// Whether a real access key has been configured.
  static bool get hasContactFormKey =>
      web3formsAccessKey.isNotEmpty &&
      web3formsAccessKey != 'YOUR_WEB3FORMS_ACCESS_KEY';
}
