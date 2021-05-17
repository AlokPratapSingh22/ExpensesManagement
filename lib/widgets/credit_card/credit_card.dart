import 'package:expenses_management/widgets/budget/edit_budget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../styles.dart';
import '../../providers/budgets.dart';

class CreditCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    return Container(
      child: Material(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.grey,
        child: Column(
          children: [
            FittedBox(
              child: Text(
                'Credit Card Summary',
                style: AppColors.textTheme.headline6,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Consumer<Budgets>(
              builder: (context, value, child) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Container(
                        width: (_mediaQuery.size.width -
                            _mediaQuery.padding.left -
                            _mediaQuery.padding.right),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Total - ',
                                style: AppColors.textTheme.headline5
                                    .copyWith(fontSize: 26),
                              ),
                              TextSpan(
                                text: '${value.creditCard}\n',
                                style: AppColors.textTheme.bodyText2.copyWith(
                                    fontSize: 28, color: Colors.black87),
                              ),
                              TextSpan(
                                text: 'Remaining - ',
                                style: AppColors.textTheme.headline5
                                    .copyWith(fontSize: 26),
                              ),
                              TextSpan(
                                text: '${value.remainingCredit}',
                                style: AppColors.textTheme.bodyText2.copyWith(
                                    fontSize: 28, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: EditBudget(),
                      ),
                    ],
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    'No data yet',
                    style: AppColors.textTheme.headline6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
