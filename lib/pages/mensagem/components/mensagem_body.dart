import 'package:alugueja/pages/mensagem/components/new_messages.dart';
import 'package:flutter/material.dart';

import 'mensagem_background.dart';
import 'messages.dart';

class MensagemBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MensagemBackground(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            SizedBox(
              height: 5,
            ),
            NewMessage(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
