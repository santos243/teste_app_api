class CategoriaCaracteresException extends FormatException {
  CategoriaCaracteresException(super.message);

  @override
  String toString() {
    return 'Categoria incorreta, poucos caracteres digitados!';
  }
}
