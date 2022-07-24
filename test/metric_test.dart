import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:risk_assessment/main.dart';
import 'package:risk_assessment/riskCalculator.dart';

void main() {
  test('metric risk is default', () {
    Metric metric = Metric();
    expect(metric.getRisk(), 1.0);
  });

  test('metric risk is <1/3', () {
    Metric metric = Metric();
    metric.setLowRisk(1);
    metric.setNoRisk(2);
    metric.calcRisk();

    expect(metric.getRisk(), (1 / 3) / 3);
  });
  test('1/3 < risk < 2/3', () {
    Metric metric = Metric();
    metric.setLowRisk(2);
    metric.setNoRisk(1);
    metric.calcRisk();
    expect(metric.getRisk(), (2 / 3) / 3);
  });
  test('2/3 < risk < 1', () {
    Metric metric = Metric();
    metric.setMedRisk(2);
    metric.setNoRisk(1);
    metric.calcRisk();
    expect(metric.getRisk(), (4 / 3) / 3);
  });
}
