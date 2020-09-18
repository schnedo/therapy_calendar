import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/model/medication_entry.dart';

class MedicationEntryBloc extends Cubit<List<MedicationEntry>> {
  MedicationEntryBloc() : super([]);

  void add(MedicationEntry medicationEntry) {
    final newEntries = [medicationEntry, ...state]
      ..sort((a, b) => a.date.compareTo(b.date));
    emit(newEntries);
  }

  void remove(MedicationEntry medicationEntry) {
    emit(state.where((element) => element != medicationEntry).toList());
  }
}
