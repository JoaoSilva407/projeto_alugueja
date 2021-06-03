import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String texto;
  final Function funcao;
  final Color buttonColor, textColor, borderColor;

  const RoundedButton({
    Key key,
    @required this.texto,
    @required this.funcao,
    @required this.buttonColor,
    @required this.textColor,
    @required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: size.width / 1.1,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(29),
          ),
        ),
        onPressed: funcao,
        child: Text(
          texto,
          style: TextStyle(color: textColor, fontSize: 25),
        ),
      ),
    );
  }
}
