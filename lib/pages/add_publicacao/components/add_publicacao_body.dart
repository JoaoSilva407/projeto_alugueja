import 'dart:io';

import 'package:alugueja/components/imageComercio.dart';
import 'package:alugueja/components/rounded_button.dart';
import 'package:alugueja/components/validate_components.dart';
import 'package:alugueja/models/comercio_model.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';

class AddPublicacaoBody extends StatefulWidget {
  final void Function(ComercioModel comercioModel) onSubmit;

  const AddPublicacaoBody({
    @required this.onSubmit,
  });

  @override
  _AddPublicacaoBodyState createState() => _AddPublicacaoBodyState();
}

class _AddPublicacaoBodyState extends State<AddPublicacaoBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ComercioModel _comercioModel = ComercioModel();

  _submit() {
    bool isValido = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValido) {
      widget.onSubmit(_comercioModel);
    }
  }

  void _handlePickedImage(File image) {
    _comercioModel.image = image;
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      _comercioModel.estado = novoItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ImageComercio(_handlePickedImage),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                enableSuggestions: false,
                key: ValueKey('titulo'),
                decoration: InputDecoration(
                  labelText: 'Nome da publicação',
                ),
                onChanged: (value) => _comercioModel.titulo = value,
                validator: (value) => ValidateComponents.validarTitulo(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                enableSuggestions: false,
                key: ValueKey('descricao'),
                decoration: InputDecoration(
                  labelText: 'Descrição do ponto comercial',
                ),
                onChanged: (value) => _comercioModel.descricao = value,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                enableSuggestions: false,
                key: ValueKey('endereco'),
                decoration: InputDecoration(
                  labelText: 'Endereço',
                ),
                onChanged: (value) => _comercioModel.endereco = value,
                validator: (value) => ValidateComponents.validarEndereco(value),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                enableSuggestions: false,
                key: ValueKey('numero'),
                decoration: InputDecoration(
                  labelText: 'Número',
                ),
                onChanged: (value) => _comercioModel.numero = value,
                validator: (value) => ValidateComponents.validarNumero(value),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                enableSuggestions: false,
                key: ValueKey('cep'),
                decoration: InputDecoration(
                  labelText: 'CEP',
                ),
                onChanged: (value) => _comercioModel.cep = value,
                validator: (value) => ValidateComponents.validarCep(value),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      key: ValueKey('cidade'),
                      decoration: InputDecoration(
                        labelText: 'Cidade',
                      ),
                      onChanged: (value) => _comercioModel.cidade = value,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 15),
                      DropdownButton<String>(
                        hint: Text('Estado'),
                        value: _comercioModel.estado,
                        onChanged: (value) {
                          _dropDownItemSelected(value);
                          setState(() {
                            _comercioModel.estado = value;
                          });
                        },
                        items: Estados.listaEstados.map((String estado) {
                          return DropdownMenuItem(
                            value: estado,
                            child: Text(estado),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                enableSuggestions: false,
                key: ValueKey('valor'),
                decoration: InputDecoration(
                  labelText: 'Valor do aluguel',
                ),
                onChanged: (value) => _comercioModel.valor = value,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  RealInputFormatter()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: RoundedButton(
                texto: 'Publicar',
                funcao: _submit,
                buttonColor: primeiraCor,
                textColor: Colors.white,
                borderColor: primeiraCor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
