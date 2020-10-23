import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:therapy_calendar/model/entry/dose.dart';
import 'package:therapy_calendar/model/entry/medicament.dart';
import 'package:therapy_calendar/model/entry/medication.dart';
import 'package:therapy_calendar/widgets/dose/add.dart';
import 'package:therapy_calendar/widgets/medicament/add.dart';

class AddMedicationFormField extends FormField<Medication> {
  AddMedicationFormField({
    FormFieldSetter<Medication>? onSaved,
    this.onChanged,
    Medication? initialValue,
    Key? key,
  })  : assert(onSaved != null || onChanged != null,
            'Either onChanged or onSaved have to be present'),
        super(
            initialValue: initialValue,
            onSaved: onSaved,
            builder: (state) {
              // ignore: avoid_as
              final formState = state as _AddMedicationFormFieldState;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AddDoseFormField(
                    onChanged: formState.doseChanged,
                    initialValue: initialValue?.dose,
                  ),
                  AddMedicamentFormField(
                    onChanged: formState.medicamentChanged,
                    initialValue: initialValue?.medicament,
                  ),
                ],
              );
            },
            key: key);

  // ignore: diagnostic_describe_all_properties
  final ValueChanged<Medication>? onChanged;

  @override
  _AddMedicationFormFieldState createState() => _AddMedicationFormFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<Medication>('initialValue', initialValue));
  }
}

class _AddMedicationFormFieldState extends FormFieldState<Medication> {
  late final MedicationBuilder _builder;

  @override
  void initState() {
    super.initState();
    _builder = widget.initialValue?.toBuilder() ?? MedicationBuilder();
  }

  void doseChanged(Dose dose) {
    _builder.dose = dose.toBuilder();
    _changed();
  }

  void medicamentChanged(Medicament medicament) {
    _builder.medicament = medicament.toBuilder();
    _changed();
  }

  void _changed() {
    // ignore: avoid_as
    final f = widget as AddMedicationFormField;
    try {
      final value = _builder.build();

      if (f.onChanged != null) {
        f.onChanged!(value);
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
