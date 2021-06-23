import 'package:flutter/material.dart';

import 'components/pesquisar_body.dart';

class PesquisarPage extends StatefulWidget {
  @override
  _PesquisarPageState createState() => _PesquisarPageState();
}

class _PesquisarPageState extends State<PesquisarPage> {
  String nome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: double.infinity,
          height: 50,
          child: Expanded(
            child: TextFormField(
              onChanged: (value) => nome = value,
              decoration: InputDecoration(
                hintText: 'Pesquisar...',
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                filled: true,
                fillColor: Colors.white38,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                nome = nome;
              });
            },
          ),
        ],
      ),
      body: PesquisarBody(
        valor: nome,
      ),
    );
  }
}
