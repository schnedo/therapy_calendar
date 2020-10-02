import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:therapy_calendar/bloc/medication_entry_bloc.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/medication_entry.dart';
import 'package:therapy_calendar/pdf/pdf.dart';
import 'package:therapy_calendar/views/add_medication_entry.dart';
import 'package:therapy_calendar/widgets/medication_entry/card.dart';
import 'package:tuple/tuple.dart';

enum _Changes { delete }

extension _DateChunking on List<MedicationEntry> {
  List<List<MedicationEntry>> chunk() =>
      map((entry) => Tuple2(entry.date.month, entry.date.year))
          .toSet()
          .map((monthYear) => where((entry) =>
              entry.date.month == monthYear.item1 &&
              entry.date.year == monthYear.item2).toList())
          .toList();
}

class DayView extends StatelessWidget {
  static const routeName = '/';

  static final _dateFormatter = DateFormat.MMMM().add_y();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).dayViewTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.print),
              onPressed: () {
                toPdf(S.of(context), context.bloc<MedicationEntryBloc>().state);
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddMedicationEntry.routeName);
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            ListTile(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).dayViewDateHeader),
                Text(S.of(context).dayViewMedicationHeader),
                Text(S.of(context).dayViewDurationHeader),
              ],
            )),
            const Divider(),
            Expanded(
                child: BlocBuilder<MedicationEntryBloc, List<MedicationEntry>>(
              buildWhen: (_, __) => true,
              builder: (context, all) {
                if (all == null) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColorLight),
                      ),
                    ),
                  );
                }
                final entriesByMonth = all.chunk();

                return ListView.builder(
                  itemBuilder: (ctx, index) {
                    final entriesInSameMonth = entriesByMonth[index];

                    final cards = entriesInSameMonth
                        .map(
                          (entry) => GestureDetector(
                            onLongPressStart: (details) =>
                                longPressMenu(ctx, details, entry),
                            child: MedicationEntryCard(entry: entry),
                          ),
                        )
                        .toList();

                    return StickyHeader(
                      header: _TextDivider(
                        text: _dateFormatter
                            .format(entriesInSameMonth.first.date),
                      ),
                      content: Column(
                        children: cards,
                      ),
                    );
                  },
                  itemCount: entriesByMonth.length,
                );
              },
            )),
          ],
        ),
      );

  Future<void> longPressMenu(BuildContext context,
      LongPressStartDetails details, MedicationEntry medicationEntry) async {
    final result = await showMenu<_Changes>(
      context: context,
      // we don't know how this works...
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        PopupMenuItem(
          value: _Changes.delete,
          child: Text(S.of(context).dayViewDeleteLabel),
        ),
      ],
      elevation: 8,
    );

    switch (result) {
      case _Changes.delete:
        await context.bloc<MedicationEntryBloc>().remove(medicationEntry);
        break;
    }
  }
}

class _TextDivider extends StatelessWidget {
  const _TextDivider({@required this.text, Key key})
      : assert(text != null, 'Use "Divider()" instead.'),
        super(key: key);

  static const divider = Expanded(
    flex: 1,
    child: Divider(),
  );

  final String text;

  @override
  Widget build(BuildContext context) => Row(children: [
        divider,
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
            text,
          )),
        ),
        divider,
      ]);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
  }
}
