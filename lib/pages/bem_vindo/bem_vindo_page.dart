import 'package:alugueja/pages/bem_vindo/components/bem_vindo_body.dart';
import 'package:alugueja/pages/cadastro/cadastro_page.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class BemVindoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroPage(),
                ),
              );
            },
            child: Text(
              'Cadastrar-se',
              style: TextStyle(
                fontSize: 20,
                color: primeiraCor,
              ),
            ),
          ),
        ],
      ),
      body: BemVindoBody(),
    );
  }
}
