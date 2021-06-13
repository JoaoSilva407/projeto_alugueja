import 'package:alugueja/pages/mensagem/components/new_messages.dart';
import 'package:flutter/material.dart';

import 'messages.dart';

class MensagemBody extends StatelessWidget {
  final dynamic userIdUm;
  final dynamic userIdDois;

  const MensagemBody({
    Key key,
    this.userIdUm,
    this.userIdDois,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(
                userIdDois: userIdDois,
                userIdUm: userIdUm,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            NewMessage(userIdDois: userIdDois, userIdUm: userIdUm),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
