import 'package:expenses_management/screens/money_summary.dart';
import 'package:expenses_management/widgets/transactions/add_transaction.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.backgroundFadedColor,
                AppColors.backgroundColor,
              ],
              stops: [0.0, 1],
            ),
          ),
        ),
        MoneySummary(),
        const Align(
          alignment: Alignment.bottomRight,
          child: AddTransaction(),
        )
      ],
    );
  }
}
