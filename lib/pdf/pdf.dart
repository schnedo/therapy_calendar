import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/entry/medication.dart';
import 'package:therapy_calendar/model/entry/medication_entry.dart';

extension _PdfMedication on Medication {
  String toPdf() => '${medicament.name} / ${medicament.batchNumber}: $dose';
}

extension _PdfMedicationList on BuiltList<Medication> {
  static const separator = '\n';

  String toPdf() => map((e) => e.toPdf()).join(separator);
}

extension _PdfDate on DateTime {
  String toPdf() => DateFormat.yMd().format(this);
}

extension _PdfDuration on Duration {
  String get _hours =>
      (inMinutes ~/ Duration.minutesPerHour).toString().padLeft(2, '0');
  String get _minutes =>
      (inMinutes % Duration.minutesPerHour).toString().padLeft(2, '0');

  String toPdf() => '$_hours:$_minutes';
}

Future<void> toPdf(S s, List<MedicationEntry> entries) async {
  final doc = pw.Document()
    ..addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      orientation: pw.PageOrientation.landscape,
      build: (context) => [
        pw.Table.fromTextArray(
          data: [
            [
              s.dayViewDateHeader,
              s.dayViewMedicationHeader,
              s.dayViewDurationHeader,
              s.pdfBodyMass,
              s.addMedicationEntryCommentsLabel,
            ],
            ...entries
                .map((e) => [
                      e.date.toPdf(),
                      e.medications.toPdf(),
                      e.duration.toPdf(),
                      e.bodyMass,
                      e.comments,
                    ])
                .toList()
          ],
        )
      ],
    ));

  final path = await _savePdf(s, doc);
  await OpenFile.open(path);
}

Future<String> _savePdf(S s, pw.Document document) async {
  final path =
      '${(await getApplicationDocumentsDirectory()).path}/${s.pdfFileName}.pdf';

  final file = await File(path).create();
  await file.writeAsBytes(document.save());

  return path;
}
