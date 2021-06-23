import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/favoritos_body.dart';

class FavoritosPage extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meus Favoritos",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('favoritos').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final feedDocs = snapshot.data.docs;
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: feedDocs.length,
              itemBuilder: (ctx, index) {
                return user.uid == feedDocs[index]['userId']
                    ? FovoritosBody(
                        valorId: feedDocs[index]['idPublicacao'],
                        docId: feedDocs[index].id,
                      )
                    : SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}
