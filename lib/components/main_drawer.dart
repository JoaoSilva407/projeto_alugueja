import 'package:alugueja/pages/bem_vindo/bem_vindo_page.dart';
import 'package:alugueja/pages/mensagem/mensagem_page_two.dart';
import 'package:alugueja/pages/minhas_publicacoes/publicacao_page.dart';
import 'package:alugueja/pages/perfil/perfil_page.dart';
import 'package:alugueja/pages/sobre/sobre_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/favoritos/favoritos_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data.exists) {
          return Center(child: CircularProgressIndicator());
        }

        return Drawer(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    snapshot.data['imageUrl'] != ''
                        ? CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                NetworkImage(snapshot.data['imageUrl']),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 100,
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data['name'],
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        snapshot.data['sobrenome'] != ''
                            ? Text(
                                snapshot.data['sobrenome'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                ),
                title: Text(
                  'Perfil',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PerfilPage(),
                    ),
                  );
                },
              ),
              Divider(
                height: 0,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.text_snippet,
                ),
                title: Text(
                  'Minhas publicações',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PublicacaoPage(),
                    ),
                  );
                },
              ),
              Divider(
                height: 0,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.message,
                ),
                title: Text(
                  'Minhas mensagens',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MensagemPageTwo(),
                    ),
                  );
                },
              ),
              Divider(
                height: 0,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.star,
                ),
                title: Text(
                  'Conferir depois',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritosPage(),
                    ),
                  );
                },
              ),
              Divider(
                height: 0,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                ),
                title: Text(
                  'Sobre o APP',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SobrePage(),
                    ),
                  );
                },
              ),
              Divider(
                height: 0,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                ),
                title: Text(
                  'Sair',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BemVindoPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
