// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "calculator": "Calculator",
  "copy": "Copy",
  "paste": "Paste",
  "mode": "Mode",
  "basic": "Basic",
  "advanced": "Advanced",
  "design_theme": "Design theme",
  "light_theme": "Light theme",
  "dark_theme": "Dark theme",
  "children_theme": "Children theme",
  "help": "Help",
  "reference": "Reference",
  "about_program": "About program",
  "reference_text": "Calculator - a tool for calculating basic and special functions.\n\nKeyboard shortcuts:\nCTRL+C - copy selected text.\nCTRL+V - paste selected text.",
  "about_program_text": "Calculator (Laboratory work No. 2)\nVersion 1.0\n\n© 2023 \"Left wand Twix\" - a team of students of group 4AMCS-PT FSBEI HE \"MASU\"\n\nCross-platform application developed within the discipline \"Fundamentals of cross-platform application development\""
};
static const Map<String,dynamic> ru = {
  "calculator": "Калькулятор",
  "copy": "Копировать",
  "paste": "Вставить",
  "mode": "Режим",
  "basic": "Базовый",
  "advanced": "Расширенный",
  "design_theme": "Темы оформления",
  "light_theme": "Светлая тема",
  "dark_theme": "Тёмная тема",
  "children_theme": "Детская тема",
  "help": "Справка",
  "reference": "Справка",
  "about_program": "О программе",
  "reference_text": "Калькулятор - инструмент для вычислений базовых и специальных функций.\n\nГоряие клавиши:\nCTRL+C - скопировать выделенный текст.\nCTRL+V - вставить выделенный текст.",
  "about_program_text": "Калькулятор (Лабораторная работа №2)\nВерсия 1.0\n\n© 2023 \"Левая палочка Твикс\" - команда студентов гуппы 4БПМИ-ПТ ФГБОУ ВО \"МАГУ\"\n\nКроссплатформенное приложение разработанное в рамках дисциплины \"Основы разработки кросс-платформенных приложений\""
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
