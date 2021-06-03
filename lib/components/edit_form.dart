import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final User user = FirebaseAuth.instance.currentUser;

  String name;

  String sobrenome;

  String telefone;

  String birthdate;

  void _onPressed() {
    FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      'name': name,
      'sobrenome': sobrenome,
      'telefone': telefone,
      'birthdate': birthdate,
    }).then((_) {
      print("success!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) return Text('Loading Data.. Please Wait...');
        return SingleChildScrollView(
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    key: ValueKey('name'),
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                    ),
                    initialValue: snapshot.data['name'],
                    onChanged: (value) => name = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    key: ValueKey('sobrenome'),
                    decoration: InputDecoration(
                      labelText: 'Sobrenome',
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                    ),
                    initialValue: snapshot.data['sobrenome'],
                    onChanged: (value) => sobrenome = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    key: ValueKey('telefone'),
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                    ),
                    initialValue: snapshot.data['telefone'],
                    onChanged: (value) => telefone = value,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    key: ValueKey('birthdate'),
                    decoration: InputDecoration(
                      labelText: 'Data de aniversário',
                      prefixIcon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                    initialValue: snapshot.data['birthdate'],
                    onChanged: (value) => birthdate = value,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                        ),
                        onPressed: () => _onPressed,
                        child: Text(
                          'Confirmar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
