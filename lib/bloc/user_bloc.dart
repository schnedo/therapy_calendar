import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/model/contact/user.dart';
import 'package:therapy_calendar/model/repository/contact_repository.dart';

class UserBloc extends Cubit<User> {
  UserBloc(this._userRepository) : super(null) {
    _userRepository.get().then(emit);
  }

  final ContactRepository<User> _userRepository;

  Future<void> update(User user) async {
    await _userRepository.save(user);
    emit(user);
  }
}
