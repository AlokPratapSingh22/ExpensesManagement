import 'package:expenses_management/providers/budgets.dart';
import 'package:expenses_management/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final budget = Provider.of<Budgets>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.money_rounded,
            size: 100,
            color: Colors.purple.shade100,
          ),
          Text(
            'Hey ${budget.name}!',
            style: AppColors.textTheme.headline6.copyWith(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
          Text(
            'Here\'s your budget details!',
            style: AppColors.textTheme.headline5.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontSize: 26,
            ),
          ),
          Flexible(
            child: GridView(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                GridTile(
                  child: Container(
                    padding: const EdgeInsets.only(top: 5, left: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.amber,
                          width: 3,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: RichText(
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${(budget.cash + budget.creditCard).toStringAsFixed(2)}\n',
                            style: AppColors.formTheme.bodyText1.copyWith(
                                color: Colors.black54,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                        text: 'Total\n',
                        style: GoogleFonts.openSansCondensed(
                          color: Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GridTile(
                  child: Container(
                    padding: const EdgeInsets.only(top: 5, left: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.red.shade200,
                          width: 3,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: RichText(
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${(budget.cash + budget.creditCard - budget.remainingCash - budget.remainingCredit).toStringAsFixed(2)}\n',
                            style: AppColors.formTheme.bodyText1.copyWith(
                                color: Colors.black54,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                        text: 'Spent\n',
                        style: GoogleFonts.openSansCondensed(
                          color: Colors.black87,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GridTile(
                  child: Container(
                    padding: const EdgeInsets.only(top: 5, left: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.purple.shade200,
                          width: 3,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: RichText(
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Total - ',
                            style: AppColors.formTheme.bodyText1
                                .copyWith(color: Colors.black54),
                          ),
                          TextSpan(
                            text: '${budget.cash.toStringAsFixed(2)}\n',
                            style: AppColors.formTheme.bodyText1.copyWith(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: 'Spent - ',
                            style: AppColors.formTheme.bodyText1
                                .copyWith(color: Colors.black54),
                          ),
                          TextSpan(
                            text:
                                '${(budget.cash - budget.remainingCash).toStringAsFixed(2)}\n',
                            style: AppColors.formTheme.bodyText1.copyWith(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                        ],
                        text: 'Cash\n',
                        style: GoogleFonts.openSansCondensed(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GridTile(
                  child: Container(
                    padding: const EdgeInsets.only(top: 5, left: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.cyan.shade100,
                          width: 3,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: RichText(
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Total - ',
                            style: AppColors.formTheme.bodyText1
                                .copyWith(color: Colors.black54),
                          ),
                          TextSpan(
                            text: '${budget.creditCard.toStringAsFixed(2)}\n',
                            style: AppColors.formTheme.bodyText1.copyWith(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: 'Spent - ',
                            style: AppColors.formTheme.bodyText1
                                .copyWith(color: Colors.black54),
                          ),
                          TextSpan(
                            text:
                                '${(budget.creditCard - budget.remainingCredit).toStringAsFixed(2)}\n',
                            style: AppColors.formTheme.bodyText1.copyWith(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                        ],
                        text: 'Credit Card\n',
                        style: GoogleFonts.openSansCondensed(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: MediaQuery.of(context).size.height / 7,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
