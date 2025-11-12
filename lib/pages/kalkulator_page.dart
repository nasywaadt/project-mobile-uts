import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  // ===== Color palette (same as KontakPage) =====
  final Color primaryBrown = const Color(0xFF6B4F4F);
  final Color lightBrown = const Color(0xFFF8EDE3);
  final Color accentBrown = const Color(0xFFDCC7AA);

  // ===== Calculator state =====
  String _display = '0';
  String _expression = '';
  String _currentNumber = '';
  String _operator = '';
  double _firstOperand = 0;
  bool _shouldResetDisplay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrown,
      appBar: AppBar(
        backgroundColor: primaryBrown,
        title: Text(
          "Kalkulator",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display area
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Expression text
                    Text(
                      _expression,
                      style: TextStyle(
                        fontSize: 20,
                        color: primaryBrown.withOpacity(0.5),
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    // Main display
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _display,
                        style: TextStyle(
                          fontSize: 64,
                          color: primaryBrown,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons area
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Row 1: %, √, x², ¹/x
                    _buildButtonRow([
                      _CalcButton(
                        text: '%',
                        onTap: () => _onOperatorPressed('%'),
                        backgroundColor: accentBrown.withOpacity(0.3),
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '√',
                        onTap: () => _onFunctionPressed('√'),
                        backgroundColor: accentBrown.withOpacity(0.3),
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: 'x²',
                        onTap: () => _onFunctionPressed('x²'),
                        backgroundColor: accentBrown.withOpacity(0.3),
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '¹/x',
                        onTap: () => _onFunctionPressed('¹/x'),
                        backgroundColor: accentBrown.withOpacity(0.3),
                        textColor: primaryBrown,
                      ),
                    ]),

                    // Row 2: CE, C, ⌫, ÷
                    _buildButtonRow([
                      _CalcButton(
                        text: 'CE',
                        onTap: _onClearEntry,
                        backgroundColor: accentBrown.withOpacity(0.3),
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: 'C',
                        onTap: _onClear,
                        backgroundColor: accentBrown.withOpacity(0.3),
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '⌫',
                        onTap: _onBackspace,
                        backgroundColor: accentBrown.withOpacity(0.3),
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '÷',
                        onTap: () => _onOperatorPressed('÷'),
                        backgroundColor: accentBrown,
                        textColor: Colors.white,
                      ),
                    ]),

                    // Row 3: 7, 8, 9, ×
                    _buildButtonRow([
                      _CalcButton(
                        text: '7',
                        onTap: () => _onNumberPressed('7'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '8',
                        onTap: () => _onNumberPressed('8'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '9',
                        onTap: () => _onNumberPressed('9'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '×',
                        onTap: () => _onOperatorPressed('×'),
                        backgroundColor: accentBrown,
                        textColor: Colors.white,
                      ),
                    ]),

                    // Row 4: 4, 5, 6, -
                    _buildButtonRow([
                      _CalcButton(
                        text: '4',
                        onTap: () => _onNumberPressed('4'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '5',
                        onTap: () => _onNumberPressed('5'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '6',
                        onTap: () => _onNumberPressed('6'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '-',
                        onTap: () => _onOperatorPressed('-'),
                        backgroundColor: accentBrown,
                        textColor: Colors.white,
                      ),
                    ]),

                    // Row 5: 1, 2, 3, +
                    _buildButtonRow([
                      _CalcButton(
                        text: '1',
                        onTap: () => _onNumberPressed('1'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '2',
                        onTap: () => _onNumberPressed('2'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '3',
                        onTap: () => _onNumberPressed('3'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '+',
                        onTap: () => _onOperatorPressed('+'),
                        backgroundColor: accentBrown,
                        textColor: Colors.white,
                      ),
                    ]),

                    // Row 6: ±, 0, ., =
                    _buildButtonRow([
                      _CalcButton(
                        text: '±',
                        onTap: _onToggleSign,
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '0',
                        onTap: () => _onNumberPressed('0'),
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '.',
                        onTap: _onDecimalPressed,
                        backgroundColor: Colors.white,
                        textColor: primaryBrown,
                      ),
                      _CalcButton(
                        text: '=',
                        onTap: _onEquals,
                        backgroundColor: primaryBrown,
                        textColor: Colors.white,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<_CalcButton> buttons) {
    return Expanded(
      child: Row(
        children: buttons.map((button) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: button,
            ),
          );
        }).toList(),
      ),
    );
  }

  // ===== Calculator Logic =====

  void _onNumberPressed(String number) {
    setState(() {
      if (_shouldResetDisplay) {
        _currentNumber = number;
        _display = number;
        _shouldResetDisplay = false;
      } else {
        if (_display == '0') {
          _currentNumber = number;
          _display = number;
        } else {
          _currentNumber += number;
          _display = _currentNumber;
        }
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (_shouldResetDisplay) {
        _currentNumber = '0.';
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_currentNumber.contains('.')) {
        if (_currentNumber.isEmpty) {
          _currentNumber = '0.';
        } else {
          _currentNumber += '.';
        }
        _display = _currentNumber;
      }
    });
  }

  void _onOperatorPressed(String op) {
    if (_currentNumber.isNotEmpty) {
      if (_operator.isNotEmpty) {
        _calculateResult();
      } else {
        _firstOperand = double.parse(_currentNumber);
      }
    }

    setState(() {
      _operator = op;
      _expression = '${_formatNumber(_firstOperand)} $op';
      _shouldResetDisplay = true;
      _currentNumber = '';
    });
  }

  void _onEquals() {
    if (_operator.isEmpty || _currentNumber.isEmpty) return;

    _calculateResult();
    
    setState(() {
      _expression = '';
      _operator = '';
      _currentNumber = _display;
      _shouldResetDisplay = true;
    });
  }

  void _calculateResult() {
    if (_currentNumber.isEmpty) return;

    double secondOperand = double.parse(_currentNumber);
    double result = 0;

    switch (_operator) {
      case '+':
        result = _firstOperand + secondOperand;
        break;
      case '-':
        result = _firstOperand - secondOperand;
        break;
      case '×':
        result = _firstOperand * secondOperand;
        break;
      case '÷':
        if (secondOperand != 0) {
          result = _firstOperand / secondOperand;
        } else {
          setState(() {
            _display = 'Error';
            _expression = 'Cannot divide by zero';
          });
          return;
        }
        break;
      case '%':
        result = _firstOperand % secondOperand;
        break;
    }

    setState(() {
      _firstOperand = result;
      _display = _formatNumber(result);
    });
  }

  void _onFunctionPressed(String function) {
    if (_currentNumber.isEmpty && _display != '0') {
      _currentNumber = _display;
    }
    
    if (_currentNumber.isEmpty) return;

    double value = double.parse(_currentNumber);
    double result = 0;

    switch (function) {
      case '√':
        if (value >= 0) {
          result = math.sqrt(value);
        } else {
          setState(() {
            _display = 'Error';
            _expression = 'Invalid input';
          });
          return;
        }
        break;
      case 'x²':
        result = value * value;
        break;
      case '¹/x':
        if (value != 0) {
          result = 1 / value;
        } else {
          setState(() {
            _display = 'Error';
            _expression = 'Cannot divide by zero';
          });
          return;
        }
        break;
    }

    setState(() {
      _display = _formatNumber(result);
      _currentNumber = _display;
      _expression = '$function($value)';
      _shouldResetDisplay = true;
    });
  }

  void _onToggleSign() {
    if (_currentNumber.isEmpty) return;

    setState(() {
      double value = double.parse(_currentNumber);
      value = -value;
      _currentNumber = value.toString();
      _display = _formatNumber(value);
    });
  }

  void _onClear() {
    setState(() {
      _display = '0';
      _expression = '';
      _currentNumber = '';
      _operator = '';
      _firstOperand = 0;
      _shouldResetDisplay = false;
    });
  }

  void _onClearEntry() {
    setState(() {
      _display = '0';
      _currentNumber = '';
      _shouldResetDisplay = false;
    });
  }

  void _onBackspace() {
    if (_currentNumber.isEmpty || _shouldResetDisplay) return;

    setState(() {
      if (_currentNumber.length == 1) {
        _currentNumber = '';
        _display = '0';
      } else {
        _currentNumber = _currentNumber.substring(0, _currentNumber.length - 1);
        _display = _currentNumber;
      }
    });
  }

  String _formatNumber(double number) {
    if (number == number.toInt()) {
      return number.toInt().toString();
    } else {
      String str = number.toStringAsFixed(10);
      str = str.replaceAll(RegExp(r'0+$'), '');
      str = str.replaceAll(RegExp(r'\.$'), '');
      return str;
    }
  }
}

// ===== Custom Calculator Button Widget =====
class _CalcButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  const _CalcButton({
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: text.length > 2 ? 18 : 24,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}