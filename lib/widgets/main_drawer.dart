import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/views/doctor_profile.dart';
import 'package:therapy_calendar/views/treatment_center_profile.dart';
import 'package:therapy_calendar/views/user_profile.dart';
import 'package:therapy_calendar/widgets/theme/chooser.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
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
                  ListTile(
                    title: Text(S.of(context).treatmentCenterData),
                    onTap: () {
                      Navigator.pushNamed(
                          context, TreatmentCenterProfile.routeName);
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  const Divider(),
                  ThemeChooser(),
                  ListTile(
                    title: Text(S.of(context).drawerLicenses),
                    onTap: () async {
                      final infos = await PackageInfo.fromPlatform();
                      showAboutDialog(
                        context: context,
                        // TODO(all): add 'applicationIcon'
                        // TODO(all): add 'applicationLegalese'
                        applicationVersion:
                            '${infos.version}+${infos.buildNumber}',
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      );
}
