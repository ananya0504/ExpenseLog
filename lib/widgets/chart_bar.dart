
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label,this.spendingAmount, this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[ 
        Container( // so that when the amount shrinks, everything does not move upwards
          height: 20,
          child: FittedBox(child: // to avoid line wrapping, we shrink text
            Text('₹${spendingAmount.toStringAsFixed(0)}',), // rounded integer value
          ),
        ),
        SizedBox(height : 4,),//adding some space
        Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.black, width: 1.0),
          // ),
          height: 60,
          width: 10,
          child: Stack(children: <Widget>[ //this widget takes elements on top of each other
            Container(decoration: 
              BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Color.fromRGBO(220, 220, 220, 1), //light grey color
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox( //stacked on top of container widget which makes a container of a fractional size 
              heightFactor: spendingPctOfTotal,
              child: Container( decoration: //using for decoration as no boxdecoration is available for fractionallysizedbox
                BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
              ),

              ),
            )
          ],),
        ),
        SizedBox(height: 4,),
        Text(label),
      ]
    );
  }
}