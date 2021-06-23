import 'package:alugueja/components/dateForm.dart';
import 'package:alugueja/components/edit_form.dart';
import 'package:alugueja/components/image_user.dart';
import 'package:alugueja/components/validate_components.dart';
import 'package:alugueja/pages/perfil/components/perfil_background.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';
import 'perfil_components.dart';

class PerfilBody extends StatefulWidget {
  @override
  _PerfilBodyState createState() => _PerfilBodyState();
}

class _PerfilBodyState extends State<PerfilBody> {
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    final UsNumberTextInputFormatter _birthDate = UsNumberTextInputFormatter();

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return PerfilBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ImageUser(),
                SizedBox(
                  height: 20,
                ),
                PerfilComponents(
                  iconUm: Icons.person,
                  nome: 'Nome',
                  variavel: snapshot.data['name'],
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return EditForm(
                        icone: Icons.person,
                        initialValue: snapshot.data['name'],
                        campo: 'Nome',
                        troca: 'name',
                        valueKey: 'name',
                        colecao: 'users',
                        validator: ValidateComponents.validarNome,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Divider(
                    color: primeiraCor,
                  ),
                ),
                PerfilComponents(
                  iconUm: Icons.person,
                  nome: 'Sobrenome',
                  variavel: snapshot.data['sobrenome'],
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return EditForm(
                        icone: Icons.person,
                        initialValue: snapshot.data['sobrenome'],
                        campo: 'Sobrenome',
                        troca: 'sobrenome',
                        valueKey: 'sobrenome',
                        colecao: 'users',
                        validator: ValidateComponents.validarSobrenome,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Divider(
                    color: primeiraCor,
                  ),
                ),
                PerfilComponents(
                  iconUm: Icons.phone,
                  nome: 'Telefone',
                  variavel: snapshot.data['telefone'],
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return EditForm(
                        icone: Icons.phone,
                        initialValue: snapshot.data['telefone'],
                        campo: 'Telefone',
                        troca: 'telefone',
                        valueKey: 'telefone',
                        colecao: 'users',
                        validator: ValidateComponents.validarCelular,
                        keyBoardType: TextInputType.datetime,
                        list: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Divider(
                    color: primeiraCor,
                  ),
                ),
                PerfilComponents(
                  iconUm: Icons.calendar_today,
                  nome: 'Data de Nascimento',
                  variavel: snapshot.data['birthdate'],
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return EditForm(
                        icone: Icons.calendar_today,
                        initialValue: snapshot.data['birthdate'],
                        campo: 'Data de Aniversário',
                        troca: 'birthdate',
                        valueKey: 'birthdate',
                        colecao: 'users',
                        validator: ValidateComponents.validarData,
                        keyBoardType: TextInputType.datetime,
                        list: [
                          FilteringTextInputFormatter.digitsOnly,
                          _birthDate,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
