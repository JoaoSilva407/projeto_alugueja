import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class DetalhesComponents extends StatefulWidget {
  IconData icone;
  String titulo;
  String valorVariavel;
  Function onPressed;
  dynamic userId;

  DetalhesComponents({
    this.icone,
    this.titulo,
    this.valorVariavel,
    this.onPressed,
    this.userId,
  });

  @override
  _DetalhesComponentsState createState() => _DetalhesComponentsState();
}

class _DetalhesComponentsState extends State<DetalhesComponents> {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Icon(
            widget.icone,
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
                widget.titulo,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                widget.valorVariavel,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        user.uid == widget.userId
            ? IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.orange,
                ),
                onPressed: widget.onPressed,
              )
            : SizedBox(),
      ],
    );
  }
}
