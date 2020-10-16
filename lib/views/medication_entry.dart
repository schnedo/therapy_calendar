import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/bloc/medication_entry_bloc.dart';
import 'package:therapy_calendar/bloc/user_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/entry/medication_entry.dart';
import 'package:therapy_calendar/widgets/medication_entry/add.dart';

class AddMedicationEntry extends StatefulWidget {
  const AddMedicationEntry({Key key, this.initialValue}) : super(key: key);

  static const routeName = '/medication_entry/add';

  final MedicationEntry initialValue;

  @override
  _AddMedicationEntryState createState() => _AddMedicationEntryState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<MedicationEntry>('initialValue', initialValue));
  }
}

class _AddMedicationEntryState extends State<AddMedicationEntry> {
  final _formKey = GlobalKey<FormState>();

  bool _editable;

  @override
  void initState() {
    super.initState();
    _editable = widget.initialValue != null;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_editable
              ? S.of(context).medicationEntryViewTitle
              : S.of(context).addMedicationEntryViewTitle),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  AddMedicationEntryFormField(
                    initialValue: widget.initialValue,
                    onSaved: (entry) {
                      Future(() {
                        final userBloc = context.bloc<UserBloc>();

                        if (userBloc.state != null) {
                          final updatedUser = userBloc.state.rebuild(
                            (b) => b..bodyMass = entry.bodyMass.toBuilder(),
                          );
                          userBloc.update(updatedUser);
                        }
                      });
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
                    child:
                        Text(S.of(context).addMedicationEntryViewSubmitButton),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
