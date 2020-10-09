import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/bloc/user_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/contact/user.dart';
import 'package:therapy_calendar/widgets/user/add.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/patientData';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();

  bool _editable = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).patientData),
          actions: [
            if (!_editable)
              IconButton(
                onPressed: () {
                  setState(() {
                    _editable = true;
                  });
                },
                icon: const Icon(Icons.edit),
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  BlocBuilder<UserBloc, User>(
                    builder: (context, user) {
                      if (user == null && !_editable) {
                        _editable = true;
                      }

                      return AddUserFormField(
                        onSaved: context.bloc<UserBloc>().update,
                        editable: _editable,
                        initialValue: user,
                      );
                    },
                  ),
                  if (_editable)
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          setState(() {
                            _editable = false;
                          });
                        }
                      },
                      child: Text(S.of(context).addUserViewSubmitButton),
                    )
                ],
              ),
            ),
          ),
        ),
      );
}
