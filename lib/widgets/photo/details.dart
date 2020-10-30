import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:therapy_calendar/generated/l10n.dart';
import 'package:therapy_calendar/model/entry/photo.dart';
import 'package:therapy_calendar/widgets/photo/add.dart';

class PhotoDetails extends StatefulWidget {
  const PhotoDetails({
    @required this.initialValue,
    this.initiallyEditable = false,
    this.onPhotoChanged,
    this.onChangeCancel,
    Key key,
  }) : super(key: key);

  final PhotoTakenCallback onPhotoChanged;
  final GestureTapCallback onChangeCancel;
  final Photo initialValue;
  final bool initiallyEditable;

  @override
  _PhotoDetailsState createState() => _PhotoDetailsState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Photo>('initialValue', initialValue))
      ..add(ObjectFlagProperty<PhotoTakenCallback>.has(
          'onPhotoChanged', onPhotoChanged))
      ..add(DiagnosticsProperty<bool>('initiallyEditable', initiallyEditable))
      ..add(ObjectFlagProperty<GestureTapCallback>.has(
          'onChangeCancel', onChangeCancel));
  }
}

class _PhotoDetailsState extends State<PhotoDetails> {
  final _formKey = GlobalKey<FormState>();

  File get _photoFile => File(_builder.path);

  PhotoBuilder _builder;
  bool _editable;

  @override
  void initState() {
    super.initState();
    _builder = widget.initialValue.toBuilder()..description ??= '';
    _editable = widget.initiallyEditable && widget.onPhotoChanged != null;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            _editable
                ? S.of(context).takePictureDescriptionTitle
                : S.of(context).pictureDetailsTitle,
          ),
          actions: [
            if (!_editable && widget.onPhotoChanged != null)
              IconButton(
                onPressed: () {
                  setState(() {
                    _editable = true;
                  });
                },
                icon: const Icon(Icons.edit),
              )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.file(_photoFile),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: S.of(context).takePictureDescriptionLabel,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onSaved: (description) =>
                        _builder.description = description,
                    initialValue: _builder.description,
                    enabled: _editable,
                  ),
                  if (_editable)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            if (widget.onChangeCancel != null) {
                              widget.onChangeCancel();
                            }

                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).takePictureCancelLabel),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              widget.onPhotoChanged(_builder.build());

                              Navigator.pop(context);
                            }
                          },
                          child: Text(S.of(context).takePictureSubmitLabel),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      );
}
