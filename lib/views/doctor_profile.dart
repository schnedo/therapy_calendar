import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_calendar/bloc/doctor_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/contact/doctor.dart';
import 'package:therapy_calendar/widgets/doctor/add.dart';

class DoctorProfile extends StatefulWidget {
  static const routeName = '/doctorData';

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final _formKey = GlobalKey<FormState>();

  bool _editable = false;

  @override
  Widget build(BuildContext context) => BlocBuilder<DoctorBloc, Doctor>(
        builder: (context, doctor) {
          if (doctor == null && !_editable) {
            _editable = true;
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).doctorData),
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
                      AddDoctorFormField(
                        onSaved: context.bloc<DoctorBloc>().update,
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
