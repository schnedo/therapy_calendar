import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:therapy_calendar/bloc/color_bloc.dart';
import 'package:therapy_calendar/bloc/theme_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';

class ThemeColorChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: BlocBuilder<ThemeBloc, ThemeMode>(
                  builder: (context, state) =>
                      DropdownButtonFormField<ThemeMode>(
                    decoration: InputDecoration(
                      labelText: S.of(context).themeChooserLabel,
                    ),
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
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: BlocBuilder<ColorBloc, Color>(
                  builder: (context, state) => DropdownButtonFormField<Color>(
                    decoration: InputDecoration(
                      labelText: S.of(context).colorChooserLabel,
                    ),
                    isExpanded: true,
                    value: state,
                    items: context
                        .bloc<ColorBloc>()
                        .possibleColors
                        .map(
                          (color) => DropdownMenuItem(
                            value: color,
                            child: Icon(
                              MdiIcons.brightness1,
                              color: color,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: context.bloc<ColorBloc>().update,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
