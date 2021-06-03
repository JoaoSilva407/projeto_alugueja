import 'package:flutter/material.dart';

class CadastroBackground extends StatelessWidget {
  final Widget child;

  const CadastroBackground({
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
          child,
        ],
      ),
    );
  }
}
