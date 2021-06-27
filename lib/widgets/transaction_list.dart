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
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                  //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2)),
                )
              ),
          ],
        )
        : ListView.builder(
            itemBuilder: (ctx, index){ //flutter calls this function the number of times as of transactions.length
              return Card(
                elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox( //to fir big item
                        child: Text('\$${transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style:Theme.of(context).textTheme.title ,
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
                        
              // return Card(
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         padding: EdgeInsets.all(10),
              //         margin: EdgeInsets.symmetric(
              //           vertical : 10,
              //           horizontal: 15
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //             width: 2
              //           )
              //         ),
              //         child: Text(
              //           '\$${transactions[index].amount.toStringAsFixed(2)}', //toStringAsFixed -> 2 decimal places only
              //           style: Theme.of(context).textTheme.title,
              //           ),
              //         ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             transactions[index].title,
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           Text(
              //             DateFormat.yMMMd().format(transactions[index].date),
              //             style: TextStyle(
              //               color: Colors.grey,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );
            },
            itemCount: transactions.length, //this anon function is called by flutter itself
          ),
    );
  }
}