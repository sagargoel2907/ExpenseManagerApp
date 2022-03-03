import 'package:expense_manager/widgets/chart.dart';
import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: "Quicksand",
          textTheme: TextTheme(bodyText1: TextStyle(fontSize: 15)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(fontSize: 20, fontFamily: "OpenSans"))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  var _showChart = true;
  final List<Transaction> transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Kathi roll',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Jalebi',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'tk',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Peanuts',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(String txtitle, double amount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txtitle,
      amount: amount,
      date: txDate,
    );
    setState(() {
      transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var isLandscape =
        mediaQuery.orientation == Orientation.landscape;
    var appBar = AppBar(title: Text('Flutter App'), actions: [
      IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: Icon(Icons.add)),
    ]);
    var txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    "No Transactions yet!",
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Container(
                    height: constraints.maxHeight*0.8,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              );
            })
          : TransactionList(transactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart"),
                Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) => setState(() {
                          _showChart = val;
                        })),
              ],
            ),
          if (isLandscape)
            _showChart
                ? Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(transactions),
                  )
                : txList,
          if (!isLandscape)
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(transactions),
            ),
          if (!isLandscape) txList,
        ],
      ),
    );
  }
}
