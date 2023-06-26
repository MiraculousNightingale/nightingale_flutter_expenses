import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/expense.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({
    required this.userTransactions,
    required this.deleteTransaction,
    Key? key,
  }) : super(key: key);

  final List<Expense> userTransactions;

  final Function deleteTransaction;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    final theme = Theme.of(context);
    return SizedBox(
      height: 440,
      child: widget.userTransactions.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    const Text("There are no transactions yet"),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/image/waiting.png'),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${widget.userTransactions[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.userTransactions[index].title,
                      style: theme.textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      // DateFormat.yMMMd()
                      // .format(widget.userTransactions[index].date),
                      '',
                      style: theme.textTheme.titleSmall,
                    ),
                    trailing: mq.size.width > 460
                        ? OutlinedButton.icon(
                            onPressed: () => widget.deleteTransaction(
                                widget.userTransactions[index].id),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            label: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : IconButton(
                            onPressed: () => widget.deleteTransaction(
                                widget.userTransactions[index].id),
                            icon: const Icon(Icons.delete_outline),
                            color: Colors.red[900],
                          ),
                  ),
                );
              },
              itemCount: widget.userTransactions.length,
            ),
    );
  }
}
