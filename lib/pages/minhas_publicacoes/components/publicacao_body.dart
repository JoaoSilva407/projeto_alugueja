import 'package:alugueja/pages/detalhes_publicacao/components/detalhes_publicacao_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class PublicacaoBody extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('publicacao')
          .where("userId", isEqualTo: user.uid)
          .snapshots(),
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
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      color: primeiraCor,
                    ),
                    ListTile(
                      title: Text(
                        feedDocs[index]['titulo'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Data da publicação: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat('d MMM y').format(
                                    feedDocs[index]['createdAt'].toDate()),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Valor do Aluguel: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                feedDocs[index]['valor'],
                              ),
                            ],
                          ),
                          TextButton(
                            child: Text(
                              '+ detalhes',
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalhesPublicacaoBody(
                                    valorId: feedDocs[index].id,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
