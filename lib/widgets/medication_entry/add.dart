import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Picker(
                          adapter: DateTimePickerAdapter(
                            value: formState._builder.date,
                            maxValue: DateTime.now(),
                          ),
                          title:
                              Text(S.of(context).addMedicationEntryDateLabel),
                          onConfirm: (picker, _) {
                            final DateTimePickerAdapter p = picker.adapter;
                            formState.dateChanged(p.value);
                          },
                        ).showModal(context);
                      },
                      child:
                          Text('${S.of(context).addMedicationEntryDateLabel}: '
                              '${formState._date}'),
                    ),
                    TextButton(
                      onPressed: () {
                        Picker(
                          cancelText: S
                              .of(context)
                              .addMedicationEntryDurationTimePickerCancelText,
                          confirmText: S
                              .of(context)
                              .addMedicationEntryDurationTimePickerConfirmText,
                          looping: true,
                          magnification: 2,
                          squeeze: 0.9,
                          adapter: NumberPickerAdapter(data: [
                            NumberPickerColumn(
                              initValue: formState._hours,
                              begin: 0,
                              end: 24,
                              onFormatValue: _formatValue,
                            ),
                            NumberPickerColumn(
                              initValue: formState._minutes,
                              begin: 0,
                              end: 59,
                              jump: stepSize,
                              onFormatValue: _formatValue,
                            ),
                          ]),
                          delimiter: [
                            PickerDelimiter(
                                child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                ':',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ))
                          ],
                          title: Text(
                              S.of(context).addMedicationEntryDurationLabel),
                          onConfirm: (picker, selecteds) {
                            formState
                              .._hours = selecteds[0]
                              .._minutes = selecteds[1] * stepSize
                              ..durationChanged();
                          },
                        ).showModal(context);
                      },
                      child: Text(
                          '${S.of(context).addMedicationEntryDurationLabel}: '
                          '${_formatValue(formState._hours)}:'
                          '${_formatValue(formState._minutes)}'),
                    ),
                    AddMedicationFormField(
                      onChanged: formState.medicationChanged,
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

  static const stepSize = 5;

  // ignore: diagnostic_describe_all_properties
  final ValueChanged<MedicationEntry> onChanged;

  static String _formatValue(num number) => number.toString().padLeft(2, '0');

  @override
  _AddMedicationEntryFormFieldState createState() =>
      _AddMedicationEntryFormFieldState();
}

class _AddMedicationEntryFormFieldState
    extends FormFieldState<MedicationEntry> {
  final MedicationEntryBuilder _builder = MedicationEntryBuilder()
    ..date = DateTime.now();
  int _hours = 1;
  int _minutes = 0;

  String get _date => DateFormat.yMd().format(_builder.date);

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

  void durationChanged() {
    final duration = Duration(hours: _hours, minutes: _minutes);
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
    setState(() {});
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
