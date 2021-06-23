import 'package:alugueja/components/recuperar_senha_button.dart';
import 'package:alugueja/components/rounded_button.dart';
import 'package:alugueja/components/validate_components.dart';
import 'package:alugueja/models/user_model.dart';
import 'package:alugueja/pages/cadastro/cadastro_page.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class AuthBody extends StatefulWidget {
  final void Function(UserModel userModel) onSubmit;

  const AuthBody({
    @required this.onSubmit,
  });

  @override
  _AuthBodyState createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final UserModel _userModel = UserModel();
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  bool _isHiddenPassword = true;

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  _submit() {
    bool isValido = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValido) {
      _formKey.currentState.save();
      widget.onSubmit(_userModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Icon(
                  Icons.account_circle,
                  size: 150,
                  color: primeiraCor,
                ),
              ),
              Container(
                child: TextFormField(
                  controller: _emailIdController,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                  onChanged: (value) => _userModel.email = value,
                  validator: (value) => ValidateComponents.validarEmail(value),
                ),
              ),
              TextFormField(
                controller: _passwordController,
                key: ValueKey('password'),
                obscureText: _isHiddenPassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: InkWell(
                    onTap: _togglePasswordView,
                    child: _isHiddenPassword
                        ? Icon(
                            Icons.visibility_off,
                            color: Colors.black45,
                          )
                        : Icon(
                            Icons.visibility,
                            color: primeiraCor,
                          ),
                  ),
                ),
                onChanged: (value) => _userModel.password = value,
                validator: (value) => ValidateComponents.validarSenha(value),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RecuperarSenhaButton(),
              ),
              RoundedButton(
                texto: 'Entrar',
                funcao: _submit,
                buttonColor: primeiraCor,
                textColor: quintaCor,
                borderColor: primeiraCor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Text(
                'Possui Cadastro?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              RoundedButton(
                texto: 'Cadastrar-se',
                funcao: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastroPage(),
                    ),
                  );
                },
                buttonColor: quintaCor,
                textColor: primeiraCor,
                borderColor: primeiraCor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
