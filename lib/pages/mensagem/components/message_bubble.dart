import 'package:alugueja/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final String userName;
  final String message;
  final bool belongsToMe;

  MessageBubble(this.message, this.userName, this.belongsToMe, {this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: belongsToMe ? primeiraCor : Colors.black54,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft:
                  belongsToMe ? Radius.circular(12) : Radius.circular(0),
              bottomRight:
                  belongsToMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 250,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment:
                belongsToMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
