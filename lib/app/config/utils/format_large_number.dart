String formatLargeNumber(int number) {
  if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1)}M';
  } else if (number >= 1000) {
    // Aquí verificamos si el decimal es diferente de cero
    double decimalPart = (number / 1000) - ((number / 1000).truncateToDouble());
    if (decimalPart != 0) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return '${(number / 1000).toStringAsFixed(0)}k';
    }
  } else {
    return number.toString();
  }
}
