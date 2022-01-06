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
    return Column(
      children: [
        Text(_spendingAmount.toStringAsFixed(0)),
        SizedBox(height: 10),
        Container(
          height: 150,
          width: 150 / 4,
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
        SizedBox(height: 10),
        Text(_lable),
      ],
    );
  }
}
