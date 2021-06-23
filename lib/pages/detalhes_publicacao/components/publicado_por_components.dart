import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PublicadoPorComponents extends StatelessWidget {
  dynamic valorId;
  dynamic dataPublicacao;

  PublicadoPorComponents({
    this.valorId,
    this.dataPublicacao,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(valorId)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Publicado por:',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                snapshot.data['imageUrl'] != ''
                    ? CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            NetworkImage(snapshot.data['imageUrl']),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data['name'] + ' ' + snapshot.data['sobrenome'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Data: ' +
                          DateFormat('d MMM y').format(dataPublicacao.toDate()),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
