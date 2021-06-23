import 'package:alugueja/pages/mensagem/mensagem_page_two.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'detalhes_publicacao_body.dart';

class DetalhesPublicacaoPage extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;
  final dynamic valorId;
  final dynamic userId;
  final dynamic docId;

  DetalhesPublicacaoPage({
    Key key,
    this.valorId,
    this.userId,
    this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes da publicação',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: user.uid == userId
            ? <Widget>[
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
                              Text('Excluir publicação'),
                            ],
                          ),
                        ),
                      )
                    ],
                    onChanged: (item) async {
                      if (item == 'excluir') {
                        Navigator.pop(context);
                        var collection =
                            FirebaseFirestore.instance.collection('favoritos');
                        var snapshot = await collection
                            .where('idPublicacao', isEqualTo: valorId)
                            .get();

                        for (var doc in snapshot.docs) {
                          await doc.reference.delete();
                        }
                      }
                      FirebaseFirestore.instance
                          .collection('publicacao')
                          .doc(valorId)
                          .delete();
                    },
                  ),
                ),
              ]
            : [],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('conversa').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          Future<void> _submit(dynamic valorId) async {
            var listDocs = snapshot.data.docs;
            try {
              if (listDocs.length == 0) {
                FirebaseFirestore.instance.collection('conversa').add({
                  'userIdUm': user.uid,
                  'userIdDois': valorId,
                  'createdAt': Timestamp.now(),
                });
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MensagemPageTwo()),
                );
              } else {
                for (int i = 0; i <= listDocs.length; i++) {
                  if (listDocs[i]['userIdUm'] == user.uid &&
                      listDocs[i]['userIdDois'] == valorId) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MensagemPageTwo()),
                    );
                    break;
                  } else if (listDocs[i]['userIdUm'] == valorId &&
                      listDocs[i]['userIdDois'] == user.uid) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MensagemPageTwo()),
                    );
                    break;
                  } else if (i == listDocs.length - 1) {
                    FirebaseFirestore.instance.collection('conversa').add({
                      'userIdUm': user.uid,
                      'userIdDois': valorId,
                      'createdAt': Timestamp.now(),
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MensagemPageTwo()),
                    );
                    break;
                  }
                }
              }
            } on PlatformException catch (erro) {
              print(erro);
            } catch (erro) {
              print(erro);
            }
          }

          return DetalhesPublicacaoBody(
            onSubmit: _submit,
            valorId: valorId,
          );
        },
      ),
    );
  }
}
