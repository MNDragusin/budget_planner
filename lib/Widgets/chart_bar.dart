import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(this._lable, this._spendingAmount, this._spendingPctOfTotal,
      {Key? key})
      : super(key: key);

  final String _lable;
  final double _spendingAmount;
  final double _spendingPctOfTotal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
                height: constraints.maxHeight * 0.15,
                child:
                    FittedBox(child: Text(_spendingAmount.toStringAsFixed(0)))),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.6,
              width: constraints.maxWidth * 0.35,
              decoration: BoxDecoration(
                  color: Colors.grey[220],
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: _spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).indicatorColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text(_lable))),
          ],
        );
      },
    );
  }
}
