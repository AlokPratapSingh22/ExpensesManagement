import 'package:expenses_management/widgets/budget/budget_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../styles.dart';
import '../custom_rect_tween.dart';
import '../hero_dialog_route.dart';
import '../../providers/budgets.dart';

class EditBudget extends StatelessWidget {
  /// {@macro add_todo_button}
  const EditBudget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return const _EditTransaction();
          }));
        },
        child: Hero(
          tag: _heroEdit,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroEdit = 'edit-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Transaction]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTransaction].
/// {@endtemplate}
class _EditTransaction extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _EditTransaction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _budget = Provider.of<Budgets>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroEdit,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: AppColors.accentColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: BudgetForm(budget: _budget),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
