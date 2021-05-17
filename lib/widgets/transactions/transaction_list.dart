import 'package:expenses_management/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expenses_management/styles.dart';

import 'package:provider/provider.dart';
import '../../providers/transact.dart';

class TransactionsList extends StatelessWidget {
  final TransactionMode _transactionMode;

  const TransactionsList(this._transactionMode);

  Widget buildTile(Transaction transaction) {
    if (transaction.transactionMode != _transactionMode &&
        _transactionMode != null) return Container();
    return ListTile(
      title: Text(
        transaction.title,
        style: AppColors.textTheme.bodyText1,
      ),
      subtitle: Text(
        transaction.description,
        style: AppColors.textTheme.bodyText2,
      ),
      trailing: Text(
        'Rs.${transaction.amount}',
        style: AppColors.textTheme.bodyText1,
      ),
      key: ValueKey(transaction.id),
      hoverColor: AppColors.cardColor.withOpacity(0.5),
      minVerticalPadding: 5,
      onTap: () => null,
      leading: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1, color: Colors.black38, style: BorderStyle.solid)),
        child: Text(
          '${transaction.dateTime.day}/${transaction.dateTime.month}/${transaction.dateTime.year}',
          style: AppColors.textTheme.headline5,
          softWrap: true,
          maxLines: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Transact>(context, listen: false).fetchAndSetPlaces(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<Transact>(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.moon_zzz_fill,
                        color: Colors.black,
                        size: 200,
                      ),
                      Text(
                        'No Transactions added yet',
                        style: AppColors.textTheme.headline6
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  builder: (context, value, child) {
                    if (value.items.length <= 0) return child;
                    return ListView.builder(
                      padding: EdgeInsets.only(left: 10, right: 20, top: 20),
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = value.items;
                        return buildTile(data[index]);
                      },
                      itemCount: value.items.length,
                    );
                  }),
    );
  }
}
