import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IconButtonFavorite extends StatelessWidget {
  final dynamic userId;
  final dynamic idPublicacao;

  const IconButtonFavorite({
    Key key,
    this.userId,
    this.idPublicacao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('favoritos')
          .where('userId' == userId && 'idPublicacao' == idPublicacao)
          .snapshots(),
      builder: (ctx, snapshot) {
        return IconButton(
          icon: Icon(
            Icons.star,
            size: 10,
            color: snapshot.data['userId'] == userId &&
                    snapshot.data['idPublicacao'] == idPublicacao
                ? Colors.yellow
                : Colors.grey,
          ),
          onPressed: () {
            snapshot.data['userId'] == userId &&
                    snapshot.data['idPublicacao'] == idPublicacao
                ? FirebaseFirestore.instance
                    .collection('favoritos')
                    .doc(snapshot.data.id)
                    .delete()
                : FirebaseFirestore.instance.collection('favoritos').add(
                    {
                      'userId': userId,
                      'idPublicacao': idPublicacao,
                    },
                  );
          },
        );
      },
    );
  }
}
