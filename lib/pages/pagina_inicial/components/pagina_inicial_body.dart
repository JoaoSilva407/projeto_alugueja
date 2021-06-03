import '../../../constants.dart';
import '../components/pagina_inicial_background.dart';
import 'package:flutter/material.dart';

class PaginaInicialBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginaInicialBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'EM CONSTRUÇÃO',
            style: TextStyle(
              color: primeiraCor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
