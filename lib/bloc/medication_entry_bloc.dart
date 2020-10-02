import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/model/medication_entry_repository.dart';

class MedicationEntryBloc extends Cubit<List<MedicationEntry>> {
  MedicationEntryBloc(this._medicationEntryRepository) : super(null) {
    _medicationEntryRepository.getAll().then(emit);
  }

  final MedicationEntryRepository _medicationEntryRepository;

  Future<void> add(MedicationEntry medicationEntry) async {
    final newEntries = [medicationEntry, ...state]
      ..sort((a, b) => b.date.compareTo(a.date));
    await _medicationEntryRepository.saveAll(newEntries);
    emit(newEntries);
  }

  Future<void> remove(MedicationEntry medicationEntry) async {
    final newEntries =
        state.where((element) => element != medicationEntry).toList();
    await _medicationEntryRepository.saveAll(newEntries);
    emit(newEntries);
  }
}
