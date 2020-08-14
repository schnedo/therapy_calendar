import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/model/medication_entry.dart';

class MedicationEntryBloc extends Cubit<List<MedicationEntry>> {
  MedicationEntryBloc() : super([]);

  void add(MedicationEntry medicationEntry) {
    emit([...state, medicationEntry]);
  }
}
