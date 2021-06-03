import 'package:flutter/material.dart';

import 'components/perfil_body.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        elevation: 1,
      ),
      body: PerfilBody(),
    );
  }
}
