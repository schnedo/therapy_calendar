import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:therapy_calendar/model/entry/photo.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({Key key, this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Icon(Icons.photo),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(photo.description),
              ),
            ],
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Photo>('photo', photo));
  }
}
