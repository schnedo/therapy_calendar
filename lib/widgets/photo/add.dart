import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:therapy_calendar/model/entry/photo.dart';
import 'package:therapy_calendar/widgets/photo/details.dart';

typedef PhotoTakenCallback = void Function(Photo photo);

class AddPhoto extends StatelessWidget {
  const AddPhoto({
    @required this.onPhotoTaken,
    Key key,
  }) : super(key: key);

  final PhotoTakenCallback onPhotoTaken;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => _TakePicture(
              onPhotoTaken: onPhotoTaken,
            ),
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<PhotoTakenCallback>.has(
        'onPhotoTaken', onPhotoTaken));
  }
}

class _TakePicture extends StatelessWidget {
  const _TakePicture({
    @required this.onPhotoTaken,
    Key key,
  }) : super(key: key);

  final PhotoTakenCallback onPhotoTaken;

  @override
  Widget build(BuildContext context) {
    final cameras = availableCameras();

    return FutureBuilder<List<CameraDescription>>(
      future: cameras,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _TakePictureScreen(
            cameras: snapshot.data,
            onPhotoTaken: onPhotoTaken,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<PhotoTakenCallback>('onPhotoTaken', onPhotoTaken));
  }
}

class _TakePictureScreen extends StatefulWidget {
  const _TakePictureScreen({@required this.cameras, Key key, this.onPhotoTaken})
      : super(key: key);

  final List<CameraDescription> cameras;
  final PhotoTakenCallback onPhotoTaken;

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<CameraDescription>('cameras', cameras))
      ..add(DiagnosticsProperty<PhotoTakenCallback>(
          'onPhotoTaken', onPhotoTaken));
  }
}

class _TakePictureScreenState extends State<_TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeController;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.medium,
    );

    _initializeController = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder(
          future: _initializeController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              await _initializeController;

              final path = join(
                (await getApplicationDocumentsDirectory()).path,
                '${DateTime.now()}.png',
              );
              await _controller.takePicture(path);

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PhotoDetails(
                    initialValue: Photo(
                      (b) => b
                        ..path = path
                        ..description = '',
                    ),
                    onPhotoChanged: (photo) {
                      widget.onPhotoTaken(photo);
                      Navigator.pop(context);
                    },
                    initiallyEditable: true,
                    onChangeCancel: () => File(path).delete(),
                  ),
                ),
              );
              // ignore: avoid_catches_without_on_clauses
            } catch (e) {
              debugPrint(e);
            }
          },
          child: const Icon(Icons.camera_alt),
        ),
      );
}
