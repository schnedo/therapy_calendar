import 'package:flutter/material.dart';
import 'package:therapy_calendar/generated/l10n.dart';

class UserProfile extends StatelessWidget {
  static const routeName = '/patientData';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).patientData),
        ),
        body: const Placeholder(),
      );
}
