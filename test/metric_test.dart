import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:risk_assessment/main.dart';
import 'package:risk_assessment/riskCalculator.dart';

void main() {
  test('metric risk is default', () {
    Metric metric = Metric();
    metric.calcRisk();
    expect(metric.getRisk(), 1.0);
  });
  test('metric risk returns to default', () {
    Metric metric = Metric();
    metric.setHighRisk(1);
    metric.setLowRisk(2);
    metric.calcRisk();
    metric.setLowRisk(0);
    metric.setHighRisk(0);
    metric.calcRisk();
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
  //Boundary Tests
  test('Green Boundary Respected', () {
    Metric metric = Metric();
    //below
    metric.setNoRisk(17);
    metric.setHighRisk(8);
    metric.calcRisk();
    expect(metric.getRisk(), 0.32);
    expect(metric.riskColourName, 'Green');
    //boundary
    metric.setNoRisk(2);
    metric.setHighRisk(1);
    metric.calcRisk();
    expect(metric.getRisk(), (1 / 3));
    expect(metric.riskColourName, 'Yellow');
    //above
    metric.setNoRisk(33);
    metric.setHighRisk(17);
    metric.calcRisk();
    expect(metric.getRisk(), 0.34);
    expect(metric.riskColourName, 'Yellow');
  });
  test('Yellow Boundary Respected', () {
    Metric metric = Metric();
    //below
    metric.setNoRisk(67);
    metric.setHighRisk(133);
    metric.calcRisk();
    expect(metric.getRisk(), (133 / 200));
    expect(metric.riskColourName, 'Yellow');
    //boundary
    metric.setNoRisk(1);
    metric.setHighRisk(2);
    metric.calcRisk();
    expect(metric.getRisk(), (2 / 3));
    expect(metric.riskColourName, 'Red');
    //above
    metric.setNoRisk(332);
    metric.setHighRisk(665);
    metric.calcRisk();
    expect(metric.getRisk(), (665 / 997));
    expect(metric.riskColourName, 'Red');
  });
  test('Red Boundary Respected', () {
    Metric metric = Metric();
    //below
    metric.setNoRisk(1);
    metric.setHighRisk(998);
    metric.calcRisk();
    expect(metric.getRisk(), (998 / 999));
    expect(metric.riskColourName, 'Red');
    //boundary
    metric.setNoRisk(0);
    metric.setHighRisk(1);
    metric.calcRisk();
    expect(metric.getRisk(), 1);
    expect(metric.riskColourName, 'Red');
    //above
    metric.setNoRisk(1);
    metric.setHighRisk(1000000);
    metric.calcRisk();
    assert(metric.getRisk() <= 1);
    expect(metric.riskColourName, 'Red');
  });
}
