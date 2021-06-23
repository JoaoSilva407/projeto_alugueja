class ValidateComponents {
  static validarNome(String value) {
    String patttern = r'(^[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  static validarSobrenome(String value) {
    String patttern = r'(^[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o sobrenome";
    } else if (!regExp.hasMatch(value)) {
      return "O sobrenome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  static validarDescricao(String value) {
    String patttern = r'(^[a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe a descrição";
    } else if (!regExp.hasMatch(value)) {
      return "Descrição inválida";
    }
    return null;
  }

  static validarTitulo(String value) {
    String patttern = r'(^[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o titulo";
    } else if (!regExp.hasMatch(value)) {
      return "O titulo deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  static validarEndereco(String value) {
    String patttern = r'(^[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o endereço";
    } else if (!regExp.hasMatch(value)) {
      return "O endereço deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  static validarNumero(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o número";
    } else if (!regExp.hasMatch(value)) {
      return "O número deve conter caracteres de 0-9";
    }
    return null;
  }

  static validarCep(String value) {
    String patttern = r'^[0-9]{2}.[0-9]{3}-[0-9]{3}$';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o CEP";
    } else if (!regExp.hasMatch(value)) {
      return "CEP inválido";
    }
    return null;
  }

  static validarCidade(String value) {
    String patttern = r'(^[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe a cidade";
    } else if (!regExp.hasMatch(value)) {
      return "Cidade inválida";
    }
    return null;
  }

  static validarCelular(String value) {
    String patttern = r'^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe o número do celular";
    } else if (!regExp.hasMatch(value)) {
      return "O número do celular so deve conter dígitos";
    }
    return null;
  }

  static validarEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  static validarSenha(String value) {
    String patttern = r"^(?=.*\d)(?=.*[a-zA-Z])(?!.*[\W_\x7B-\xFF]).{8,15}$";
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe a senha";
    } else if (!regExp.hasMatch(value)) {
      return "A senha deve conter de 8 a 15 caracteres, letras e números";
    }
    return null;
  }

  static validarData(String value) {
    String patttern =
        r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Informe a data de nascimento";
    } else if (!regExp.hasMatch(value)) {
      return "Data de nascimento inválida";
    }
    return null;
  }
}
