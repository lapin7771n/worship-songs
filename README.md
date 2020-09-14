# worshipsongs

Worship Songs

To generate translations from .arb: 
```
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n/dart/ \
   --no-use-deferred-loading lib/localizations/resources/string_resources.dart lib/l10n/arb/intl_*.arb
```
To generate arb:
```
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n/arb lib/localizations/resources/string_resources.dart
```