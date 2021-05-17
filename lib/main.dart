import 'package:expenses_management/screens/add_budget_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/homePage.dart';
import 'providers/budgets.dart';
import 'screens/credit_card_summary.dart';
import './screens/cash_summary.dart';
import 'screens/splash_screen.dart';
import 'screens/cash_summary.dart';
import './providers/transact.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Transact()),
        ChangeNotifierProvider(create: (ctx) => Budgets()),
      ],
      child: MaterialApp(
        title: 'My Money',
        // theme: ThemeData.dark()
        //     .copyWith(backgroundColor: AppColors.backgroundColor),
        //home: MyHomePage(title: 'My Money'),
        home: SpashScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          CashSummary.routeName: (ctx) => CashSummary(),
          CreditCardSummary.routeName: (ctx) => CreditCardSummary(),
          'home-page': (ctx) => MyHomePage(),
          'add-details': (ctx) => AddBudgetDetails(),
        },
      ),
    );
  }
}
