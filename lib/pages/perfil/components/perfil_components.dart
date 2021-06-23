import 'package:flutter/material.dart';

import '../../../constants.dart';

class PerfilComponents extends StatelessWidget {
  final String nome;
  final String variavel;
  final IconData iconUm;
  final Function onPressed;

  const PerfilComponents({
    Key key,
    @required this.nome,
    @required this.variavel,
    @required this.iconUm,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        SizedBox(
          child: Icon(
            iconUm,
            color: primeiraCor,
            size: 30,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nome,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                variavel,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.orange,
          ),
          onPressed: onPressed,
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
