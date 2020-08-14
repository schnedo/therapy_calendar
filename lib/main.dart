import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DayView(),
      );
}

class DataClass {
  final DateTime date;
  final String batch;
  final String dose;

  DataClass(this.date, this.batch, this.dose);
}

class DayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final def = DataClass(DateTime.now(), 'batch', 'dose');
    final defaultList = <DataClass>[];
    for (var i = 0; i < 100; i++) {
      defaultList.add(def);
    }
    Intl.defaultLocale = 'de_DE';
    initializeDateFormatting();

    return Scaffold(
      appBar: AppBar(title: const Text('Therapy Calendar')),
      body: Column(
        children: [
          ListTile(
              title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('DATUM'),
              const Text('BATCH'),
              const Text('DOSIS'),
            ],
          )),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                final item = defaultList[index];
                final date = DateFormat.E().add_d().format(item.date);

                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('$date $index'),
                      Text('${item.batch} $index'),
                      Text('${item.dose} $index'),
                    ],
                  ),
                );
              },
              itemCount: defaultList.length,
            ),
          )
        ],
      ),
    );
  }
}
