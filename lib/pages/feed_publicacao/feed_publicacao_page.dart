import 'package:alugueja/pages/detalhes_publicacao/components/detalhes_publicacao_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class FeedPublicacaoPage extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('publicacao')
          .orderBy(
            'createdAt',
            descending: true,
          )
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
                child: Column(
                  children: [
                    feedDocs[index]['imageUrl'] != ''
                        ? Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    NetworkImage(feedDocs[index]['imageUrl']),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  primeiraCor,
                                  quartaCor,
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.store, size: 100, color: segundaCor),
                                Text(
                                  'Adicione uma foto do seu negócio',
                                  style: TextStyle(
                                      fontSize: 20, color: segundaCor),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(height: 5),
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
                                r'R$ ' + feedDocs[index]['valor'] + ',00',
                              ),
                            ],
                          ),
                          TextButton(
                            child: Text(
                              '+ detalhes',
                            ),
                            onPressed: () {
                              if (user.uid != feedDocs[index]['userId'])
                                FirebaseFirestore.instance
                                    .collection('notificacao')
                                    .add({
                                  'userId': feedDocs[index]['userId'],
                                  'titulo': feedDocs[index]['titulo'],
                                  'createdAt': Timestamp.now(),
                                });
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetalhesPublicacaoPage(
                                    valorId: feedDocs[index].id,
                                    userId: feedDocs[index]['userId'],
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
