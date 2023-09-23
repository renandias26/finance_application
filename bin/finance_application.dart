import 'package:finance_application/src/account.dart';
import 'package:finance_application/src/enums/account_type.dart';
void main(List<String> arguments) {
  var account = Account.create(0, ["Renan, Caio, Matheus"], 20, AccountType.corrente);
  print(account);
}
