import 'package:alugueja/models/user_model.dart';
import 'package:alugueja/pages/login/components/auth_body.dart';
import 'package:alugueja/pages/pagina_inicial/pagina_inicial_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/auth_background.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _isLoading = false;

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

  Future<void> _recebeSubmit(UserModel userModel) async {
    setState(() {
      _isLoading = true;
    });

    UserCredential authResult;

    try {
      authResult = await auth.signInWithEmailAndPassword(
        email: userModel.email.trim(),
        password: userModel.password,
      );

      final User user = authResult.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final User currentUser = auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInEmail succeeded: $user');

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PaginaInicialPage()),
          (Route<dynamic> route) => false);
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        body: AuthBackground(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      AuthBody(
                        onSubmit: _recebeSubmit,
                      ),
                      if (_isLoading)
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
