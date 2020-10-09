import 'package:flutter/material.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/contact/doctor.dart';

class AddDoctorFormField extends FormField<Doctor> {
  AddDoctorFormField({
    this.onChanged,
    FormFieldSetter<Doctor> onSaved,
    Doctor initialValue,
    bool editable = true,
    Key key,
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
          key: key,
          builder: (state) {
            final _AddDoctorFormFieldState formState = state;

            return Builder(
              builder: (context) => Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).addUserFullNameLabel,
                  ),
                  initialValue: initialValue?.fullName ?? '',
                  onChanged: formState.nameChanged,
                  keyboardType: TextInputType.text,
                  enabled: editable,
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
              ]),
            );
          },
        );

  // ignore: diagnostic_describe_all_properties
  final ValueChanged<Doctor> onChanged;

  @override
  _AddDoctorFormFieldState createState() => _AddDoctorFormFieldState();
}

class _AddDoctorFormFieldState extends FormFieldState<Doctor> {
  DoctorBuilder _builder;

  @override
  void initState() {
    super.initState();
    _builder = widget.initialValue?.toBuilder() ?? DoctorBuilder()
      ..fullName = ''
      ..phoneNumber = ''
      ..address = '';
  }

  void nameChanged(String name) {
    _builder.fullName = name;
    _changed();
  }

  void phoneNumberChanged(String phoneNumber) {
    _builder.phoneNumber = phoneNumber;
    _changed();
  }

  void addressChanged(String address) {
    _builder.address = address;
    _changed();
  }

  void _changed() {
    setState(() {});

    final AddDoctorFormField w = widget;
    try {
      final doctor = _builder.build();
      if (w.onChanged != null) {
        w.onChanged(doctor);
      }

      didChange(doctor);
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      // this should be a built_value error, which we will ignore here
      // the first change reported will be the change to a correct object
    }
  }
}
