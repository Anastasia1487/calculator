import 'package:calculator/generated/codegen_loader.g.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:window_manager/window_manager.dart';

double blockSize = 300;
double height = 500;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  if (!kIsWeb) {
    await windowManager.ensureInitialized();
    Size size = Size(blockSize + 16, height);
    windowManager.setSize(size);
    windowManager.setMaximumSize(size);
    windowManager.setMinimumSize(size);
  }

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ru'),
        assetLoader: const CodegenLoader(),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.teal, brightness: Brightness.dark),
      home: const GridCount(),
    );
  }
}

class GridCount extends StatefulWidget {
  const GridCount({super.key});

  @override
  State<GridCount> createState() => _GridCountState();
}

class _GridCountState extends State<GridCount> {
  final controller = TextEditingController();
  final focus = FocusNode();

  bool isExtended = false;

  double spacing = 4;

  String error = '';
  String base = 'Base';

  void toRadix(int i) {
    eval();
    final exp = RegExp(r'\d+');
    final number =
        exp.allMatches(controller.text).map((e) => e.group(0)).toList();
    final first = int.parse(number.first!);
    final second = int.parse(number.last!);
    base = 'Base$i ${first.toRadixString(i)}';
    setState(() {});
    print(second);
    print(first.toRadixString(i));
    print(second.toRadixString(i));
  }

  void eval() {
    try {
      controller.text = controller.text.interpret().toString();
      error = '';
    } catch (e) {
      error = 'Неверное выражение';
    }
    setState(() {});
    controller.selection = TextSelection(
      baseOffset: controller.text.length,
      extentOffset: controller.text.length,
    );
  }


  void factor() {
    String text = controller.text.substring(0, controller.selection.baseOffset);
    final exp = RegExp(r'\d*\.?\d+');
    final number = exp.allMatches(text).map((e) => e.group(0)).toList();
    print(number);
    double last = double.parse(number.last ?? '0');
    print(last);
    final ratio = factorial(last.toInt());
    int lasti = 0;
    try {
      lasti = int.parse(number.last ?? '0');
    } catch (e) {
      print(e);
    }
    print(ratio);
    print(text.length);
    final dop = lasti == last ? 2 : 0;

    text = text.substring(0, text.length - last.toString().length + dop) + ratio.toString();
    print(text);

    controller.text =
        text + controller.text.substring(controller.selection.baseOffset);
    controller.selection = TextSelection(
      baseOffset: text.length,
      extentOffset: text.length,
    );
    focus.requestFocus();
  }

  int factorial(int n) {
    if (n <= 0) {
      return 1;
    } else {
      return n * factorial(n - 1);
    }
  }

  void percent() {
    String text = controller.text.substring(0, controller.selection.baseOffset);
    final exp = RegExp(r'\d*\.?\d+');
    final number = exp.allMatches(text).map((e) => e.group(0)).toList();

    final preLast = number[number.length - 2];
    final percent = preLast != null ? double.parse(preLast) / 100 : 0.01;
    final last = double.parse(number.last ?? '0');
    int lasti = 0;
    try {
      lasti = int.parse(number.last ?? '0');
    } catch (e) {
      print(e);
    }
    final ratio = percent * last;
    print(last.toString());
    print(lasti.toString());
    final dop = lasti == last ? 2 : 0;
    print(lasti == last);
    text = text.substring(0, text.length - last.toString().length + dop) +
        ratio.toString();
    print(text);
    controller.text =
        text + controller.text.substring(controller.selection.baseOffset);
    controller.selection = TextSelection(
      baseOffset: text.length,
      extentOffset: text.length,
    );
    focus.requestFocus();
    print(number);
    print(last);
    print(preLast);
    print(ratio);
  }



  void addText(String text) {
    final offset = controller.selection.base.offset;
    offset >= 0
        ? controller.text = controller.text.substring(0, offset) +
            text +
            controller.text.substring(offset)
        : controller.text += text;

    controller.selection = TextSelection(
      baseOffset: offset + text.length,
      extentOffset: offset + text.length,
    );
    focus.requestFocus();
  }

  void focusOnBack() {
    final offset = controller.selection.base.offset;
    final length = controller.text.length;

    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: offset >= 0 ? offset - 1 : length - 1),
    );
    focus.requestFocus();
  }

  Future<void> setSize(double width) async {
    if (!kIsWeb) {
      final size = Size(width, height);
      windowManager.setMaximumSize(size);
      windowManager.setMinimumSize(size);
      windowManager.setSize(size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.calculator.tr()),
        actions: [
          TextButton(
            child: Text(context.locale == const Locale('ru') ? 'ru' : 'en'),
            onPressed: () {
              if (context.locale == const Locale('ru')) {
                context.setLocale(const Locale('en'));
              } else {
                context.setLocale(const Locale('ru'));
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Дополнительные возможности'),
            ),
            ExpansionTile(
              title: const Text('Режим'),
              children: [
                ListTile(
                  title: const Text('Базовый'),
                  textColor: !isExtended ? Colors.green : null,
                  onTap: () {
                    setState(() {
                      isExtended = false;
                      setSize(blockSize + 16);
                      Navigator.pop(context);
                    });
                  },
                ),
                ListTile(
                  title: const Text('Расширенный'),
                  textColor: isExtended ? Colors.green : null,
                  onTap: () {
                    setState(() {
                      isExtended = true;
                      setSize(blockSize * 2 + 16);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controller,
              focusNode: focus,
              autofocus: true,
              decoration: const InputDecoration(),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: isExtended,
                child: SizedBox(
                  width: blockSize,
                  child: Center(
                    child: Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: [
                        DialKey(
                          number: 'sin',
                          onTap: () {
                            addText('sin()');
                            focusOnBack();
                          },
                        ),
                        DialKey(
                          number: 'cos',
                          onTap: () {
                            addText('cos()');
                            focusOnBack();
                          },
                        ),
                        DialKey(
                          number: 'sinh',
                          onTap: () {
                            addText('sinh()');
                            focusOnBack();
                          },
                        ),
                        DialKey(
                          number: 'cosh',
                          onTap: () {
                            addText('cosh()');
                            focusOnBack();
                          },
                        ),
                        DialKey(
                          number: 'ln',
                          onTap: () {
                            addText('ln()');
                            focusOnBack();
                          },
                        ),
                        Base(
                          base: base,
                        ),
                        DialKey(
                          number: 'lg',
                          onTap: () {
                            addText('log(10,)');
                            focusOnBack();
                          },
                        ),
                        DialKey(
                          number: '2',
                          onTap: () => toRadix(2),
                        ),
                        DialKey(
                          number: '3',
                          onTap: () => toRadix(3),
                        ),
                        DialKey(
                          number: '4',
                          onTap: () => toRadix(4),
                        ),
                        DialKey(
                          number: 'abs',
                          onTap: () {
                            addText('abs()');
                            focusOnBack();
                          },
                        ),
                        DialKey(
                          number: '5',
                          onTap: () => toRadix(5),
                        ),
                        DialKey(
                          number: '6',
                          onTap: () => toRadix(6),
                        ),
                        DialKey(
                          number: '7',
                          onTap: () => toRadix(7),
                        ),
                        DialKey(
                          number: '!',
                          onTap: () {
                            factor();
                          },
                        ),
                        DialKey(
                          number: '8',
                          onTap: () => toRadix(8),
                        ),
                        DialKey(
                          number: '9',
                          onTap: () => toRadix(9),
                        ),
                        DialKey(
                          number: '10',
                          onTap: () => toRadix(10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: blockSize,
                child: Center(
                  child: Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: [
                      DialKey(
                        number: '%',
                        onTap: () {
                          percent();
                        },
                      ),
                      DialKey(
                        number: 'x²',
                        onTap: () {
                          addText('^(2)');
                        },
                      ),
                      DialKey(
                        number: '√',
                        onTap: () {
                          addText('sqrt()');
                          focusOnBack();
                        },
                      ),
                      DialKey(
                        number: '/',
                        onTap: () {
                          addText('/');
                        },
                      ),
                      DialKey(
                        number: '7',
                        onTap: () {
                          addText('7');
                        },
                      ),
                      DialKey(
                        number: '8',
                        onTap: () {
                          addText('8');
                        },
                      ),
                      DialKey(
                        number: '9',
                        onTap: () {
                          addText('9');
                        },
                      ),
                      DialKey(
                        number: '*',
                        onTap: () {
                          addText('*');
                        },
                      ),
                      DialKey(
                        number: '4',
                        onTap: () {
                          addText('4');
                        },
                      ),
                      DialKey(
                        number: '5',
                        onTap: () {
                          addText('5');
                        },
                      ),
                      DialKey(
                        number: '6',
                        onTap: () {
                          addText('6');
                        },
                      ),
                      DialKey(
                        number: '+',
                        onTap: () {
                          addText('+');
                        },
                      ),
                      DialKey(
                        number: '1',
                        onTap: () {
                          addText('1');
                        },
                      ),
                      DialKey(
                        number: '2',
                        onTap: () {
                          addText('2');
                        },
                      ),
                      DialKey(
                        number: '3',
                        onTap: () {
                          addText('3');
                        },
                      ),
                      DialKey(
                        number: '-',
                        onTap: () {
                          addText('-');
                        },
                      ),
                      DialKey(
                        number: '+/-',
                        onTap: () {
                          controller.text = '-(${controller.text})';
                          focus.requestFocus();
                        },
                      ),
                      DialKey(
                        number: '0',
                        onTap: () {
                          addText('0');
                        },
                      ),
                      const DialKey(
                        number: '.',
                      ),
                      DialKey(
                        number: '=',
                        onTap: () {
                          eval();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class Base extends StatelessWidget {
  const Base({
    Key? key,
    required this.base,
  }) : super(key: key);

  final String base;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 218,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white24,
      ),
      child: Center(
        child: Text(
          base,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DialKey extends StatelessWidget {
  final String number;
  final VoidCallback? onTap;

  const DialKey({
    super.key,
    required this.number,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white24,
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
