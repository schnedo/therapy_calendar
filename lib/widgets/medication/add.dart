import 'package:flutter/material.dart';
import 'package:therapy_calendar/model/dose.dart';
import 'package:therapy_calendar/model/medicament.dart';
import 'package:therapy_calendar/model/medication.dart';
import 'package:therapy_calendar/widgets/dose/add.dart';
import 'package:therapy_calendar/widgets/medicament/add.dart';

class AddMedicationFormField extends FormField<Medication> {
  AddMedicationFormField(
      {FormFieldSetter<Medication> onSaved, this.onChanged, Key key})
      : assert(onSaved != null || onChanged != null,
            'Either onChanged or onSaved have to be present'),
        super(
            onSaved: onSaved,
            builder: (state) {
              final _AddMedicationFormFieldState formState = state;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AddDoseFormField(
                    onChanged: formState.doseChanged,
                  ),
                  AddMedicamentFormField(
                    onChanged: formState.medicamentChanged,
                  ),
                ],
              );
            },
            key: key);

  // ignore: diagnostic_describe_all_properties
  final ValueChanged<Medication> onChanged;

  @override
  _AddMedicationFormFieldState createState() => _AddMedicationFormFieldState();
}

class _AddMedicationFormFieldState extends FormFieldState<Medication> {
  final MedicationBuilder _builder = MedicationBuilder();

  void doseChanged(Dose dose) {
    _builder.dose = dose.toBuilder();
    _changed();
  }

  void medicamentChanged(Medicament medicament) {
    _builder.medicament = medicament.toBuilder();
    _changed();
  }

  void _changed() {
    final AddMedicationFormField f = widget;
    try {
      final value = _builder.build();

      if (f.onChanged != null) {
        f.onChanged(value);
      }

      didChange(value);
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      // this should be a built_value error, which we will ignore here
      // the first change reported will be the change to a correct object
    }
  }

  @override
  bool validate() {
    try {
      _builder.build();
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return false;
    }
  }
}
