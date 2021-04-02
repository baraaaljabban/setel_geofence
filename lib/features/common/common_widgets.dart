import 'package:flutter/material.dart';

class CommonWidgets {
  void showLoadingSnackBar(BuildContext context, {String message}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: LoadingIndicator(),
        backgroundColor: Colors.transparent,
        duration: Duration(days: 1),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, {String message}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSuccessSnackBar(BuildContext context, {String message}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void showWarningSnackBar(BuildContext context, {String message}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
      ),
    );
  }

  InputDecoration inputDecorations(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white)),
      contentPadding: EdgeInsets.all(8.0),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
}
