import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(secondary: Colors.amber),
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: const TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String? titleInput;
  // String? ammountInput;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(id: "t1", title: "New shoes", amount: 20.11),
    // Transaction(id: "t2", title: "Weekly fees", amount: 65.23),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date?.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ) ??
          false;
    }).toList();
  }

  void _addNew(String title, double amount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNew(BuildContext btx) {
    showModalBottomSheet(
      context: btx,
      builder: (_) {
        return NewTransaction(_addNew);
      },
    );
  }

  void _delete(String id)
  {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
        title: const Text(
          "Personal Expenses",
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNew(context),
          )
        ],
      );
    
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                child: Chart(_recentTransactions),
              ),
              SizedBox(              
                height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
                child: TransactionList(_userTransactions, _delete),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () => _startAddNew(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
