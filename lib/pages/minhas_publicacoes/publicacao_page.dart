import 'package:flutter/material.dart';

import 'components/publicacao_body.dart';

class PublicacaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Minhas Publicações',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: PublicacaoBody(),
    );
  }
}
