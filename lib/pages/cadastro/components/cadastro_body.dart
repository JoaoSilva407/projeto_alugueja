import 'dart:io';

import 'package:alugueja/components/dateForm.dart';
import 'package:alugueja/components/rounded_button.dart';
import 'package:alugueja/components/user_image_picker.dart';
import 'package:alugueja/components/validate_components.dart';
import 'package:alugueja/models/user_model.dart';
import 'package:alugueja/pages/cadastro/components/cadastro_background.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class CadastroBody extends StatefulWidget {
  final void Function(UserModel userModel) onSubmit;

  const CadastroBody({
    @required this.onSubmit,
  });

  @override
  _CadastroBodyState createState() => _CadastroBodyState();
}

class _CadastroBodyState extends State<CadastroBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final UserModel _userModel = UserModel();
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  bool _isHiddenPassword = true;

  final UsNumberTextInputFormatter _birthDate = UsNumberTextInputFormatter();

  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  _submit() {
    bool isValido = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValido) {
      widget.onSubmit(_userModel);
    }
  }

  void _handlePickedImage(File image) {
    _userModel.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return CadastroBackground(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              UserImagePicker(_handlePickedImage),
              SingleChildScrollView(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextFormField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      key: ValueKey('name'),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                      ),
                      onChanged: (value) => _userModel.name = value,
                      validator: (value) =>
                          ValidateComponents.validarNome(value),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      key: ValueKey('sobrenome'),
                      decoration: InputDecoration(
                        labelText: 'Sobrenome',
                        prefixIcon: Icon(
                          Icons.person,
                        ),
                      ),
                      onChanged: (value) => _userModel.sobrenome = value,
                      validator: (value) =>
                          ValidateComponents.validarSobrenome(value),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
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
                      validator: (value) =>
                          ValidateComponents.validarEmail(value),
                    ),
                    SizedBox(
                      height: 20,
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
                      validator: (value) =>
                          ValidateComponents.validarSenha(value),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      keyboardType: TextInputType.datetime,
                      enableSuggestions: false,
                      key: ValueKey('telefone'),
                      decoration: InputDecoration(
                        labelText: 'Telefone',
                        prefixIcon: Icon(
                          Icons.phone,
                        ),
                      ),
                      onChanged: (value) => _userModel.telefone = value,
                      validator: (value) =>
                          ValidateComponents.validarCelular(value),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        _birthDate,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) =>
                          ValidateComponents.validarData(value),
                      keyboardType: TextInputType.datetime,
                      key: ValueKey('birthDate'),
                      decoration: InputDecoration(
                        labelText: 'Data de nascimento',
                        prefixIcon: Icon(
                          Icons.calendar_today,
                        ),
                      ),
                      onChanged: (value) => _userModel.birthDate = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      texto: 'Concluir Cadastro',
                      funcao: _submit,
                      buttonColor: primeiraCor,
                      textColor: Colors.white,
                      borderColor: primeiraCor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
