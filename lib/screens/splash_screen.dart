import 'package:expense_app/config/app_colors.dart';
import 'package:expense_app/screens/enter_monthly_income.dart';
import 'package:expense_app/screens/home_screen.dart';
import 'package:expense_app/utils/constants.dart';
import 'package:expense_app/utils/general_functions.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    var monthlyIncome = getIntAsync(Constants.monthlyIncome, defaultValue: -1);
    Future.delayed(
      const Duration(seconds: 3)
    ).then((value) {
      if(monthlyIncome == -1){
        GeneralFunctions.navigateTo(context, const EnterNativeDetails(), true);
      }else{
        GeneralFunctions.navigateTo(context, const HomeScreen(), true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: Image.asset('assets/icons/budget.png', height: 150, width: 150,),
        ),
      ),
    );
  }
}
