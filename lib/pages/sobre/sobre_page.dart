import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sobre o APP',
          style: TextStyle(fontSize: 30,
            color: Colors.white,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset('assets/logo_app.png'),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              child: Text(
                'AlugueJá é uma aplicação mobile que oferece uma plataforma onde os usuários podem publicar seu ponto comercial para alocação, a fim de dar um destino a ele. Tendo como objetivo principal, ser um intermediário na negociação entre locador e locatário.',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
