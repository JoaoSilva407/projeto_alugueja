import 'dart:io';

enum UserMode {
  EDITAR,
  SALVAR,
}

class UserModel {
  String name;
  String sobrenome;
  String email;
  String password;
  String birthDate;
  String telefone;
  File image;
  UserMode _mode = UserMode.EDITAR;

  UserModel({
    this.name,
    this.sobrenome,
    this.email,
    this.password,
    this.birthDate,
    this.telefone,
    this.image,
  });

  bool get isEdit {
    return _mode == UserMode.EDITAR;
  }

  bool get isSave {
    return _mode == UserMode.SALVAR;
  }

  void toggleMode() {
    _mode = _mode == UserMode.EDITAR ? UserMode.SALVAR : UserMode.EDITAR;
  }
}
