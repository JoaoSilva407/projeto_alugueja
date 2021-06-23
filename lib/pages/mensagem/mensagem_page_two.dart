import 'package:flutter/material.dart';

import 'components/mensagem_components.dart';

class MensagemPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Minhas mensagens',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: MensagemComponents(),
    );
  }
}
