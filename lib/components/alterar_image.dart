import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class AlterarImagem extends StatefulWidget {
  final Function(File pickedImage) onImagePick;
  final dynamic valorId;
  final dynamic userId;

  AlterarImagem(
    this.onImagePick,
    this.valorId,
    this.userId,
  );

  @override
  _AlterarImagemState createState() => _AlterarImagemState();
}

class _AlterarImagemState extends State<AlterarImagem> {
  final User user = FirebaseAuth.instance.currentUser;
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
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('publicacao')
          .doc(widget.valorId)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
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
              snapshot.data['imageUrl'] == ''
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
                          image: NetworkImage(snapshot.data['imageUrl']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              user.uid == widget.userId
                  ? TextButton.icon(
                      onPressed: () {
                        _configurandoModalBottomSheet(context);
                      },
                      icon: Icon(Icons.image, color: Colors.white),
                      label: Text(
                        'Alterar imagem',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
