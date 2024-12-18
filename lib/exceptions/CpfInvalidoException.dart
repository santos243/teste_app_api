class CpfInvalidoException extends FormatException {
  CpfInvalidoException(super.message);

  @override
  String toString() {
    return 'CPF incorreto, verifique se contém os 11 digitos';
  }
}
