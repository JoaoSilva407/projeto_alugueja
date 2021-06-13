import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardConversa extends StatelessWidget {
  final dynamic createdeAt;
  final dynamic userId;

  const CardConversa({
    Key key,
    this.createdeAt,
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
                    radius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(snapshot.data['imageUrl']),
                  )
                : CircleAvatar(
                    radius: 30,
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
            Column(
              children: [
                Text(
                  snapshot.data['name'] + ' ' + snapshot.data['sobrenome'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  DateFormat('d MMM y').format(createdeAt.toDate()),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
