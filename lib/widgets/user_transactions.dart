import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}


class _UserTransactionState extends State<UserTransaction> {
  final List <Transaction> _userTransactions = [
    Transaction(
    id: "t1",
    title:"New Shoes",
    amount: 69.99,
    date: DateTime.now() 
  ),
  Transaction(
    id: "t2",
    title:"Weekly Groceries",
    amount: 16.53,
    date: DateTime.now() 
  ),
  ];

  void _addNewTransaction(String txTitle, double txAmount){ // for adding a new transaction from the user
    final newTx = Transaction(
      title : txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx); // though it is final but we are not changing the reference of the pointer 
                                      //or the list, but just manipulating the value inside, which is allowed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction), //passing the pointer(without paranthesis) of the function to the widget
        TransactionList(_userTransactions),
      ]
    );
  }
}