import 'package:flutter/material.dart';

import '../../../constants.dart';

class BemVindoBackground extends StatelessWidget {
  final Widget child;

  const BemVindoBackground({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Bem vindo',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: primeiraCor,
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
