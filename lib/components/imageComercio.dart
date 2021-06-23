import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class ImageComercio extends StatefulWidget {
  final Function(File pickedImage) onImagePick;

  ImageComercio(
    this.onImagePick,
  );

  @override
  _ImageComercioState createState() => _ImageComercioState();
}

class _ImageComercioState extends State<ImageComercio> {
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
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primeiraCor,
            quartaCor,
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          _pickedImageFile == null
              ? Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 140,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Icon(Icons.store, size: 100, color: segundaCor),
                      Text(
                        'Adicione uma foto do seu negócio',
                        style: TextStyle(fontSize: 20, color: segundaCor),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_pickedImageFile),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
          TextButton.icon(
            onPressed: () {
              _configurandoModalBottomSheet(context);
            },
            icon: Icon(Icons.image, color: Colors.white),
            label: Text(
              'Adicionar imagem',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
