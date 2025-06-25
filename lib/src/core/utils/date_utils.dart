import 'package:intl/intl.dart';

extension DateTimePtBrExtension on DateTime {
  String toDatePtbr() {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(this);
  }
}
