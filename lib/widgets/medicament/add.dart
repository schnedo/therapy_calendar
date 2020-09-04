import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/batch_number.dart';
import 'package:therapy_calendar/model/medicament.dart';
import 'package:therapy_calendar/widgets/batch_number/add.dart';

class AddMedicamentFormField extends FormField<Medicament> {
  AddMedicamentFormField({FormFieldSetter<Medicament> onSaved, this.onChanged})
      : assert(onSaved != null || onChanged != null,
            'Either onChanged or onSaved have to be present'),
        super(
            onSaved: onSaved,
            builder: (field) {
              final _AddMedicamentFormFieldState formState = field;

              return Builder(
                builder: (context) => Column(
                  children: [
                    AddBatchNumberFormField(
                      onChanged: formState.batchNumberChanged,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: S.of(context).addMedicamentNameLabel,
                      ),
                      validator: (value) => value.isEmpty
                          ? S.of(context).addMedicamentNameInvalidValidation
                          : null,
                      onChanged: formState.nameChanged,
                    ),
                  ],
                ),
              );
            });

  // ignore: diagnostic_describe_all_properties
  final ValueChanged<Medicament> onChanged;

  @override
  _AddMedicamentFormFieldState createState() => _AddMedicamentFormFieldState();
}

class _AddMedicamentFormFieldState extends FormFieldState<Medicament> {
  final MedicamentBuilder _builder = MedicamentBuilder();

  void batchNumberChanged(BatchNumber batchNumber) {
    _builder.batchNumber = batchNumber.toBuilder();
    _changed();
  }

  void nameChanged(String name) {
    _builder.name = name;
    _changed();
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

  void _changed() {
    final AddMedicamentFormField f = widget;
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
}
