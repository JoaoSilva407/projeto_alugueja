import 'package:alugueja/components/edit_form.dart';
import 'package:alugueja/components/image_user.dart';
import 'package:alugueja/pages/perfil/components/perfil_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'perfil_components.dart';

class PerfilBody extends StatefulWidget {
  @override
  _PerfilBodyState createState() => _PerfilBodyState();
}

class _PerfilBodyState extends State<PerfilBody> {
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

        return PerfilBackground(
          child: Column(
            children: [
              ImageUser(),
              SizedBox(
                height: 20,
              ),
              PerfilComponents(
                iconUm: Icons.person,
                nome: 'Nome',
                variavel: snapshot.data['name'],
              ),
              SizedBox(
                height: 15,
              ),
              PerfilComponents(
                iconUm: Icons.person,
                nome: 'Sobrenome',
                variavel: snapshot.data['sobrenome'],
              ),
              SizedBox(
                height: 15,
              ),
              PerfilComponents(
                iconUm: Icons.phone,
                nome: 'Telefone',
                variavel: snapshot.data['telefone'],
              ),
              SizedBox(
                height: 15,
              ),
              PerfilComponents(
                iconUm: Icons.calendar_today,
                nome: 'Data de Nascimento',
                variavel: snapshot.data['birthdate'],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange,
                  ),
                ),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.orange,
                  ),
                  label: Text(
                    'Editar',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return EditForm();
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
