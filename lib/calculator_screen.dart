import 'dart:math';

import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentNumber = "";
  double _num1 = 0;
  String _operator = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _currentNumber = "";
        _num1 = 0;
        _operator = "";
      } else if (buttonText == "DEL") {
        if (_currentNumber.isNotEmpty) {
          _currentNumber = _currentNumber.substring(0, _currentNumber.length - 1);
          _output = _currentNumber;
          if (_currentNumber.isEmpty) {
            _output = "0";
          }
        }
      } else if (buttonText == "√") {
        if (_currentNumber.isNotEmpty) {
          _num1 = double.parse(_currentNumber);
          _output = sqrt(_num1).toString();
          _currentNumber = _output;
        }
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (_currentNumber.isNotEmpty) {
          _num1 = double.parse(_currentNumber);
          _operator = buttonText;
          _currentNumber = "";
        }
      } else if (buttonText == "=") {
        if (_currentNumber.isNotEmpty && _operator.isNotEmpty) {
          double num2 = double.parse(_currentNumber);
          if (_operator == "+") {
            _output = (_num1 + num2).toString();
          }
          if (_operator == "-") {
            _output = (_num1 - num2).toString();
          }
          if (_operator == "*") {
            _output = (_num1 * num2).toString();
          }
          if (_operator == "/") {
            _output = (_num1 / num2).toString();
          }
          _num1 = 0;
          _operator = "";
          _currentNumber = _output;
        }
      } else {
        _currentNumber = _currentNumber + buttonText;
        _output = _currentNumber;
      }
    });
  }

  Widget _buildButton(String buttonText, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[300],
            padding: const EdgeInsets.all(24.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("C", color: Colors.red),
                  _buildButton("DEL", color: Colors.orange),
                  _buildButton("√", color: Colors.orange),
                  _buildButton("/", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("*", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("+", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("."),
                  _buildButton("0"),
                  _buildButton("00"),
                  _buildButton("=", color: Colors.green),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
