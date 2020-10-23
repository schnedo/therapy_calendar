import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/model/contact/doctor.dart';
import 'package:therapy_calendar/model/repository/contact_repository.dart';

class DoctorBloc extends Cubit<Doctor?> {
  DoctorBloc(this._doctorRepository) : super(null) {
    _doctorRepository.get().then(emit);
  }

  final ContactRepository<Doctor> _doctorRepository;

  Future<void> update(Doctor doctor) async {
    await _doctorRepository.save(doctor);
    emit(doctor);
  }
}
