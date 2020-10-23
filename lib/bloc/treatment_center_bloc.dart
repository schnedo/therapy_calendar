import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/model/contact/treatment_center.dart';
import 'package:therapy_calendar/model/repository/contact_repository.dart';

class TreatmentCenterBloc extends Cubit<TreatmentCenter?> {
  TreatmentCenterBloc(this._treatmentRepository) : super(null) {
    _treatmentRepository.get().then(emit);
  }

  final ContactRepository<TreatmentCenter> _treatmentRepository;

  Future<void> update(TreatmentCenter center) async {
    await _treatmentRepository.save(center);
    emit(center);
  }
}
