import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({
    required this.userTransactions,
    Key? key,
  }) : super(key: key);

  final List<Transaction> userTransactions;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: widget.userTransactions.isEmpty
          ? Column(
              children: [
                const Text("There are no transactions yet"),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/image/waiting.png'),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(widget.userTransactions[index].date),
                    ),
                  ),
                );
                // Card(
                //   child: Row(
                //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.fromLTRB(15, 10, 25, 10),
                //         padding: const EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //           color: Theme.of(context).primaryColorLight,
                //           border: Border.all(
                //               color: Theme.of(context).primaryColorDark,
                //               width: 2),
                //           borderRadius:
                //           const BorderRadius.all(Radius.circular(10)),
                //         ),
                //         child: Text(
                //           '\$ ${widget.userTransactions[index].amount.toStringAsFixed(2)}',
                //           style: const TextStyle(
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               widget.userTransactions[index].title,
                //               style: Theme.of(context).textTheme.headline6,
                //             ),
                //             Text(
                //               DateFormat.yMMMd()
                //                   .format(widget.userTransactions[index].date),
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 color: Colors.grey[700],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: () {
                //           setState((){
                //             widget.userTransactions.removeAt(index);
                //           });
                //         },
                //         icon: const Icon(Icons.delete_outline),
                //       ),
                //       const SizedBox(
                //         width: 15,
                //       ),
                //     ],
                //   ),
                // )
              },
              itemCount: widget.userTransactions.length,
            ),
    );
  }
}
