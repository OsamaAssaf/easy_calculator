import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

class HomeViewModel with ChangeNotifier {
  List<String> numberList = ['.', '0', '=', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  List<String> operatorsList = [
    'DEL',
    '÷',
    '×',
    '-',
    '+',
  ];

  final List<String> _calculateValue = [];
  String _result = '';

  List<String> get calculateValue => _calculateValue;
  String get result => _result;

  Material pressControl(String value, bool isNumber) {
    return Material(
      color: isNumber ? Colors.grey[900] : Colors.grey[800],
      child: InkWell(
        onTap: () {
          if (value == '=') {
            if (_calculateValue.isEmpty) {
              return;
            }
            if (RegExp(r'[-+×÷]').hasMatch(_calculateValue.last)) {
              _calculateValue.removeLast();
            }
            getResult(_calculateValue);
          } else if (value == 'DEL') {
            if (_calculateValue.isEmpty) {
              return;
            }
            _calculateValue.removeLast();
          } else if (RegExp(r'[-+×÷.]').hasMatch(value)) {
            if (_calculateValue.isEmpty) {
              if (value == '-' || value == '.') {
                _calculateValue.add(value);
              }
            } else {
              if (RegExp(r'[-+×÷.]').hasMatch(_calculateValue.last)) {
                _calculateValue.last = value;
              } else {
                _calculateValue.add(value);
              }
            }
          } else {
            _calculateValue.add(value);
          }
          notifyListeners();
        },
        onLongPress: () {
          if (value == 'DEL') {
            _calculateValue.clear();
            _result = '';
          }
          notifyListeners();
        },
        splashColor: Colors.grey,
        radius: 50.0,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: isNumber ? 32 : 16),
          ),
        ),
      ),
    );
  }

  void getResult(List<String> value) {
    String finalUserInput = value.join().replaceAll('×', '*').replaceAll('÷', '/');
    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    _result = eval.toString();
    notifyListeners();
  }
}
