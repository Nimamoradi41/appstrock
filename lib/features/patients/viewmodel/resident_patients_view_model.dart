import 'package:flutter/foundation.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../core/api_exception.dart';
import '../data/patient_repository.dart';

class ResidentPatientsViewModel extends ChangeNotifier {
  ResidentPatientsViewModel({PatientRepository? repository})
      : _repository = repository ?? PatientRepository(),
        from = Jalali.now(), to = Jalali.now();

  final PatientRepository _repository;
  Jalali from;
  Jalali to;
  bool isToday = true;
  bool loading = false;
  bool _disposed = false;
  int _generation = 0;
  String? error;
  List<PatientListEntry> patients = const [];

  static String formatDate(Jalali date) =>
      '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';

  Future<void> setRange(Jalali start, Jalali end) async {
    from = start;
    to = end;
    isToday = false;
    _generation++;
    patients = const [];
    error = null;
    notifyListeners();
    await refresh();
  }

  Future<void> showToday() async {
    from = to = Jalali.now();
    isToday = true;
    _generation++;
    patients = const [];
    error = null;
    notifyListeners();
    await refresh();
  }

  Future<void> refresh() async {
    if (loading || _disposed) return;
    if (isToday) from = to = Jalali.now();
    final generation = _generation;
    final start = formatDate(from);
    final end = formatDate(to);
    loading = true;
    error = null;
    notifyListeners();
    try {
      final result = isToday ? await _repository.listForDate(start)
          : await _repository.listBetweenDates(start, end);
      if (!_disposed && generation == _generation) patients = result;
    } on ApiException catch (e) {
      if (!_disposed && generation == _generation && !e.isCancelled) error = e.toString();
    } catch (e) {
      if (!_disposed && generation == _generation) {
        error = e is PatientListException ? e.message : 'دریافت فهرست بیماران ناموفق بود';
      }
    } finally {
      loading = false;
      if (!_disposed) {
        notifyListeners();
        if (generation != _generation) refresh();
      }
    }
  }

  @override
  void dispose() { _disposed = true; _generation++; super.dispose(); }
}
