import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TakePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cameras = availableCameras();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera testing'),
      ),
      body: FutureBuilder<List<CameraDescription>>(
        future: cameras,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return TakePictureScreen(cameras: snapshot.data);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({@required this.cameras, Key key}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<CameraDescription>('cameras', cameras));
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
      ResolutionPreset.low,
    );

    _initializeController = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _initializeController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
}
