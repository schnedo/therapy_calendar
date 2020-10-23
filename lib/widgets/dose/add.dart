import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/entry/dose.dart';

class AddDoseFormField extends StatelessWidget {
  const AddDoseFormField(
      {this.onSaved, this.onChanged, this.initialValue, Key? key})
      : assert(onSaved != null || onChanged != null,
            'Either onChanged or onSaved have to be present'),
        super(key: key);

  final Dose? initialValue;
  // ignore: diagnostic_describe_all_properties
  final FormFieldSetter<Dose>? onSaved;
  // ignore: diagnostic_describe_all_properties
  final ValueChanged<Dose>? onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
        initialValue: initialValue?.amount.toString() ?? '',
        decoration: InputDecoration(
          labelText: S.of(context).addDoseLabel,
          suffixText: Dose.unit,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) =>
            value!.isEmpty ? S.of(context).addDoseInvalidValidation : null,
        onSaved: onSaved != null
            ? (value) {
                final amount = int.parse(value!);
                onSaved!(Dose((b) => b..amount = amount));
              }
            : null,
        onChanged: onChanged != null
            ? (value) {
                final amount = int.parse(value);
                onChanged!(Dose((b) => b..amount = amount));
              }
            : null,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Dose>('initialValue', initialValue));
  }
}
