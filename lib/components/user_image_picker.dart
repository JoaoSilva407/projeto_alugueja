import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) onImagePick;

  UserImagePicker(this.onImagePick);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageFile;

  Future _pickImage(bool gallery) async {
    final picker = ImagePicker();
    final pickedImage = gallery
        ? await picker.getImage(
            source: ImageSource.gallery,
          )
        : await picker.getImage(
            source: ImageSource.camera,
          );

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onImagePick(_pickedImageFile);
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: new Icon(
                    Icons.add_a_photo,
                    color: Colors.teal,
                  ),
                  title: new Text('Câmera'),
                  onTap: () {
                    _pickImage(false);
                  },
                ),
                ListTile(
                  leading: new Icon(
                    Icons.add_photo_alternate,
                    color: Colors.indigo,
                  ),
                  title: new Text('Galeria'),
                  onTap: () {
                    _pickImage(true);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: _pickedImageFile == null
              ? Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                )
              : null,
          backgroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile) : null,
        ),
        TextButton.icon(
          onPressed: () {
            _configurandoModalBottomSheet(context);
          },
          icon: Icon(Icons.image),
          label: Text('Adicionar Imagem'),
        ),
      ],
    );
  }
}
