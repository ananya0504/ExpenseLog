import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ExpenseLog/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get GroupedTransactionvalues {//getters do not have an argument list, they are properties defined dynamically
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;

      for(var i=0 ; i<recentTransaction.length ; i++)
      { if( recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
              totalSum += recentTransaction[i].amount;
            }
      }
      
      print(DateFormat.E().format(weekDay).substring(0,1));
      print(totalSum);

      return {
        'day':DateFormat.E().format(weekDay).substring(0,1), //speical format which gives a shortcut -> M for monday
        'amount': totalSum};
    }).reversed.toList(); //reversed to put the recent most day at the right and tolist to covert the iterable to a list
  }

  double get totalSpending{ //getter for caluclating the total till that day 
    return GroupedTransactionvalues.fold(0.0, (sum,item) {
      return sum + item['amount'];
    }); //fold allows to change a list into another according to the login we define in fold
  }

  @override
  Widget build(BuildContext context) {
    print(GroupedTransactionvalues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding( //padding widget if you just need to add a padding
          padding: EdgeInsets.all(10),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: GroupedTransactionvalues.map(
            (data){
              return Flexible(
                fit: FlexFit.tight, //to make sure that the text doesn't spread that much
                child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
              );
            }
          ).toList(),
        ),
      ),
    );
  }
}