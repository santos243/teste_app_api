class SemNomeException extends FormatException {
  SemNomeException(super.message);

  @override
  String toString(){
    return 'preencha seu nome completo!';
  }
}
