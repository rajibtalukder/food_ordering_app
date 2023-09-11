import 'package:flutter/material.dart';

Future<void> showCustomDialog(BuildContext context, { bool? canPop, required Widget widget,
    double heightReduce=0, double widthReduce=0,
    bool reducePop = false}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: canPop ?? true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,

        child: Container(
          width: MediaQuery.of(context).size.width - widthReduce,
          height: MediaQuery.of(context).size.height - heightReduce,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child:widget
        ),
      );
    },
  );
}