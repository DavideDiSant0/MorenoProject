/// Formatta una data/ora come `gg/mm/aaaa hh:mm`, usato per la cronologia e
/// per i preferiti salvati.
String formatDateTime(DateTime value) {
  final day = _twoDigits(value.day);
  final month = _twoDigits(value.month);
  final year = value.year;
  final hour = _twoDigits(value.hour);
  final minute = _twoDigits(value.minute);
  return '$day/$month/$year $hour:$minute';
}

String _twoDigits(int value) => value.toString().padLeft(2, '0');
