import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/contact/user.dart';

class AddUserFormField extends StatefulWidget {
  const AddUserFormField(
      {this.onSaved, this.onChanged, Key key, this.initialValue})
      : super(key: key);

  final User initialValue;
  // ignore: diagnostic_describe_all_properties
  final FormFieldSetter<User> onSaved;
  // ignore: diagnostic_describe_all_properties
  final ValueChanged<User> onChanged;

  @override
  _AddUserFormFieldState createState() => _AddUserFormFieldState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User>('initialValue', initialValue));
  }
}

class _AddUserFormFieldState extends State<AddUserFormField> {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: TextField(
              decoration: InputDecoration(
                labelText: S.of(context).addUserBirthdateLabel,
              ),
              enabled: false,
              controller: _birthdateController,
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: S.of(context).addUserBodyMassLabel,
              suffixText: 'kg',
            ),
            initialValue: widget.initialValue?.bodyMass?.toString() ?? '',
            onSaved: (value) {
              _userBuilder.bodyMass = double.parse(value);
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+(\.[0-9]*)?'))
            ],
            validator: (value) => value.isEmpty
                ? S.of(context).addUserBodyMassInvalidValidation
                : null,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: S.of(context).addUserDiagnosisLabel,
            ),
            initialValue: widget.initialValue?.diagnosis ?? '',
            onSaved: (value) {
              _userBuilder.diagnosis = value;
            },
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: S.of(context).addUserFullNameLabel,
            ),
            initialValue: widget.initialValue?.fullName ?? '',
            onSaved: (value) {
              _userBuilder.fullName = value;
            },
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: S.of(context).addUserAddressLabel,
            ),
            initialValue: widget.initialValue?.address ?? '',
            onSaved: (value) {
              _userBuilder.address = value;
            },
            keyboardType: TextInputType.streetAddress,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: S.of(context).addUserPhoneNumberLabel,
            ),
            initialValue: widget.initialValue?.phoneNumber ?? '',
            onSaved: (value) {
              _userBuilder.phoneNumber = value;
            },
            keyboardType: TextInputType.phone,
          ),
        ],
      );

  UserBuilder _userBuilder;
  final _birthdateController = TextEditingController();

  @override
  void initState() {
    _userBuilder = widget.initialValue?.toBuilder() ?? UserBuilder()
      ..bodyMass = 0
      ..birthdate = DateTime.now()
      ..address = ''
      ..diagnosis = ''
      ..fullName = ''
      ..phoneNumber = '';
    _birthdateController.text = _userBuilder.birthdate.toString();
    super.initState();
  }
}
