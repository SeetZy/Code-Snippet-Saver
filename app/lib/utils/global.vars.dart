/*
  * Utility imports
 */
import 'package:flutter/material.dart';

class GlobalVariables {
  // Global color variables
  static const accentColor2 = Color(0xFF00cca3);
  static const accentColor3 = Color(0xFFff6666);

  static const primaryColor = Color(0xFF110e25);
  static const primaryColor2 = Color.fromARGB(255, 27, 22, 58);

  // Defines default code in the code editor
  static final List<String> defaultCode = [
    '# Example code',
    '',
    'class Car:',
    '\tdef __init__(self, make, model):',
    '\t\tself.make = make>',
    '\t\tself.model = model',
    '',
    '\tdef start(self):',
    '\t\tprint(f"{self.make} {self.model} is starting.")',
    '',
    'car = Car("Toyota", "Corolla")',
    'car.start()'
  ];
}
