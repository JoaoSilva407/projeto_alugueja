import 'dart:io';

class ComercioModel {
  String titulo;
  String descricao;
  String endereco;
  String numero;
  String cep;
  String cidade;
  String estado;
  String valor;
  File image;

  ComercioModel({
    this.titulo,
    this.descricao,
    this.endereco,
    this.numero,
    this.cep,
    this.cidade,
    this.estado,
    this.valor,
    this.image,
  });
}
