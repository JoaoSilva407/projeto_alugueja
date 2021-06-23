import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class Notificacao extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notificacao')
            .where('userId', isEqualTo: user.uid)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          final feedDocs = snapshot.data.docs;
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: feedDocs.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        SizedBox(
                            child: Icon(
                          Icons.notification_important,
                          color: Colors.yellow,
                          size: 50,
                        )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sua publicação: ' +
                                  feedDocs[index]['titulo'] +
                                  ' teve uma visualização',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Data: ' +
                                  DateFormat('d MMM y').format(
                                      feedDocs[index]['createdAt'].toDate()),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
