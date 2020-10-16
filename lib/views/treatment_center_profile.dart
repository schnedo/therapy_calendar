import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/bloc/treatment_center_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/contact/treatment_center.dart';
import 'package:therapy_calendar/widgets/treatment_center/add.dart';

class TreatmentCenterProfile extends StatefulWidget {
  static const routeName = '/treatmentCenterData';

  @override
  _TreatmentCenterProfileState createState() => _TreatmentCenterProfileState();
}

class _TreatmentCenterProfileState extends State<TreatmentCenterProfile> {
  final _formKey = GlobalKey<FormState>();

  bool _editable = false;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TreatmentCenterBloc, TreatmentCenter>(
        builder: (context, doctor) {
          if (doctor == null && !_editable) {
            _editable = true;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).treatmentCenterData),
              actions: [
                if (!_editable)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _editable = true;
                      });
                    },
                    icon: const Icon(Icons.edit),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      AddTreatmentCenterFormField(
                        onSaved: context.bloc<TreatmentCenterBloc>().update,
                        editable: _editable,
                        initialValue: doctor,
                      ),
                      if (_editable)
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              setState(() {
                                _editable = false;
                              });
                            }
                          },
                          child: Text(S.of(context).addUserViewSubmitButton),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
