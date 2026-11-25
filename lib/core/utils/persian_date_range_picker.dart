import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class _PersianDateLocalizations extends PersianMaterialLocalizations {
  const _PersianDateLocalizations();

  String _persianDigits(String value) {
    const digits = '۰۱۲۳۴۵۶۷۸۹';
    return value.replaceAllMapped(
        RegExp('[0-9]'), (match) => digits[int.parse(match[0]!)]);
  }

  @override
  String formatDecimal(int number) => _persianDigits(super.formatDecimal(number));
  @override
  String formatYear(DateTime date) => _persianDigits(super.formatYear(date));
  @override
  String formatMediumDate(DateTime date) => _persianDigits(super.formatMediumDate(date));
  @override
  String formatShortMonthDay(DateTime date) => _persianDigits(super.formatShortMonthDay(date));
  @override
  String formatShortDate(DateTime date) => _persianDigits(super.formatShortDate(date));
  @override
  String formatMonthYear(DateTime date) => _persianDigits(super.formatMonthYear(date));
  @override
  String formatFullDate(DateTime date) => _persianDigits(super.formatFullDate(date));
}

class _PersianDateLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _PersianDateLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'fa';
  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(const _PersianDateLocalizations());
  @override
  bool shouldReload(_PersianDateLocalizationsDelegate old) => false;
}

Widget _persianCalendar(BuildContext context, Widget? child) =>
    Localizations.override(
      context: context,
      locale: const Locale('fa', 'IR'),
      delegates: const [_PersianDateLocalizationsDelegate()],
      child: Directionality(textDirection: TextDirection.rtl, child: child!),
    );

class PersianDateRange {
  const PersianDateRange({required this.from, required this.to});

  final Jalali from;
  final Jalali to;
}

Future<PersianDateRange?> showPersianDateRangePicker(
  BuildContext context, {
  Jalali? initialFrom,
  Jalali? initialTo,
  Jalali? firstDate,
  Jalali? lastDate,
}) async {
  final first = firstDate ?? Jalali(1385, 8);
  final last = lastDate ?? Jalali(1450, 9);
  if (first > last) {
    throw ArgumentError('firstDate must not be later than lastDate');
  }
  Jalali withinBounds(Jalali date, Jalali minimum) =>
      date < minimum ? minimum : (date > last ? last : date);

  final from = await showPersianDatePicker(
    context: context,
    firstDate: first,
    lastDate: last,
    initialDate: withinBounds(initialFrom ?? Jalali.now(), first),
    builder: _persianCalendar,
  );
  if (from == null || !context.mounted) return null;

  final to = await showPersianDatePicker(
    context: context,
    firstDate: from,
    lastDate: last,
    initialDate: withinBounds(initialTo ?? Jalali.now(), from),
    builder: _persianCalendar,
  );
  if (to == null || !context.mounted) return null;
  return PersianDateRange(from: from, to: to);
}
