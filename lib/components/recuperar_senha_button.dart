import 'package:flutter/material.dart';

class RecuperarSenhaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextButton(
        child: Text(
          'Recuperar Senha',
          textAlign: TextAlign.center,
        ),
        onPressed: () {},
      ),
    );
  }
}
