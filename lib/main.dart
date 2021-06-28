import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData( // setting up a theme
        fontFamily: 'Quicksand',// default font
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
          ),
          button: TextStyle(color: Colors.white)
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        primarySwatch: Colors.purple,
        accentColor: Colors.amber, // an alternative colour, there is nothing called accentswatch tho
        errorColor: Colors.red,
      ),
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List <Transaction> _userTransactions = [
    Transaction(
    id: "t1",
    title:"New Shoes",
    amount: 2000,
    date: DateTime.now() 
  ),
  Transaction(
    id: "t2",
    title:"Weekly Groceries",
    amount: 1500,
    date: DateTime.now() 
  ),
  Transaction(
    id: "t3",
    title:"Ice Cream",
    amount: 60,
    date: DateTime.now() 
  ),
  Transaction(
    id: "t4",
    title:"Clothes",
    amount: 4000,
    date: DateTime.now() 
  ),
  Transaction(
    id: "t5",
    title:"Medicines",
    amount: 550,
    date: DateTime.now() 
  ),
  Transaction(
    id: "t6",
    title:"Notebook",
    amount: 220,
    date: DateTime.now() 
  ),
  Transaction(
    id: "t7",
    title:"Pens",
    amount: 100,
    date: DateTime.now() 
  ),

  ];

  List <Transaction> get _recentTransactions { //no argument list
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),  // to check if date passed is after today -7's date
        ),
      );
    },).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){ // adding new transaction from user
    final newTx = Transaction( //can't be constant(const) as the values change, therefore we use final
      title : txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx); // although final, unchanged reference of pointer, manipulating the value inside, which is allowed
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      }
    );
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ]
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        //elevation: 5,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
