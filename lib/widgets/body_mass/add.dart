import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/contact/body_mass.dart';

class AddBodyMassFormField extends StatelessWidget {
  const AddBodyMassFormField(
      {this.initialValue,
      this.onSaved,
      this.onChanged,
      this.editable = true,
      Key? key})
      : assert(
          onSaved != null || onChanged != null,
          'Either onChanged or onSaved have to be present',
        ),
        assert(
          editable || initialValue != null,
          'If it is not editable, an initialValue has to be provided',
        ),
        super(key: key);

  final bool editable;
  final BodyMass? initialValue;
  // ignore: diagnostic_describe_all_properties
  final FormFieldSetter<BodyMass>? onSaved;
  // ignore: diagnostic_describe_all_properties
  final ValueChanged<BodyMass>? onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
        initialValue: initialValue?.amount.toString() ?? '',
        decoration: InputDecoration(
          labelText: S.of(context).addUserBodyMassLabel,
          suffixText: BodyMass.unit,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) => value!.isEmpty
            ? S.of(context).addUserBodyMassInvalidValidation
            : null,
        onSaved: onSaved != null
            ? (value) {
                final amount = int.parse(value!);
                onSaved!(BodyMass((b) => b..amount = amount));
              }
            : null,
        onChanged: onChanged != null
            ? (value) {
                final amount = int.parse(value);
                onChanged!(BodyMass((b) => b.amount = amount));
              }
            : null,
        enabled: editable,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BodyMass>('initialValue', initialValue))
      ..add(DiagnosticsProperty<bool>('editable', editable));
  }
}
