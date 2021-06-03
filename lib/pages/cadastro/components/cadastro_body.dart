import 'dart:io';

import 'package:alugueja/components/rounded_button.dart';
import 'package:alugueja/components/user_image_picker.dart';
import 'package:alugueja/models/user_model.dart';
import 'package:alugueja/pages/cadastro/components/cadastro_background.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

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
  final _dateController = MaskedTextController(mask: '00/00/0000');
  final _phoneController = MaskedTextController(mask: '(00) 00000-0000');
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
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              UserImagePicker(_handlePickedImage),
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
                validator: (value) {
                  if (value == null || value.trim().length < 4) {
                    return 'Nome deve ter no mínimo 4 caracteres.';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.trim().length < 4) {
                    return 'Nome deve ter no mínimo 4 caracteres.';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Forneça email válido.';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.trim().length < 4) {
                    return 'Minimo para senha: 4 Caracteres.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _phoneController,
                autocorrect: true,
                textCapitalization: TextCapitalization.words,
                enableSuggestions: false,
                key: ValueKey('telefone'),
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  prefixIcon: Icon(
                    Icons.phone,
                  ),
                ),
                onChanged: (value) => _userModel.telefone = value,
                validator: (value) {
                  if (value == null || value.trim().length < 4) {
                    return 'Nome deve ter no mínimo 4 caracteres.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _dateController,
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
      ),
    );
  }
}
