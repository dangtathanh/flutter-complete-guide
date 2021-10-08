import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNew;

  const NewTransaction(this.addNew);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text.isEmpty ? 0 : double.parse(_amountController.text);
    final enteredDate = _selectedDate == null ? DateTime.now() : (_selectedDate as DateTime);

    if(enteredTitle.isEmpty || enteredAmount < 0)
    {
      return;
    }

    widget.addNew(
      enteredTitle,
      enteredAmount,
      enteredDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if(value == null)
      {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: TextStyle(
      color: Theme.of(context).primaryColor,
    ));
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Shosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: const Text('Choose Date'),
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: style,
                child: const Text("Add transaction"),
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
