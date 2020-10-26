import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:therapy_calendar/generated/l10n.dart';

class TakePicture extends StatelessWidget {
  const TakePicture({Key key, this.photoTakenCallback}) : super(key: key);

  final Function(String path, String description) photoTakenCallback;

  @override
  Widget build(BuildContext context) {
    final cameras = availableCameras();

    return FutureBuilder<List<CameraDescription>>(
      future: cameras,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return TakePictureScreen(
            cameras: snapshot.data,
            photoTakenCallback: photoTakenCallback,
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
    properties.add(DiagnosticsProperty<Function>(
        'photoTakenCallback', photoTakenCallback));
  }
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen(
      {@required this.cameras, Key key, this.photoTakenCallback})
      : super(key: key);

  final List<CameraDescription> cameras;
  final Function(String path, String description) photoTakenCallback;

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<CameraDescription>('cameras', cameras))
      ..add(DiagnosticsProperty<Function(String path, String description)>(
          'photoTakenCallback', photoTakenCallback));
  }
}

class _TakePictureScreenState extends State<TakePictureScreen> {
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
              await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  content: Text(S.of(ctx).takePictureDialogText),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(S.of(ctx).takePictureCancelLabel),
                    ),
                    FlatButton(
                      onPressed: () {
                        widget.photoTakenCallback(path, 'foo');
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(S.of(ctx).takePictureOkLabel),
                    ),
                  ],
                ),
              );
              // ignore: avoid_catches_without_on_clauses
            } catch (e) {
              // ignore: avoid_print
              print(e);
            }
          },
          child: const Icon(Icons.camera_alt),
        ),
      );
}
