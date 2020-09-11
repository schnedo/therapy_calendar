import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/bloc/medication_entry_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/widgets/medication_entry/add.dart';

class AddMedicationEntry extends StatelessWidget {
  static const routeName = '/medication_entry/add';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).addMedicationEntryViewTitle),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    AddMedicationEntryFormField(
                      onSaved: (entry) {
                        context.bloc<MedicationEntryBloc>().add(entry);
                      },
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                          S.of(context).addMedicationEntryViewSubmitButton),
                    )
                  ],
                )),
          ),
        ),
      );
}
