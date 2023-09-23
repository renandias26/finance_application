import 'package:finance_application/src/account.dart';
import 'package:finance_application/src/enums/account_type.dart';
import 'package:finance_application/src/enums/transaction_type.dart';
import 'package:finance_application/src/messages/messages.dart';
import 'package:finance_application/src/transaction.dart';
import 'package:test/test.dart';

void main() {
  test('Account', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    expect(account?.saldo, 20);
  });
  test('Joint account', () {
    var account = Account.create(0, ["Renan", "Lucas"], 20, AccountType.corrente);
    expect(account?.saldo, 20);
  });
  test('Savings account', () {
    var account = Account.create(0, ["Renan"], 50, AccountType.poupanca);
    expect(account?.saldo, 50);
  });
  test('Many holders', () {
    var account = Account.create(0, ["Renan", "Caio", "Matheus"], 20, AccountType.corrente);
    expect(account, null);
  });
  test('Invalid balance from savings account', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.poupanca);
    expect(account, null);
  });
  test('Invalid holders', () {
    var account = Account.create(0, [], 20, AccountType.corrente);
    expect(account, null);
  });
  test('Deposit', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    account?.deposit(1, 50);
    expect(account?.saldo, 70);
  });
  test('Payment Success', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    expect(account?.payment(1, 10, DateTime.now()), Messages.success);
  });
  test('Payment Failed', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    expect(account?.payment(1, 30, DateTime.now()), Messages.errorInsufficientFunds);
  });
  test('Extract', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    account?.deposit(1, 50);
    account?.payment(1, 50, DateTime.now());
    expect(account?.getExtract(DateTime.now().add(const Duration(days: 1)), DateTime(2023, 9, 21)).length, 2);
  });
  test('Application Success', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    expect(account?.application(1, DateTime.now(), 1), Messages.success);
  });
  test('Application Failed', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    expect(account?.application(30, DateTime.now(), 1), Messages.errorInsufficientFunds);
  });
  test('Simulating Application', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    expect(account?.simulateApplication(100, DateTime.now().add(const Duration(days: 1))), 110);
  });
  test('Low Financing', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    expect(account?.financing(100, DateTime(2024)), 125);
  });
  test('High Financing', () {
    var account = Account.create(0, ["Renan"], 20, AccountType.corrente);
    expect(account?.financing(100, DateTime(2026)), 150);
  });
  test('Create Transaction', () {
    var transaction = Transaction.create(001, 002, 12, DateTime(2023, 9, 21), TransactionType.deposit);
    expect(transaction.senderID, 001);
  });
}
