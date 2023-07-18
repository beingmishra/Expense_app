import 'package:expense_app/config/app_colors.dart';
import 'package:expense_app/models/expense_item_model.dart';
import 'package:expense_app/utils/general_functions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ExpenseItem extends StatelessWidget {
  final ExpenseItemModel expenseItemModel;
  const ExpenseItem({super.key, required this.expenseItemModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.textColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(child: GeneralFunctions.getCategoryIcon(expenseItemModel.category!)),
              ),
              8.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expenseItemModel.category!, style: boldTextStyle(color: AppTheme.textColor, size: 22),),
                  Text(expenseItemModel.description!, style: primaryTextStyle(color: textSecondaryColor, size: 18),),
                ],
              )
            ],
          ),
          Text('₹ ${expenseItemModel.amount}', style: boldTextStyle(color: AppTheme.textColor, size: 22),)
        ],
      ),
    );
  }
}
