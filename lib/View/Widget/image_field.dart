import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageField extends StatefulWidget {
  Function addFile;

  ImageField(this.addFile);

  @override
  _ImageFieldState createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                )
              : Text(
                  'No File Selected',
                  textAlign: TextAlign.center,
                ),
        ),
        TextButton.icon(
            label: Text('Pick an Image'),
            onPressed: () {
              showMyModal(context);
            },
            icon: Icon(Icons.add_a_photo_outlined)),
      ],
    );
  }

  void showMyModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(width: 4, color: Colors.grey),
                  horizontal: BorderSide(width: 8, color: Colors.grey),
                ),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 1,
                    child: Card(
                      elevation: 8,
                      child: TextButton.icon(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            final imagePicker = ImagePicker();
                            final x = await imagePicker.pickImage(
                                source: ImageSource.gallery, maxWidth: 600);
                            if (x == null) return;
                            _imageFile = File(x.path);
                            final appDir = await syspath
                                .getApplicationDocumentsDirectory();
                            final fileName = path.basename(x.path);
                            final savedPic = await _imageFile!
                                .copy('${appDir.path}/$fileName');
                            widget.addFile(savedPic);
                            setState(() {});
                            setState(() {});
                          },
                          icon: Icon(Icons.memory),
                          label: Text('Pick From Memory')),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Card(
                      elevation: 8,
                      child: TextButton.icon(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            final imagePicker = ImagePicker();
                            final x = await imagePicker.pickImage(
                                source: ImageSource.camera, maxWidth: 600);
                            if (x == null) return;
                            _imageFile = File(x.path);
                            final appDir = await syspath
                                .getApplicationDocumentsDirectory();
                            final fileName = path.basename(x.path);
                            final savedPic = await _imageFile!
                                .copy('${appDir.path}/$fileName');
                            widget.addFile(savedPic);
                            setState(() {});
                          },
                          icon: Icon(Icons.camera_alt),
                          label: Text('Pick From Camera')),
                    ),
                  )
                ],
              ),
            ));
  }
}
