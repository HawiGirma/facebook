import 'package:flutter/material.dart';
import 'package:facebook/features/utils/app_constants.dart';

class WidgetUtils {
  static void showErrorSnackBar(BuildContext context, String message) {
    if (message.isEmpty) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.errorColor,
        duration: AppConstants.snackBarDuration,
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.successColor,
        duration: AppConstants.snackBarDuration,
      ),
    );
  }

  static AppBar buildAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    TextStyle? titleStyle,
  }) {
    return AppBar(
      title: Text(
        title,
        style: titleStyle ?? AppConstants.appBarTitleStyle,
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      leading: leading,
      actions: actions,
    );
  }

  static AppBar buildSubtitleAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    required BuildContext context,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppConstants.appBarSubtitleStyle,
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      leading: leading ??
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
      actions: actions,
    );
  }
}

