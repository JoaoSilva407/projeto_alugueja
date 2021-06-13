import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class DetalhesPublicacaoBody extends StatelessWidget {
  final dynamic valorId;
  final user = FirebaseAuth.instance.currentUser;

  DetalhesPublicacaoBody({
    Key key,
    this.valorId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('publicacao')
            .doc(valorId)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    child: Icon(
                      Icons.home,
                      color: primeiraCor,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Titulo',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          snapshot.data['titulo'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              user.uid != snapshot.data['userId']
                  ? TextButton.icon(
                      icon: Icon(
                        Icons.message,
                        color: Colors.green,
                      ),
                      label: Text(
                        'Enviar mensagem',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('conversa')
                            .add({
                          'userIdUm': user.uid,
                          'userIdDois': snapshot.data['userId'],
                          'createdAt': Timestamp.now(),
                        });
                      },
                    )
                  : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
