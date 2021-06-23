import 'package:alugueja/components/rounded_button.dart';
import 'package:alugueja/constants.dart';
import 'package:alugueja/pages/login/auth_page.dart';
import 'package:alugueja/pages/pagina_inicial/pagina_inicial_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bem_vindo_background.dart';

class BemVindoBody extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BemVindoBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset('assets/logo_app.png'),
          ),
          SizedBox(
            height: 60,
          ),
          RoundedButton(
            texto: 'Entrar',
            funcao: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AuthPage();
                  },
                ),
              );
            },
            buttonColor: primeiraCor,
            textColor: quintaCor,
            borderColor: primeiraCor,
          ),
        ],
      ),
    );
  }
}
