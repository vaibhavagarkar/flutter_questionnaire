String formatDateTime(DateTime value) {
  String twoDigits(int part) => part.toString().padLeft(2, '0');

  final day = twoDigits(value.day);
  final month = twoDigits(value.month);
  final year = value.year.toString();
  final hour = twoDigits(value.hour);
  final minute = twoDigits(value.minute);

  return '$day/$month/$year $hour:$minute';
}
