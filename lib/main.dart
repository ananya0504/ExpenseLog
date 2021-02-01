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
      theme: ThemeData( // setting up a colour theme for the app
        fontFamily: 'Quicksand',// setting the default font
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
          ),
          button: TextStyle(color: Colors.white)
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        primarySwatch: Colors.purple,
        accentColor: Colors.amber, // an alternative colour, there is nothign called accentswatch tho
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

  List <Transaction> get _recentTransactions { //getters do not have an argument list
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),  //check if the date passed is after today -7's date
        ),
      );
    },).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){ // for adding a new transaction from the user
    final newTx = Transaction( //can't be constant(const) as the values change, therefore we use final
      title : txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx); // though it is final but we are not changing the reference of the pointer 
                                      //or the list, but just manipulating the value inside, which is allowed
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {}, //prevent closing the sheet when it is tapped on
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque, //catch the tap event and avoid it of getting handled by anything else
        );
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
          IconButton(icon: 
            Icon(Icons.add), 
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
            // Container(
            //   width: double.infinity,
            //   child: Card(
            //     child: Text("CHART!"),
            //     elevation: 5,
            //     color: Theme.of(context).primaryColorLight,
            //   ),
            // ),
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
