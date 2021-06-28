import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx; // pointer at the function in main.dart file

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) { //context is an object(in built property) which contains the metadata about a widget.
    return Container(

      height: 450,
      child: transactions.isEmpty
        ? Column( 
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'No Transactions Added Yet!',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                )
              ),
          ],
        )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index){ //flutter calls this function the number of times as of transactions.length
              return Card(
                elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox( //to fit big item
                        child: Text('Rs.${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style:Theme.of(context).textTheme.headline6 ,
                  ),
                  subtitle: Text( 
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete), 
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx( transactions[index].id),
                  ),
                ),
              );
            },
          ),
    );
  }
}