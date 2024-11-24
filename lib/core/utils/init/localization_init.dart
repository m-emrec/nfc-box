part of "../../../main.dart";

/// This class is responsible for initializing the localization.
///
/// It has a static list of supported locales, path, and fallback locale.
class _LocalizationInit {
  static List<Locale> supportedLocales = const [
    Locale('en', 'US'),
    Locale('tr')
  ];
  static String path = 'lib/core/assets/translations';
  static Locale fallbackLocale = const Locale('en', 'US');

  Future<void> initLocale() async {
    await EasyLocalization.ensureInitialized();
  }
}
