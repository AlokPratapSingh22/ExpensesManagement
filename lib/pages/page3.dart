import 'package:expenses_management/screens/credit_card_summary.dart';
import 'package:expenses_management/widgets/transactions/add_transaction.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class Page3 extends StatelessWidget {
  const Page3({
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
        CreditCardSummary(),
        const Align(
          alignment: Alignment.bottomRight,
          child: AddTransaction(),
        )
      ],
    );
  }
}
