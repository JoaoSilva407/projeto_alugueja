import 'package:alugueja/models/comercio_model.dart';
import 'package:alugueja/pages/pagina_inicial/pagina_inicial_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/add_publicacao_body.dart';

class AddPublicacaoPage extends StatefulWidget {
  @override
  _AddPublicacaoPageState createState() => _AddPublicacaoPageState();
}

class _AddPublicacaoPageState extends State<AddPublicacaoPage> {
  Future<void> _sendPublication(ComercioModel comercioModel) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      if (comercioModel.image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('comercio_images')
            .child(user.uid + '.jpg');

        await ref.putFile(comercioModel.image);
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('publicacao').add({
          'titulo': comercioModel.titulo,
          'descricao':
              comercioModel.descricao.isEmpty ? '' : comercioModel.descricao,
          'endereco': comercioModel.endereco,
          'numero': comercioModel.numero,
          'cep': comercioModel.cep,
          'cidade': comercioModel.cidade,
          'estado': comercioModel.estado,
          'valor': comercioModel.valor,
          'createdAt': Timestamp.now(),
          'userId': user.uid,
          'imageUrl': url,
        });
      } else {
        await FirebaseFirestore.instance.collection('publicacao').add({
          'titulo': comercioModel.titulo,
          'descricao':
              comercioModel.descricao.isEmpty ? '' : comercioModel.descricao,
          'endereco': comercioModel.endereco,
          'numero': comercioModel.numero,
          'cep': comercioModel.cep,
          'cidade': comercioModel.cidade,
          'estado': comercioModel.estado,
          'valor': comercioModel.valor,
          'createdAt': Timestamp.now(),
          'userId': user.uid,
          'imageUrl': '',
        });
      }
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PaginaInicialPage()),
          (Route<dynamic> route) => false);
    } on PlatformException catch (erro) {
      print(erro);
    } catch (erro) {
      print(erro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddPublicacaoBody(onSubmit: _sendPublication),
    );
  }
}
