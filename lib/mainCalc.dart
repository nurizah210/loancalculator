// ignore_for_file: file_names

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainCalc());
}

class MainCalc extends StatefulWidget {
  const MainCalc({super.key});

  @override
  State<MainCalc> createState() => _MainCalc();
}

class _MainCalc extends State<MainCalc> {
  TextEditingController loanamount = TextEditingController();
  TextEditingController loanterm = TextEditingController();
  TextEditingController interestrate = TextEditingController();
  double valloanamount = 0.0,
      valinterestrate = 0,
      result = 0.0,
      numerator = 0.0,
      totalInterest = 0.0,
      totalpayment = 0.0;
  int months = 0, valloanterm = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(title: const Text("Loan Calculator")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Column(children: [
              const Text("Loan Amount "),
              TextField(
                controller: loanamount,
                decoration: InputDecoration(
                    prefix: const Text("RM"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular((9.0)))),
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              const SizedBox(
                height: 7,
              ),
              const Text("Loan Term "),
              TextField(
                controller: loanterm,
                decoration: InputDecoration(
                    suffix: const Text("Years"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular((9.0)))),
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              const SizedBox(
                height: 7,
              ),
              const Text("Interest Rate "),
              TextField(
                controller: interestrate,
                decoration: InputDecoration(
                    suffix: const Text("%"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular((9.0)))),
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result = calculateLoanPayment();
                        valloanterm = int.parse(loanterm.text);
                        months = calculateSec();
                        totalpayment = calculateThird();
                        totalInterest = calculateFourth();
                      });
                    },
                    child:
                        const Text("Calculate", style: TextStyle(fontSize: 15)),
                  ),
                  ElevatedButton(
                      onPressed: clear,
                      child:
                          const Text("Clear", style: TextStyle(fontSize: 15))),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(children: [
                    Text.rich(TextSpan(
                        text:
                            'Monthly Payment :  RM ${result.toStringAsFixed(2)}',
                        style: const TextStyle(
                            backgroundColor: Colors.orange,
                            fontSize: 20,
                            fontStyle: FontStyle.normal))),
                  ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 14),
                  child: Column(children: [
                    Text(
                        "You will need to pay RM ${result.toStringAsFixed(2)} every month for $valloanterm years to payoff the debt.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12)),
                    Text(
                        "Total Of $months Payments = RM ${totalpayment.toStringAsFixed(2)}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 12)),
                    Text(
                        "Total Interest = RM ${totalInterest.toStringAsFixed(2)}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 12)),
                  ]))
            ]),
          ),
        ),
      ),
    );
  }

  double calculateLoanPayment() {
    valloanamount = double.parse(loanamount.text);
    valinterestrate = double.parse(interestrate.text);
    valloanterm = int.parse(loanterm.text);
    double monthlyInterestRate = valinterestrate / 12 / 100;
    int months = valloanterm.toInt() * 12;
    double numerator = valloanamount *
        monthlyInterestRate *
        pow(1 + monthlyInterestRate, months);
    double denominator = pow(1 + monthlyInterestRate, months) - 1;
    return numerator / denominator;
  }

  int calculateSec() {
    valloanterm = int.parse(loanterm.text);
    int months = valloanterm.toInt() * 12;
    return months;
  }

  double calculateThird() {
    valloanamount = double.parse(loanamount.text);
    valloanterm = int.parse(loanterm.text);
    valinterestrate = double.parse(interestrate.text);
    int months = valloanterm.toInt() * 12;
    double monthlyInterestRate = valinterestrate / 12 / 100;
    double numerator = valloanamount *
        monthlyInterestRate *
        pow(1 + monthlyInterestRate, months);
    double denominator = pow(1 + monthlyInterestRate, months) - 1;
    double result = numerator / denominator;

    double totalpayment = result * months;
    return totalpayment;
  }

  double calculateFourth() {
    valinterestrate = double.parse(interestrate.text);
    valloanamount = double.parse(loanamount.text);
    int months = valloanterm.toInt() * 12;
    double monthlyInterestRate = valinterestrate / 12 / 100;
    double numerator = valloanamount *
        monthlyInterestRate *
        pow(1 + monthlyInterestRate, months);
    double denominator = pow(1 + monthlyInterestRate, months) - 1;
    double result = numerator / denominator;

    double totalpayment = result * months;
    double totalInterest = totalpayment - valloanamount;

    return totalInterest;
  }

  void clear() {
    setState(() {
      loanamount.clear();
      loanterm.clear();
      interestrate.clear();
      valloanterm = 0;
      result = 0.0;
      months = 0;
      totalpayment = 0.0;
      totalInterest = 0.0;
    });
  }
}
