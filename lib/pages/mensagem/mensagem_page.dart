import 'package:flutter/material.dart';

import 'components/mensagem_body.dart';

class MensagemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MensagemBody(),
    );
  }
}
