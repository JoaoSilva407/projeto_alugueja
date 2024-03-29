import 'package:alugueja/pages/mensagem/components/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final dynamic userIdUm;
  final dynamic userIdDois;

  const Messages({
    Key key,
    this.userIdUm,
    this.userIdDois,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final chatDocs = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, i) => chatDocs[i]['userIdUm'] == userIdUm &&
                  chatDocs[i]['userIdDois'] == userIdDois
              ? MessageBubble(
                  chatDocs[i]['text'],
                  chatDocs[i]['userName'],
                  chatDocs[i]['userId'] == user.uid,
                  chatDocs[i]['imageUrl'],

                  //key: ValueKey(chatDocs[i].hashCode),
                )
              : SizedBox(),
        );
      },
    );
  }
}
