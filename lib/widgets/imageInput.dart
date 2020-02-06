import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  Future<void> _takePicture() async {
    var image =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (image != null) {
      setState(() {
        _storedImage = image;
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      final savedImage = await image.copy('${appDir.path}/$fileName');
      widget.onSelectImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.grey,
              width: 1,
            )),
            child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                )
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton.icon(
          icon: Icon(Icons.camera),
          label: Text('Take Picture'),
          onPressed: _takePicture,
          textColor: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
