import 'dart:io';

import 'package:alugueja/components/alterar_image.dart';
import 'package:alugueja/components/edit_form.dart';
import 'package:alugueja/components/edit_form2.dart';
import 'package:alugueja/components/validate_components.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';
import 'detalhes_components.dart';
import 'publicado_por_components.dart';

class DetalhesPublicacaoBody extends StatefulWidget {
  final dynamic valorId;
  final void Function(dynamic value) onSubmit;

  DetalhesPublicacaoBody({
    Key key,
    this.valorId,
    this.onSubmit,
  }) : super(key: key);

  @override
  _DetalhesPublicacaoBodyState createState() => _DetalhesPublicacaoBodyState();
}

class _DetalhesPublicacaoBodyState extends State<DetalhesPublicacaoBody> {
  final user = FirebaseAuth.instance.currentUser;

  Future _pickImage(File image) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('comercio_images')
        .child(user.uid + '.jpg');

    await ref.putFile(image);
    final url = await ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection('publicacao')
        .doc(widget.valorId)
        .update({'imageUrl': url});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('publicacao')
          .doc(widget.valorId)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AlterarImagem(
                  _pickImage, widget.valorId, snapshot.data['userId']),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PublicadoPorComponents(
                      valorId: snapshot.data['userId'],
                      dataPublicacao: snapshot.data['createdAt'],
                    ),
                    user.uid != snapshot.data['userId']
                        ? IconButton(
                            icon: Icon(
                              Icons.star,
                              size: 40,
                              color: Colors.yellow,
                            ),
                            onPressed: () async {
                              var collection = FirebaseFirestore.instance
                                  .collection('favoritos');
                              var snapshot2 = await collection
                                  .where('userId', isEqualTo: user.uid)
                                  .get();

                              if (snapshot2.docs.length == 0) {
                                FirebaseFirestore.instance
                                    .collection('favoritos')
                                    .add(
                                  {
                                    'userId': user.uid,
                                    'idPublicacao': widget.valorId,
                                  },
                                );
                              } else {
                                for (var doc in snapshot2.docs) {
                                  if (doc['idPublicacao'] == widget.valorId) {
                                    await doc.reference.delete();
                                  } else {
                                    FirebaseFirestore.instance
                                        .collection('favoritos')
                                        .add(
                                      {
                                        'userId': user.uid,
                                        'idPublicacao': widget.valorId,
                                      },
                                    );

                                    break;
                                  }
                                }
                              }
                            })
                        : SizedBox(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Divider(
                  color: primeiraCor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: DetalhesComponents(
                  userId: snapshot.data['userId'],
                  icone: Icons.home,
                  titulo: 'Título',
                  valorVariavel: snapshot.data['titulo'],
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return EditForm(
                        icone: Icons.home,
                        initialValue: snapshot.data['titulo'],
                        campo: 'Título',
                        troca: 'titulo',
                        valueKey: 'titulo',
                        colecao: 'publicacao',
                        validator: ValidateComponents.validarTitulo,
                        valorId: widget.valorId,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primeiraCor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Descrição',
                              style: TextStyle(
                                fontSize: 20,
                                color: primeiraCor,
                              ),
                            ),
                            user.uid == snapshot.data['userId']
                                ? IconButton(
                                    onPressed: () => showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return EditForm(
                                            icone: Icons.description,
                                            initialValue:
                                                snapshot.data['descricao'],
                                            campo: 'Descrição',
                                            troca: 'descricao',
                                            valueKey: 'descricao',
                                            colecao: 'publicacao',
                                            valorId: widget.valorId,
                                            validator: ValidateComponents
                                                .validarDescricao,
                                            list: [
                                              LengthLimitingTextInputFormatter(
                                                  150),
                                            ],
                                          );
                                        }),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          snapshot.data['descricao'],
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: DetalhesComponents(
                  userId: snapshot.data['userId'],
                  icone: Icons.streetview,
                  titulo: 'Endereço',
                  valorVariavel: snapshot.data['endereco'] +
                      ', ' +
                      snapshot.data['numero'],
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return EditForm2(
                        initialValue: snapshot.data['endereco'],
                        initialValue2: snapshot.data['numero'],
                        valorId: widget.valorId,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Divider(
                  color: primeiraCor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: DetalhesComponents(
                  userId: snapshot.data['userId'],
                  icone: Icons.location_on,
                  titulo: 'CEP',
                  valorVariavel: snapshot.data['cep'],
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return EditForm(
                        icone: Icons.location_on,
                        initialValue: snapshot.data['cep'],
                        campo: 'CEP',
                        troca: 'cep',
                        valueKey: 'cep',
                        colecao: 'publicacao',
                        valorId: widget.valorId,
                        validator: ValidateComponents.validarCep,
                        keyBoardType: TextInputType.datetime,
                        list: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Divider(
                  color: primeiraCor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: DetalhesComponents(
                  userId: snapshot.data['userId'],
                  icone: Icons.attach_money,
                  titulo: 'Valor do aluguel',
                  valorVariavel: r"R$ " + snapshot.data['valor'] + ',00',
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return EditForm(
                        icone: Icons.attach_money,
                        initialValue: snapshot.data['valor'],
                        campo: 'Valor do aluguel',
                        troca: 'valor',
                        valueKey: 'valor',
                        colecao: 'publicacao',
                        valorId: widget.valorId,
                        validator: ValidateComponents.validarNumero,
                        keyBoardType: TextInputType.datetime,
                        list: [
                          FilteringTextInputFormatter.digitsOnly,
                          RealInputFormatter()
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Divider(
                  color: primeiraCor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    user.uid != snapshot.data['userId']
                        ? TextButton.icon(
                            icon: Icon(
                              Icons.message,
                              color: Colors.green,
                            ),
                            label: Text(
                              'Enviar mensagem',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {
                              widget.onSubmit(snapshot.data['userId']);
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
