extension DoubleFormatting on double {
  String formatToString() {
    final formattedValue = toStringAsFixed(2); // Format with two decimal places
    final withoutTrailingZeros = formattedValue.replaceAll(
        RegExp(r'\.?0+$'), ''); // Remove decimal places if it is only zero
    return withoutTrailingZeros;
  }
}
