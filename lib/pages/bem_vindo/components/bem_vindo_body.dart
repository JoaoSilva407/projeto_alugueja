import 'package:alugueja/components/rounded_button.dart';
import 'package:alugueja/constants.dart';
import 'package:alugueja/pages/bem_vindo/components/bem_vindo_background.dart';
import 'package:alugueja/pages/cadastro/cadastro_page.dart';
import 'package:alugueja/pages/login/auth_page.dart';
import 'package:flutter/material.dart';

class BemVindoBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BemVindoBackground(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 130,
                  height: 130,
                  child: Image.asset('assets/Logo.png'),
                ),
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
          ),
          Text(
            'Bem Vindo',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: segundaCor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            child: Image.asset('assets/image_inicial.png'),
          ),
          SizedBox(
            height: 15,
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
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ou',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            width: size.width / 1.1,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black45),
                  borderRadius: BorderRadius.circular(29),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/logo_google.jpg',
                      height: 25,
                      width: 25,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Entrar com o Google',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
