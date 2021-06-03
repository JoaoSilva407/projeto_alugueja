import 'package:alugueja/components/rounded_button.dart';
import 'package:alugueja/models/comercio_model.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              key: ValueKey('titulo'),
              decoration: InputDecoration(
                labelText: 'Nome da publicação',
              ),
              onChanged: (value) => _comercioModel.titulo = value,
              validator: (value) {
                if (value == null || value.trim().length < 4) {
                  return 'Nome deve ter no mínimo 4 caracteres.';
                }
                return null;
              },
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              key: ValueKey('descricao'),
              decoration: InputDecoration(
                labelText: 'Descrição do ponto comercial',
              ),
              onChanged: (value) => _comercioModel.descricao = value,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              key: ValueKey('rua'),
              decoration: InputDecoration(
                labelText: 'Endereço',
              ),
              onChanged: (value) => _comercioModel.endereco = value,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.characters,
              enableSuggestions: false,
              key: ValueKey('cep'),
              decoration: InputDecoration(
                labelText: 'CEP',
              ),
              onChanged: (value) => _comercioModel.cep = value,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              key: ValueKey('cidade'),
              decoration: InputDecoration(
                labelText: 'Cidade',
              ),
              onChanged: (value) => _comercioModel.cidade = value,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              enableSuggestions: false,
              key: ValueKey('estado'),
              decoration: InputDecoration(
                labelText: 'Estado',
              ),
              onChanged: (value) => _comercioModel.estado = value,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.characters,
              enableSuggestions: false,
              key: ValueKey('valor'),
              decoration: InputDecoration(
                labelText: 'Valor do aluguel',
              ),
              onChanged: (value) => _comercioModel.valor = value,
            ),
            RoundedButton(
              texto: 'Publicar',
              funcao: _submit,
              buttonColor: primeiraCor,
              textColor: Colors.white,
              borderColor: primeiraCor,
            ),
          ],
        ),
      ),
    );
  }
}
