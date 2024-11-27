import 'package:flutter/material.dart';

void main() {
  runApp(PayrollCalculatorApp());
}

class PayrollCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payroll and Tax Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PayrollCalculatorPage(),
    );
    }
}

class PayrollCalculatorPage extends StatefulWidget {
  @override
  _PayrollCalculatorPageState createState() => _PayrollCalculatorPageState();
}

class _PayrollCalculatorPageState extends State<PayrollCalculatorPage> {
  final TextEditingController _hoursWorkedController = TextEditingController();
  final TextEditingController _hourlyRateController = TextEditingController();
  final TextEditingController _taxPercentageController = TextEditingController();
  String _result = "";

  void _calculatePayroll() {
    final double hoursWorked = double.tryParse(_hoursWorkedController.text) ?? 0.0;
    final double hourlyRate = double.tryParse(_hourlyRateController.text) ?? 0.0;
    final double taxPercentage = double.tryParse(_taxPercentageController.text) ?? 0.0;

    if (hoursWorked > 0 && hourlyRate > 0) {
      final double grossPay = hoursWorked * hourlyRate;
      final double taxAmount = grossPay * (taxPercentage / 100);
      final double netPay = grossPay - taxAmount;

      setState(() {
        _result =
        "Gross Pay: \$${grossPay.toStringAsFixed(2)}\nTax Amount: \$${taxAmount.toStringAsFixed(2)}\nNet Pay: \$${netPay.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        _result = "Please enter valid values.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payroll and Tax Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _hoursWorkedController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Hours Worked",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _hourlyRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Hourly Rate (\$)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _taxPercentageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tax Percentage (%)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculatePayroll,
              child: Text("Calculate"),
            ),
            SizedBox(height: 24),
            Text(
              _result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
