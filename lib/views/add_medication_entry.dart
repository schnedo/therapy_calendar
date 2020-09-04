import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/bloc/medication_entry_bloc.dart';
import 'package:therapy_calendar/model/medication_entry.dart';

class AddMedicationEntry extends StatelessWidget {
  static const routeName = '/medication_entry/add';

  final _formKey = GlobalKey<FormState>();
  final _builder = MedicationEntryBuilder();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Neuer Eintrag'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                RaisedButton(
                  onPressed: () => showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    lastDate: DateTime.now(),
                    firstDate: DateTime(2020),
                  ).then((value) => _builder.date = value),
                  child: const Text('Datum eingeben'),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Medikamentenbezeichnung'),
                  validator: (value) => value.isEmpty
                      ? 'Bitte Medikamentenbezeichnung eingeben'
                      : null,
                  onSaved: (value) {
                    //_builder.medication.name = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Chargennummer'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      value.isEmpty ? 'Bitte Chargennummer eingeben' : null,
                  onSaved: (value) {
                    // _builder.medication.batchNumber = int.parse(value);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Einzeldosis'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      value.isEmpty ? 'Bitte Einzeldosis eingeben' : null,
                  onSaved: (value) {
                    //_builder.dose.singleDose = int.parse(value);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Anzahl Dosen'),
                  initialValue: '1',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      value.isEmpty ? 'Bitte Anzahl Dosen eingeben' : null,
                  onSaved: (value) {
                    //_builder.dose.count = int.parse(value);
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      context.bloc<MedicationEntryBloc>().add(_builder.build());
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('speichern'),
                )
              ],
            ),
          ),
        ),
      );
}
