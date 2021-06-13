import 'package:alugueja/models/comercio_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/add_publicacao_body.dart';

class AddPublicacaoPage extends StatelessWidget {
  Future<void> _sendPublication(ComercioModel comercioModel) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      await FirebaseFirestore.instance.collection('publicacao').add({
        'titulo': comercioModel.titulo,
        'descricao': comercioModel.descricao,
        'endereco': comercioModel.endereco,
        'cep': comercioModel.cep,
        'cidade': comercioModel.cidade,
        'estado': comercioModel.estado,
        'valor': comercioModel.valor,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
      });
    } on PlatformException catch (erro) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddPublicacaoBody(onSubmit: _sendPublication),
    );
  }
}
