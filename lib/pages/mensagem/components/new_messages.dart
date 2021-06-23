import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class NewMessage extends StatefulWidget {
  final dynamic userIdUm;
  final dynamic userIdDois;
  final dynamic docId;

  const NewMessage({
    Key key,
    this.userIdUm,
    this.userIdDois,
    this.docId,
  }) : super(key: key);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final User user = FirebaseAuth.instance.currentUser;
  final _controller = TextEditingController();
  String _enteredMessage = '';

  File _pickedImageFile;

  Future _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    final ref = FirebaseStorage.instance
        .ref()
        .child('images_chat')
        .child(user.uid + '.jpg');

    await ref.putFile(_pickedImageFile);
    final url = await ref.getDownloadURL();

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': '',
      'imageUrl': url,
      'createdAt': Timestamp.now(),
      'userIdUm': widget.userIdUm,
      'userIdDois': widget.userIdDois,
      'userId': user.uid,
      'userName': userData['name'],
      'docId': widget.docId,
    });
  }

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'imageUrl': '',
      'createdAt': Timestamp.now(),
      'userIdUm': widget.userIdUm,
      'userIdDois': widget.userIdDois,
      'userId': user.uid,
      'userName': userData['name'],
      'docId': widget.docId,
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: primeiraCor,
                    ),
                  ),
                  labelText: 'Enviar mensagem...',
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: _pickImage,
            icon: Icon(
              Icons.add_a_photo,
              size: 30,
              color: primeiraCor,
            ),
          ),
          SizedBox(
            height: 60,
            child: VerticalDivider(
              color: primeiraCor,
              width: 5,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 30,
              color: primeiraCor,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
