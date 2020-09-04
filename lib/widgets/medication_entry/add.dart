import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/medication.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/widgets/medication/add.dart';

class AddMedicationEntryFormField extends FormField<MedicationEntry> {
  AddMedicationEntryFormField(
      {this.onChanged, FormFieldSetter<MedicationEntry> onSaved, Key key})
      : assert(onSaved != null || onChanged != null,
            'Either onChanged or onSaved have to be present'),
        super(
            onSaved: onSaved,
            builder: (state) {
              final _AddMedicationEntryFormFieldState formState = state;

              return Builder(
                builder: (context) => Column(
                  children: [
                    RaisedButton(
                      onPressed: () => showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        lastDate: DateTime.now(),
                        firstDate: DateTime(2020),
                      ).then(formState.dateChanged),
                      child: Text(S.of(context).addMedicationEntryDateButton),
                    ),
                    AddMedicationFormField(
                      onChanged: formState.medicationChanged,
                    ),
                    RaisedButton(
                      onPressed: () => showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 0, minute: 0),
                        initialEntryMode: TimePickerEntryMode.dial,
                        builder: (context, child) => Localizations.override(
                          context: context,
                          locale: const Locale('de', 'DE'),
                          child: child,
                        ),
                        helpText: S
                            .of(context)
                            .addMedicationEntryDurationTimePickerHelpText,
                        confirmText: S
                            .of(context)
                            .addMedicationEntryDurationTimePickerConfirmText,
                        cancelText: S
                            .of(context)
                            .addMedicationEntryDurationTimePickerCancelText,
                      ).then(formState.durationChanged),
                      child:
                          Text(S.of(context).addMedicationEntryDurationLabel),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText:
                              S.of(context).addMedicationEntryCommentsLabel),
                      onChanged: formState.commentChanged,
                    ),
                  ],
                ),
              );
            },
            key: key);

  // ignore: diagnostic_describe_all_properties
  final ValueChanged<MedicationEntry> onChanged;

  @override
  _AddMedicationEntryFormFieldState createState() =>
      _AddMedicationEntryFormFieldState();
}

class _AddMedicationEntryFormFieldState
    extends FormFieldState<MedicationEntry> {
  final MedicationEntryBuilder _builder = MedicationEntryBuilder();

  void dateChanged(DateTime date) {
    _builder.date = date;
    _changed();
  }

  void commentChanged(String value) {
    _builder.comments = value;
    _changed();
  }

  void medicationChanged(Medication medication) {
    _builder.medications = ListBuilder([medication]);
    _changed();
  }

  void durationChanged(TimeOfDay timeOfDay) {
    final duration = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
    _builder.duration = duration;
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
    final AddMedicationEntryFormField f = widget;
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
