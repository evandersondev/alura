double formatCurrencyToDouble(String currency) {
  final string = currency.replaceAll(RegExp(r'[R$.,]'), '').trim().split('');
  string.insert(string.length - 2, '.');
  return double.parse(string.join(''));
}
