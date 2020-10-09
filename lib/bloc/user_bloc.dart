import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/model/contact/user.dart';
import 'package:therapy_calendar/model/repository/contact_repository.dart';

class UserBloc extends Cubit<User> {
  UserBloc(this._contactRepository) : super(null) {
    _contactRepository.get().then(emit);
  }

  final ContactRepository<User> _contactRepository;

  Future<void> update(User user) async {
    await _contactRepository.save(user);
    emit(user);
  }
}
