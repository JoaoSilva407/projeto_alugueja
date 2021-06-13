import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'card_conversa.dart';
import 'mensagem_body.dart';

class MensagemComponents extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('conversa')
          .orderBy(
            'createdAt',
          )
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final menDocs = snapshot.data.docs;
        return ListView.builder(
          itemCount: menDocs.length,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                if (user.uid == menDocs[index]['userIdUm'] ||
                    user.uid == menDocs[index]['userIdDois'])
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MensagemBody(
                            userIdUm: menDocs[index]['userIdUm'],
                            userIdDois: menDocs[index]['userIdDois'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 5,
                      ),
                      child: CardConversa(
                        createdeAt: menDocs[index]['createdAt'],
                        userId: user.uid == menDocs[index]['userIdUm']
                            ? menDocs[index]['userIdDois']
                            : menDocs[index]['userIdUm'],
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
