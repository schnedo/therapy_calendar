import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/contact/body_mass.dart';
import 'package:therapy_calendar/model/contact/user.dart';
import 'package:therapy_calendar/widgets/body_mass/add.dart';

class AddUserFormField extends FormField<User> {
  AddUserFormField({
    this.onChanged,
    FormFieldSetter<User>? onSaved,
    User? initialValue,
    bool editable = true,
    Key? key,
  })  : assert(
          onSaved != null || onChanged != null,
          'Either onChanged or onSaved have to be present',
        ),
        assert(
          editable || initialValue != null,
          'If it is not editable, an initialValue has to be provided',
        ),
        super(
          onSaved: onSaved,
          initialValue: initialValue,
          builder: (state) {
            // ignore: avoid_as
            final formState = state as _AddUserFormFieldState;

            return Builder(
              builder: (context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: S.of(context).addUserFullNameLabel,
                    ),
                    initialValue: initialValue?.fullName ?? '',
                    onChanged: formState.nameChanged,
                    keyboardType: TextInputType.text,
                    validator: (value) => value!.isEmpty
                        ? S.of(context).addUserFullNameInvalidValidation
                        : null,
                    enabled: editable,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: S.of(context).addUserBirthdateLabel,
                      enabled: editable,
                    ),
                    readOnly: true,
                    controller: formState._birthdateController,
                    onTap: editable
                        ? () {
                            Picker(
                              cancelText: S.of(context).addUserPickerCancelText,
                              confirmText:
                                  S.of(context).addUserPickerConfirmText,
                              adapter: DateTimePickerAdapter(
                                value: formState._builder.birthdate,
                                maxValue: DateTime.now(),
                              ),
                              title: Text(S.of(context).addUserDateLabel),
                              onConfirm: (picker, _) {
                                final p =
                                    // ignore: avoid_as
                                    picker.adapter as DateTimePickerAdapter;
                                formState.dateChanged(p.value);
                              },
                            ).showModal(context);
                          }
                        : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: S.of(context).addUserAddressLabel,
                    ),
                    initialValue: initialValue?.address ?? '',
                    onChanged: formState.addressChanged,
                    keyboardType: TextInputType.streetAddress,
                    enabled: editable,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: S.of(context).addUserPhoneNumberLabel,
                    ),
                    initialValue: initialValue?.phoneNumber ?? '',
                    onChanged: formState.phoneNumberChanged,
                    keyboardType: TextInputType.phone,
                    enabled: editable,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: S.of(context).addUserDiagnosisLabel,
                    ),
                    initialValue: initialValue?.diagnosis ?? '',
                    onChanged: formState.diagnosisChanged,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    enabled: editable,
                  ),
                  AddBodyMassFormField(
                    initialValue: initialValue?.bodyMass,
                    onChanged: formState.bodyMassChanged,
                    editable: editable,
                  ),
                ],
              ),
            );
          },
          key: key,
        );

  // ignore: diagnostic_describe_all_properties
  final ValueChanged<User>? onChanged;

  @override
  _AddUserFormFieldState createState() => _AddUserFormFieldState();
}

class _AddUserFormFieldState extends FormFieldState<User> {
  late final UserBuilder _builder;

  final _birthdateController = TextEditingController();

  String get _date => DateFormat.yMd().format(_builder.birthdate);

  @override
  void initState() {
    super.initState();
    _builder = widget.initialValue?.toBuilder() ?? UserBuilder()
      ..birthdate = DateTime.now()
      ..phoneNumber = ''
      ..address = ''
      ..fullName = ''
      ..diagnosis = ''
      ..bodyMass.amount = 0;
    _birthdateController.text = _date;
  }

  void dateChanged(DateTime date) {
    _builder.birthdate = date;
    _birthdateController.text = _date;
    _changed();
  }

  void bodyMassChanged(BodyMass bodyMass) {
    _builder.bodyMass = bodyMass.toBuilder();
    _changed();
  }

  void diagnosisChanged(String diagnosis) {
    _builder.diagnosis = diagnosis;
    _changed();
  }

  void nameChanged(String name) {
    _builder.fullName = name;
    _changed();
  }

  void addressChanged(String address) {
    _builder.address = address;
    _changed();
  }

  void phoneNumberChanged(String phoneNumber) {
    _builder.phoneNumber = phoneNumber;
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

    // ignore: avoid_as
    final w = widget as AddUserFormField;
    try {
      final user = _builder.build();
      if (w.onChanged != null) {
        w.onChanged!(user);
      }

      didChange(user);
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      // this should be a built_value error, which we will ignore here
      // the first change reported will be the change to a correct object
    }
  }

  @override
  void dispose() {
    _birthdateController.dispose();
    super.dispose();
  }
}
