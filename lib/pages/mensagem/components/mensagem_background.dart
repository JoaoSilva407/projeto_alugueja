import 'package:alugueja/constants.dart';
import 'package:flutter/material.dart';

class MensagemBackground extends StatelessWidget {
  final Widget child;

  const MensagemBackground({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: quintaCor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
        ],
      ),
    );
  }
}
