import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:therapy_calendar/bloc/user_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/contact/body_mass.dart';
import 'package:therapy_calendar/model/entry/medication.dart';
import 'package:therapy_calendar/model/entry/medication_entry.dart';
import 'package:therapy_calendar/widgets/body_mass/add.dart';
import 'package:therapy_calendar/widgets/medication/add.dart';
import 'package:therapy_calendar/widgets/medication/card.dart';

String _formatValue(num number) => number.toString().padLeft(2, '0');

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
                    TextField(
                      decoration: InputDecoration(
                          labelText: S.of(context).addMedicationEntryDateLabel),
                      controller: formState._dateController,
                      readOnly: true,
                      onTap: () {
                        Picker(
                          cancelText:
                              S.of(context).addMedicationEntryPickerCancelText,
                          confirmText:
                              S.of(context).addMedicationEntryPickerConfirmText,
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
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText:
                              S.of(context).addMedicationEntryDurationLabel),
                      controller: formState._durationController,
                      readOnly: true,
                      onTap: () {
                        Picker(
                          cancelText:
                              S.of(context).addMedicationEntryPickerCancelText,
                          confirmText:
                              S.of(context).addMedicationEntryPickerConfirmText,
                          looping: true,
                          magnification: 2,
                          squeeze: 0.9,
                          adapter: NumberPickerAdapter(data: [
                            NumberPickerColumn(
                              initValue: formState._builder.duration.hours,
                              begin: 0,
                              end: 24,
                              onFormatValue: _formatValue,
                            ),
                            NumberPickerColumn(
                              initValue: formState._builder.duration.minutes,
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
                            formState.durationChanged(
                                selecteds[0], selecteds[1] * stepSize);
                          },
                        ).showModal(context);
                      },
                    ),
                    AddBodyMassFormField(
                      onChanged: formState.bodyMassChanged,
                      initialValue: context.bloc<UserBloc>().state?.bodyMass,
                    ),
                    const Divider(),
                    Text(S.of(context).addMedicationEntryMedicationsLabel),
                    ...formState.medicationWidgets(),
                    IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          formState.showMedicationDialog(context);
                        }),
                    const Divider(),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText:
                              S.of(context).addMedicationEntryCommentsLabel),
                      onChanged: formState.commentChanged,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                ),
              );
            },
            key: key);

  static const stepSize = 5;

  // ignore: diagnostic_describe_all_properties
  final ValueChanged<MedicationEntry> onChanged;

  @override
  _AddMedicationEntryFormFieldState createState() =>
      _AddMedicationEntryFormFieldState();
}

extension _AbsoluteUnits on Duration {
  int get hours => inMinutes ~/ Duration.minutesPerHour;

  int get minutes => inMinutes % Duration.minutesPerHour;
}

extension _ReplaceMedication on ListBuilder<Medication> {
  void replaceMedication(Medication oldValue, Medication newValue) {
    final index = build().indexOf(oldValue);
    this[index] = newValue;
  }
}

class _AddMedicationEntryFormFieldState
    extends FormFieldState<MedicationEntry> {
  final MedicationEntryBuilder _builder = MedicationEntryBuilder();

  String get _date => DateFormat.yMd().format(_builder.date);

  final _dateController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  void initState() {
    _builder
      ..date = DateTime.now()
      ..duration = const Duration(hours: 1, minutes: 0)
      ..comments = ''
      ..bodyMass = context.bloc<UserBloc>().state?.bodyMass ?? BodyMassBuilder()
      ..medications = ListBuilder();
    _dateController.text = _date;
    _durationController.text = '${_formatValue(_builder.duration.hours)}'
        ':${_formatValue(_builder.duration.minutes)}';
    super.initState();

    try {
      didChange(_builder.build());
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {}
  }

  void bodyMassChanged(BodyMass bodyMass) {
    _builder.bodyMass = bodyMass;
    _changed();
  }

  void dateChanged(DateTime date) {
    _builder.date = date;
    _dateController.text = _date;
    _changed();
  }

  void commentChanged(String value) {
    _builder.comments = value;
    _changed();
  }

  void addMedication(Medication medication) {
    _builder.medications.add(medication);
    _changed();
  }

  void durationChanged(int hours, int minutes) {
    final duration = Duration(hours: hours, minutes: minutes);
    _builder.duration = duration;
    _durationController.text =
        '${_formatValue(hours)}:${_formatValue(minutes)}';
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

  void showMedicationDialog(BuildContext context, {Medication medication}) {
    showDialog(
      context: context,
      builder: (context) {
        final subFormKey = GlobalKey<FormState>();
        return AlertDialog(
          title: medication == null
              ? Text(S.of(context).addMedicationEntryAddMedicationLabel)
              : Text(S.of(context).addMedicationEntryEdictMedicationLabel),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).addMedicationEntryPickerCancelText),
            ),
            TextButton(
              onPressed: () {
                if (subFormKey.currentState.validate()) {
                  subFormKey.currentState.save();
                  Navigator.pop(context);
                }
              },
              child: Text(S.of(context).addMedicationEntryViewSubmitButton),
            ),
          ],
          content: Form(
            key: subFormKey,
            child: AddMedicationFormField(
              onSaved: medication == null
                  ? addMedication
                  : (newMedication) {
                      _builder.medications
                          .replaceMedication(medication, newMedication);
                      _changed();
                    },
              initialValue: medication,
            ),
          ),
        );
      },
    );
  }

  List<Widget> medicationWidgets() => _builder.medications
      .build()
      .toList()
      .map((medication) => Row(
            children: [
              Expanded(
                flex: 10,
                child: GestureDetector(
                  onTap: () {
                    showMedicationDialog(context, medication: medication);
                  },
                  child: MedicationCard(medication: medication),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () {
                    _builder.medications.remove(medication);
                    _changed();
                  },
                ),
              ),
            ],
          ))
      .toList();

  @override
  void dispose() {
    _dateController.dispose();
    _durationController.dispose();
    super.dispose();
  }
}
