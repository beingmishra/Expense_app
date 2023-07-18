import 'package:expense_app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GeneralFunctions {
  static navigateTo(BuildContext context, Widget widget, bool isNew) {
    isNew
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => widget))
        : Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget));
  }

  static FaIcon getCategoryIcon(String category) {
    FaIcon? iconData;
    switch (category) {
      case 'grocery':
        iconData = const FaIcon(FontAwesomeIcons.cartShopping, color: AppTheme.white,);
        break;
      case 'clothes':
        iconData = const FaIcon(FontAwesomeIcons.shirt, color: AppTheme.white,);
        break;
      case 'entertainment':
        iconData = const FaIcon(FontAwesomeIcons.film, color: AppTheme.white,);
        break;
      case 'fuel':
        iconData = const FaIcon(FontAwesomeIcons.oilCan, color: AppTheme.white,);
        break;
      case 'rent':
        iconData = const FaIcon(FontAwesomeIcons.house, color: AppTheme.white,);
        break;
      case 'snacks':
        iconData = const FaIcon(FontAwesomeIcons.bowlFood, color: AppTheme.white,);
        break;
      case 'subscription':
        iconData = const FaIcon(FontAwesomeIcons.n, color: AppTheme.white,);
        break;
      case 'travel':
        iconData = const FaIcon(FontAwesomeIcons.plane, color: AppTheme.white,);
        break;
      default:
        iconData = const FaIcon(FontAwesomeIcons.question, color: AppTheme.white,);
    }

    return iconData;
  }
}
