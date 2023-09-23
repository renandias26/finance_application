import 'package:finance_application/src/enums/account_type.dart';
import 'package:finance_application/src/enums/transaction_type.dart';
import 'package:finance_application/src/messages/messages.dart';
import 'package:finance_application/src/transaction.dart';
class Account {
  int numero;
  List<String> titular;
  double saldo;
  AccountType type;
  List<Transaction> extract;

  Account._(this.numero, this.titular, this.saldo, this.type, this.extract);

  static Account? create(int number, List<String> title, double saldo, AccountType type){
    if((type == AccountType.poupanca && saldo < 50)||(title.length > 2)||(title.isEmpty)){
      return null;
    }
    return Account._(number, title, saldo, type, []);
  }

  String deposit(int senderID, double value) {
    extract.add(Transaction.create(senderID, numero, value, DateTime.now(), TransactionType.deposit));
    saldo += value;
    return Messages.success;
  }

  String payment(int senderID, double value, DateTime date) {
    if (value > saldo){
      return Messages.errorInsufficientFunds;
    }
    extract.add(Transaction.create(senderID, numero, value, date, TransactionType.payment));
    saldo -= value;
    return Messages.success;
  }

  List<Transaction> getExtract(DateTime dateEnd, DateTime dateBegin) {
    return extract.where((element) => (element.date.isBefore(dateEnd) && element.date.isAfter(dateBegin))).toList();
  }

  String application(double value, DateTime date, int applicationID){
    if(value > saldo){
      return Messages.errorInsufficientFunds;
    }
    extract.add(Transaction.create(numero, applicationID, value, date, TransactionType.application));
    saldo -= value;
    return Messages.success;
  }

  double simulateApplication(double value, DateTime dateEnd){
    double fees = 1.1;
    double mount = value;
    Duration time = dateEnd.difference(DateTime.now());
    for (var i = 0; i < time.inDays; i++) {
      mount = mount * fees;
    }

    return mount.truncateToDouble();
  }

  double financing(double value, DateTime dateEnd){
    double fees = 0.25;
    if ((dateEnd.year - DateTime.now().year)>1) {
      fees = fees * 2;
    }
    return value * (fees + 1);
  }
}