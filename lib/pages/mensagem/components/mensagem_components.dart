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
        if (snapshot.data == null) {
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
                  Column(
                    children: [
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MensagemBody(
                                      userIdUm: menDocs[index]['userIdUm'],
                                      userIdDois: menDocs[index]['userIdDois'],
                                      docId: menDocs[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: CardConversa(
                                createdeAt: menDocs[index]['createdAt'],
                                userId: user.uid == menDocs[index]['userIdUm']
                                    ? menDocs[index]['userIdDois']
                                    : menDocs[index]['userIdUm'],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(color: Colors.grey),
                      ),
                    ],
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
