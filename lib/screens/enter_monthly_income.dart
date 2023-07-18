import 'package:expense_app/config/app_colors.dart';
import 'package:expense_app/screens/home_screen.dart';
import 'package:expense_app/utils/constants.dart';
import 'package:expense_app/utils/general_functions.dart';
import 'package:expense_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class EnterNativeDetails extends StatefulWidget {
  const EnterNativeDetails({super.key});

  @override
  State<EnterNativeDetails> createState() => _EnterNativeDetailsState();
}

class _EnterNativeDetailsState extends State<EnterNativeDetails> {

  final monthlyIncomeController = TextEditingController();
  final pastExpenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Tell us about your Income and Limits', style: boldTextStyle(color: AppTheme.textColor, size: 24),),
              48.height,
              ReusableTextField(controller: monthlyIncomeController, keyboardType: TextInputType.number, hint: 'Enter monthly budget', prefixIcon: Icons.currency_rupee),
              16.height,
              ReusableTextField(controller: pastExpenseController, keyboardType: TextInputType.number, hint: 'Enter expense amount done till now', prefixIcon: Icons.currency_rupee),
              48.height,
              ElevatedButton(onPressed: (){
                proceed();
              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.textColor,
                    shape: const StadiumBorder()
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('Save and Continue', style: boldTextStyle(color: AppTheme.white),),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void proceed() {
    if (monthlyIncomeController.text.isEmpty){
      toast('Enter monthly amount before proceeding');
      return;
    }

    if (pastExpenseController.text.isEmpty){
      toast('Enter past expense amount before proceeding');
      return;
    }

    var monthlyIncome = monthlyIncomeController.text.toInt();
    var pastExpense = pastExpenseController.text.toInt();
    var startingBal = monthlyIncome - pastExpense;

    setValue(Constants.monthlyIncome, monthlyIncome);
    setValue(Constants.currentBalance, startingBal);
    setValue(Constants.startingBalance, startingBal);

    GeneralFunctions.navigateTo(context, const HomeScreen(), true);
  }
}
