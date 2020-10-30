import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:therapy_calendar/model/entry/photo.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    @required this.photo,
    this.onTap,
    this.deleteTap,
    this.height = 120,
    Key key,
  }) : super(key: key);

  final Photo photo;
  final GestureTapCallback onTap;
  final double height;
  final GestureTapCallback deleteTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Image.file(
                  File(photo.path),
                  height: height,
                ),
                if (deleteTap != null)
                  IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: deleteTap,
                  ),
              ],
            ),
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Photo>('photo', photo))
      ..add(ObjectFlagProperty<GestureTapCallback>.has('onTap', onTap))
      ..add(DoubleProperty('height', height))
      ..add(ObjectFlagProperty<GestureTapCallback>.has('deleteTap', deleteTap));
  }
}
