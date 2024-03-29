import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class EditForm extends StatefulWidget {
  String initialValue;
  String valueKey;
  String campo;
  String troca;
  IconData icone;
  String colecao;
  TextInputType keyBoardType;
  Function validator;
  List<TextInputFormatter> list;
  dynamic valorId;

  EditForm({
    Key key,
    @required this.initialValue,
    @required this.valueKey,
    @required this.campo,
    @required this.troca,
    @required this.icone,
    @required this.colecao,
    this.keyBoardType,
    this.validator,
    this.list,
    this.valorId,
  }) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final User user = FirebaseAuth.instance.currentUser;

  String valor;

  _submit() {
    bool isValido = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValido) {
      FirebaseFirestore.instance
          .collection(widget.colecao)
          .doc(widget.colecao == 'users' ? user.uid : widget.valorId)
          .update({
        widget.troca: valor,
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
                  keyboardType: widget.keyBoardType,
                  enableSuggestions: false,
                  key: ValueKey(widget.valueKey),
                  decoration: InputDecoration(
                    labelText: widget.campo,
                    prefixIcon: Icon(
                      widget.icone,
                    ),
                  ),
                  initialValue: widget.initialValue,
                  onChanged: (value) => valor = value,
                  validator: (value) => widget.validator(value),
                  inputFormatters: widget.list,
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
