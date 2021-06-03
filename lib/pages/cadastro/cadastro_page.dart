import 'package:alugueja/models/user_model.dart';
import 'package:alugueja/pages/cadastro/components/cadastro_body.dart';
import 'package:alugueja/pages/login/auth_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final auth = FirebaseAuth.instance;

  Future<void> _recebeSubmit(UserModel userModel) async {
    UserCredential authResult;

    try {
      authResult = await auth.createUserWithEmailAndPassword(
        email: userModel.email.trim(),
        password: userModel.password,
      );

      if (userModel.image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user.uid + '.jpg');

        await ref.putFile(userModel.image);
        final url = await ref.getDownloadURL();

        final userData = {
          'name': userModel.name,
          'sobrenome': userModel.sobrenome,
          'email': userModel.email,
          'telefone': userModel.telefone,
          'birthdate': userModel.birthDate,
          'imageUrl': url,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set(userData);
      } else {
        final userData = {
          'name': userModel.name,
          'sobrenome': userModel.sobrenome,
          'email': userModel.email,
          'telefone': userModel.telefone,
          'birthdate': userModel.birthDate,
          'imageUrl': '',
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set(userData);
      }
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AuthPage()),
          (Route<dynamic> route) => false);
    } on PlatformException catch (erro) {
      final msg =
          erro.message ?? 'Ocorreu um erro! Verifique suas credenciais!';
      _scaffoldMessengerKey.currentState.showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (erro) {
      print(erro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: primeiraCor,
        ),
      ),
      body: CadastroBody(onSubmit: _recebeSubmit),
    );
  }
}
