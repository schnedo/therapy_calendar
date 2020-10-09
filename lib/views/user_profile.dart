import 'package:flutter/material.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/widgets/user/add.dart';

class UserProfile extends StatelessWidget {
  static const routeName = '/patientData';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).patientData),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const AddUserFormField(),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
                child: Text(S.of(context).addUserViewSubmitButton),
              )
            ],
          ),
        ),
      );
}
