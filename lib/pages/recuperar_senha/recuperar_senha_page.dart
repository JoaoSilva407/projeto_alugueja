import 'package:alugueja/components/rounded_button.dart';
import 'package:alugueja/components/validate_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

class RecuperarSenha extends StatefulWidget {
  @override
  _RecuperarSenhaState createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _email;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  void showSnack(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      backgroundColor: Theme.of(context).errorColor,
    );
    _scaffoldMessengerKey.currentState.showSnackBar(snackbar);
  }

  Future sendPassWordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  _submit() {
    try {
      bool isValido = _formKey.currentState.validate();
      FocusScope.of(context).unfocus();
      if (isValido) {
        sendPassWordResetEmail(_email);
        Navigator.of(context).pop();
      }
    } on PlatformException catch (erro) {
      final msg =
          erro.message ?? 'Ocorreu um erro! Verifique suas credenciais!';
      showSnack(msg);
    } on FirebaseAuthException catch (erro) {
      final msg =
          erro.message ?? 'Ocorreu um erro! Verifique suas credenciais!';
      showSnack(msg);
    } catch (erro) {
      print(erro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: primeiraCor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Icon(
                        Icons.lock_open,
                        size: 150,
                        color: primeiraCor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Esqueceu sua senha? ',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        'Por favor, informe o E-mail associado a sua conta que enviaremos um link para o mesmo com as instruções para restauração de sua senha.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: TextFormField(
                        validator: (value) =>
                            ValidateComponents.validarEmail(value),
                        onChanged: (value) {
                          setState(() {
                            _email = value.trim();
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      borderColor: primeiraCor,
                      buttonColor: primeiraCor,
                      funcao: _submit,
                      textColor: Colors.white,
                      texto: 'Enviar',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
