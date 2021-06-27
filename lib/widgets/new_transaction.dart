import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//state widget
class NewTransaction extends StatefulWidget { //converted the stateless widget to stateful widget because else the data was getting lost
  //in the bottomsheet. Stateless widgets are re-evaluated from time to time and therefore the data gets lost, it is not saved.
  // but in stateful widget it gets saved
  final Function addTx;

  NewTransaction(this.addTx); //data is accepted in the state widget and not the state object class.
  @override
  _NewTransactionState createState() => _NewTransactionState();
}


class _NewTransactionState extends State<NewTransaction> { //state object class
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selecteddate; 

  void _submitData(){
    if(_amountController.text.isEmpty)
      return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <=0 || _selecteddate == null)
      return;
    //flutter creates widget. so that we can access the widget properties in its state object class.
    widget.addTx( //calling the function and passing parameters
      enteredTitle,
      enteredAmount,
      _selecteddate,
    );
    Navigator.of(context).pop(); //automatically closes the modal sheet once the submit is clicked
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), //default selected date
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
        if (pickedDate == null)
          return;
        setState(() {
          _selecteddate = pickedDate;
        });
        
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title: '
                    ),
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                    // onChanged: (val) {
                    //   titleInput=val;
                    // },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount: '
                    ),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(), //executing inside an anonymous function, therefore need to call it manually
                    // onChanged: (val) => amountInput=val,
                  ),
                  Container(
                    height: 70,
                    child: Row(children: <Widget>[ //for a date picker on the modal sheet
                      Expanded(
                        child: Text(
                          _selecteddate == null 
                          ? 'No Date Chosen!'
                          : 'Picked Date:${DateFormat.yMd().format(_selecteddate)}'),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        color: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _presentDatePicker,
                      )
                    ]),
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    child: Text("Add Transaction"),
                    onPressed: _submitData, //not sending via anonymous function, therefore no need for () for passing the reference
                  )
                ],
              ),
            ),
          );
  }
}