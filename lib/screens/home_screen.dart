import 'dart:math';

import 'package:expense_app/config/app_colors.dart';
import 'package:expense_app/data/expenses_db.dart';
import 'package:expense_app/models/expense_item_model.dart';
import 'package:expense_app/utils/constants.dart';
import 'package:expense_app/widgets/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentBal = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ExpenseItemModel> dummyExpenseList = [];
  List<ExpenseItemModel> expenseList = [];
  List<String> categories = [
    'grocery',
    'fuel',
    'subscription',
    'rent',
    'entertainment',
    'clothes',
    'snacks',
    'travel'
  ];

  @override
  void initState() {
    super.initState();
    fetchCurrentBalance();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              buildTopBar(),
              buildCard(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All expenses',
                    style: boldTextStyle(color: AppTheme.textColor, size: 18),
                  ),
                  Text(
                    'View All',
                    style:
                        primaryTextStyle(color: textSecondaryColor, size: 14),
                  ),
                ],
              ),
              12.height,
              expenseList.isEmpty
                  ? const Center(child: Text('No data found'))
                  : ListView.separated(
                      itemCount: expenseList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ExpenseItem(
                          expenseItemModel: expenseList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return 12.height;
                      },
                    ).expand()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handleAdd();
        },
        backgroundColor: AppTheme.textColor,
        child: const Icon(
          Icons.add,
          color: AppTheme.white,
        ),
      ),
    );
  }

  buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Dashboard',
          style: boldTextStyle(size: 32, color: AppTheme.textColor),
        ),
        const Icon(
          Icons.account_circle,
          size: 48,
        )
      ],
    );
  }

  buildCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(28),
      height: 180,
      decoration: BoxDecoration(
          color: AppTheme.textColor, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '₹ $currentBal',
            style: boldTextStyle(color: AppTheme.white, size: 28),
          ),
          Text(
            'INR',
            style: boldTextStyle(color: textSecondaryColor),
          )
        ],
      ),
    );
  }

  void fetchItems() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      var fetchedItems = databaseHelper.getExpensesList();
      fetchedItems.then((value) {
        setState(() {
          expenseList = value;
        });
      });
    });
  }

  void handleAdd() {
    var rand = Random();
    DateTime now = DateTime.now();
    var amount = rand.nextInt(1000);
    var currentBalance = getIntAsync(Constants.currentBalance);
    if (currentBalance > amount) {
      setValue(Constants.currentBalance, currentBalance - amount);
      var data = ExpenseItemModel(
          category: categories[rand.nextInt(categories.length)],
          amount: amount.toString(),
          description: 'This is a test description',
          date: now.toString());
      databaseHelper.insertNote(data);
      fetchItems();
      fetchCurrentBalance();
    } else {
      toast('Not enough balance');
    }
  }

  void fetchCurrentBalance() {
    currentBal = getIntAsync(Constants.currentBalance);
    setState(() {});
  }
}
