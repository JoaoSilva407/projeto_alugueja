import 'package:alugueja/pages/mensagem/components/new_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'foto_perfil.dart';
import 'messages.dart';

class MensagemBody extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;
  final dynamic userIdUm;
  final dynamic userIdDois;
  final dynamic docId;

  MensagemBody({
    Key key,
    this.userIdUm,
    this.userIdDois,
    this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FotoPerfil(
          userId: user.uid == userIdUm ? userIdDois : userIdUm,
        ),
        actions: <Widget>[
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  value: 'excluir',
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Excluir conversa'),
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (item) async {
                if (item == 'excluir') {
                  Navigator.pop(context);
                  var collection =
                      FirebaseFirestore.instance.collection('chat');
                  var snapshot =
                      await collection.where('docId', isEqualTo: docId).get();

                  for (var doc in snapshot.docs) {
                    await doc.reference.delete();
                  }
                  FirebaseFirestore.instance
                      .collection('conversa')
                      .doc(docId)
                      .delete();
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(
                userIdDois: userIdDois,
                userIdUm: userIdUm,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            NewMessage(
              userIdDois: userIdDois,
              userIdUm: userIdUm,
              docId: docId,
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
