import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:therapy_calendar/bloc/theme_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';

class ThemeChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) => ListTile(
          title: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 9, child: Text(S.of(context).themeChooserLabel)),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<ThemeMode>(
                    isExpanded: true,
                    value: state,
                    items: [
                      const DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Icon(MdiIcons.brightnessAuto),
                      ),
                      const DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Icon(MdiIcons.brightness5),
                      ),
                      const DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Icon(MdiIcons.brightness1),
                      ),
                    ],
                    onChanged: context.bloc<ThemeBloc>().update,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
