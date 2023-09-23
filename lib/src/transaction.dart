import 'package:finance_application/src/enums/transaction_type.dart';

class Transaction{
  int recipientID;
  int senderID;
  double value;
  DateTime date;
  TransactionType type;
  bool checked;

  Transaction._(this.senderID, this.recipientID, this.value, this.date, this.type, this.checked);

  static Transaction create(int senderID, int recipientID, double value, DateTime date, TransactionType type){
    return Transaction._(senderID, recipientID, value, date, type, date.isBefore(DateTime.now()));
  }
}