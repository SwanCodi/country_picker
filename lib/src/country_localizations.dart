import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryLocalizations {
  final Locale locale;

  CountryLocalizations(this.locale);

  static CountryLocalizations? of(BuildContext context) {
    return Localizations.of<CountryLocalizations>(
      context,
      CountryLocalizations,
    );
  }

  static const LocalizationsDelegate<CountryLocalizations> delegate = _CountryLocalizationsDelegate();

  static LocalizationsDelegate<CountryLocalizations> getDelegate({bool enableLocalization = true}) {
    return _CountryLocalizationsDelegate(enableLocalization: enableLocalization);
  }

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('packages/country_code_picker/src/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String? translate(String? key) {
    return _localizedStrings[key!];
  }
}

class _CountryLocalizationsDelegate extends LocalizationsDelegate<CountryLocalizations> {
  final bool enableLocalization;

  const _CountryLocalizationsDelegate({this.enableLocalization = true});

  @override
  bool isSupported(Locale locale) {
    return [
      "ar",
      "en",
    ].contains(locale.languageCode);
  }

  @override
  Future<CountryLocalizations> load(Locale locale) async {
    // Use the provided locale if localization is enabled; otherwise, use English.
    Locale effectiveLocale = enableLocalization ? locale : const Locale('en');

    CountryLocalizations localizations = CountryLocalizations(effectiveLocale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_CountryLocalizationsDelegate old) => false;
}
