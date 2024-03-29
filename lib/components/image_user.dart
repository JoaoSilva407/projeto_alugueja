import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';

class ImageUser extends StatefulWidget {
  @override
  _ImageUserState createState() => _ImageUserState();
}

class _ImageUserState extends State<ImageUser> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size.height;
    final User user = FirebaseAuth.instance.currentUser;
    File _pickedImageFile;

    Future _pickImage(bool camera) async {
      final picker = ImagePicker();
      final pickedImage = camera
          ? await picker.getImage(
              source: ImageSource.camera,
            )
          : await picker.getImage(
              source: ImageSource.gallery,
            );

      _pickedImageFile = File(pickedImage.path);

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(user.uid + '.jpg');

      await ref.putFile(_pickedImageFile);
      final url = await ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'imageUrl': url});
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
                      _pickImage(true);
                    },
                  ),
                  ListTile(
                    leading: new Icon(
                      Icons.add_photo_alternate,
                      color: Colors.indigo,
                    ),
                    title: new Text('Galeria'),
                    onTap: () {
                      _pickImage(false);
                    },
                  ),
                  ListTile(
                    leading: new Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    title: new Text('Remover foto'),
                    onTap: () => {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .update({'imageUrl': ''}),
                    },
                  ),
                ],
              ),
            );
          });
    }

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return Container(
          height: media / 3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: primeiraCor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(3.0, 3.0), //(x,y)
                blurRadius: 10.0,
              ),
            ],
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              snapshot.data['imageUrl'] != ''
                  ? CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(snapshot.data['imageUrl']),
                    )
                  : CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
              TextButton.icon(
                onPressed: () {
                  _configurandoModalBottomSheet(context);
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                label: Text(
                  'Alterar imagem',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
