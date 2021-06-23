import 'package:alugueja/pages/detalhes_publicacao/components/detalhes_publicacao_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class FovoritosBody extends StatelessWidget {
  final dynamic valorId;
  final dynamic docId;

  const FovoritosBody({Key key, this.valorId, this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('publicacao')
          .doc(valorId)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Column(
            children: [
              snapshot.data['imageUrl'] != ''
                  ? Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data['imageUrl']),
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
                            style: TextStyle(fontSize: 20, color: segundaCor),
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 5),
              ListTile(
                title: Text(
                  snapshot.data['titulo'],
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
                          DateFormat('d MMM y')
                              .format(snapshot.data['createdAt'].toDate()),
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
                          r'R$ ' + snapshot.data['valor'] + ',00',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: Text(
                            '+ detalhes',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetalhesPublicacaoPage(
                                  valorId: snapshot.data.id,
                                  userId: snapshot.data['userId'],
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('favoritos')
                                .doc(docId)
                                .delete();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
