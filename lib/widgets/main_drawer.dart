import 'package:flutter/material.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/views/doctor_profile.dart';
import 'package:therapy_calendar/views/user_profile.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 12,
                    child: Text(
                      S.of(context).dayViewTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(S.of(context).patientData),
              onTap: () {
                Navigator.pushNamed(context, UserProfile.routeName);
              },
            ),
            ListTile(
              title: Text(S.of(context).doctorData),
              onTap: () {
                Navigator.pushNamed(context, DoctorProfile.routeName);
              },
            ),
          ],
        ),
      );
}
