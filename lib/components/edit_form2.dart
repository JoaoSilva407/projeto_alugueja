import 'package:alugueja/components/validate_components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class EditForm2 extends StatefulWidget {
  String initialValue;
  String initialValue2;
  dynamic valorId;

  EditForm2({
    Key key,
    @required this.initialValue,
    @required this.initialValue2,
    this.valorId,
  }) : super(key: key);

  @override
  _EditForm2State createState() => _EditForm2State();
}

class _EditForm2State extends State<EditForm2> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final User user = FirebaseAuth.instance.currentUser;

  String valor;
  String valor2;

  _submit() {
    bool isValido = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValido) {
      FirebaseFirestore.instance
          .collection('publicacao')
          .doc(widget.valorId)
          .update({
        'endereco': valor,
        'numero': valor2,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  enableSuggestions: false,
                  key: ValueKey('endereco'),
                  decoration: InputDecoration(
                    labelText: 'Endereço',
                    prefixIcon: Icon(
                      Icons.streetview,
                    ),
                  ),
                  initialValue: widget.initialValue,
                  onChanged: (value) => valor = value,
                  validator: (value) =>
                      ValidateComponents.validarEndereco(value),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  enableSuggestions: false,
                  key: ValueKey('numero'),
                  decoration: InputDecoration(
                    labelText: 'Número',
                    prefixIcon: Icon(
                      Icons.streetview,
                    ),
                  ),
                  initialValue: widget.initialValue2,
                  onChanged: (value) => valor2 = value,
                  validator: (value) => ValidateComponents.validarNumero(value),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 25),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 25),
                      ),
                      onPressed: _submit,
                      child: Text(
                        'Confirmar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
