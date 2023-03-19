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
  "reference_text": "wrod - text editor\nCTRL+A - select all text.\nCTRL+X - cut selected text.\nCTRL+C - copy selected text.\nCTRL+V - paste selected text.",
  "about_program_text": "Text editor (Laboratory work No. 1)\nVersion 1.0\n© 2023 \"Left wand Twix\" - a team of students of group 4AMCS-PT FSBEI HE \"MASU\"\nCross-platform application developed within the discipline \"Fundamentals of cross-platform application development\""
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
  "about_program": "О программе"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
