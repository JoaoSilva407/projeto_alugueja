import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FotoPerfil extends StatelessWidget {
  final dynamic userId;

  const FotoPerfil({
    Key key,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return Row(
          children: [
            snapshot.data['imageUrl'] != ''
                ? CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(snapshot.data['imageUrl']),
                  )
                : CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
            SizedBox(
              width: 10,
            ),
            Text(
              snapshot.data['name'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        );
      },
    );
  }
}
