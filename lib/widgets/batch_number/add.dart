import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/batch_number.dart';

class AddBatchNumberFormField extends StatelessWidget {
  const AddBatchNumberFormField({this.onSaved, this.onChanged, Key key})
      : assert(onSaved != null || onChanged != null,
            'Either onChanged or onSaved have to be present'),
        super(key: key);

  // ignore: diagnostic_describe_all_properties
  final FormFieldSetter<BatchNumber> onSaved;
  // ignore: diagnostic_describe_all_properties
  final ValueChanged<BatchNumber> onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
      decoration: InputDecoration(labelText: S.of(context).addBatchNumberLabel),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) =>
          value.isEmpty ? S.of(context).addBatchNumberInvalidValidation : null,
      onChanged: (value) {
        if (onChanged == null) {
          return;
        }

        final number = int.parse(value);
        onChanged(BatchNumber((b) => b..number = number));
      },
      onSaved: (value) {
        if (onSaved == null) {
          return;
        }

        final number = int.parse(value);
        onSaved(BatchNumber((b) => b..number = number));
      });
}
