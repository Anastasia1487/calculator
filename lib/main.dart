import 'package:calculator/generated/codegen_loader.g.dart';
import 'package:calculator/generated/locale_keys.g.dart';
import 'package:calculator/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:function_tree/function_tree.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:window_manager/window_manager.dart';

import 'config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await windowManager.ensureInitialized();
  final temp = await windowManager.getSize();
  Size size = Size(416, temp.height);
  windowManager.setSize(size);
  windowManager.setMaximumSize(size);
  windowManager.setMinimumSize(size);

  runApp(
    ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ru')],
          path: 'assets/translations',
          // <-- change the path of the translation files
          fallbackLocale: const Locale('ru'),
          assetLoader: const CodegenLoader(),
          child: const MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Calculator',
      theme: ref.watch(themeProvider),
      themeMode: currentTheme.currentTheme,
      home: const GridCount(),
    );
  }
}

class GridCount extends ConsumerStatefulWidget {
  const GridCount({super.key});

  @override
  ConsumerState<GridCount> createState() => _GridCountState();
}

class _GridCountState extends ConsumerState<GridCount> {
  final controller = TextEditingController();
  final focus = FocusNode();

  bool isExtended = false;

  void eval() {
    controller.text = controller.text.interpret().toString();
  }

  void addText(String text) {
    controller.text += text;
  }

  void focusOnBack({int? value}) {
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length - (value ?? 1)),
    );
    focus.requestFocus();
  }

  void openHelp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondScreen()));
  }

  void openAbout() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ThirdScreen()));
  }
  Future<void> setSize(double width) async {
    final temp = await DesktopWindow.getWindowSize();
    final height = temp.height;
    final size = Size(width, height);
    windowManager.setMaximumSize(size);
    windowManager.setMinimumSize(size);
    windowManager.setSize(size);
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
            ExpansionTile(
              title: Text(LocaleKeys.mode.tr()),
              children: [
                ListTile(
                  title: Text(LocaleKeys.basic.tr()),
                  textColor: !isExtended ? Colors.green : null,
                  onTap: () {
                    setState(() {
                      isExtended = false;
                      setSize(416);
                    });
                  },
                ),
                ListTile(
                  title:Text(LocaleKeys.advanced.tr()),
                  textColor: isExtended ? Colors.green : null,
                  onTap: () {
                    setState(() {
                      isExtended = true;
                      setSize(816);
                    });
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(LocaleKeys.calculator.tr()),
              children: [
                ListTile(
                  title: Text(LocaleKeys.copy.tr()),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(LocaleKeys.paste.tr()),
                  onTap: () {},
                ),
              ],
            ),
            ExpansionTile(
              title: Text(LocaleKeys.design_theme.tr()),
              children: [
                ListTile(
                  title: Text(LocaleKeys.light_theme.tr()),
                  onTap: () => ref.read(themeProvider.notifier).setLight(),
                ),
                ListTile(
                  title: Text(LocaleKeys.dark_theme.tr()),
                  onTap: () =>  ref.read(themeProvider.notifier).setDark(),
                ),
                ListTile(
                  title: Text(LocaleKeys.children_theme.tr()),
                  onTap: () =>  ref.read(themeProvider.notifier).setWarm(),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(LocaleKeys.help.tr()),
              children: [
                ListTile(
                  title: Text(LocaleKeys.reference.tr()),
                  onTap: () => openHelp(),
                ),
                ListTile(
                  title: Text(LocaleKeys.about_program.tr()),
                  onTap: () => openAbout(),
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
                  width: 400,
                  child: Center(
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 0,
                      shrinkWrap: true,
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
                        DialKey(
                          number: '8',
                          onTap: () {
                            controller.text += '8';
                          },
                        ),
                        DialKey(
                          number: '9',
                          onTap: () {
                            controller.text += '9';
                          },
                        ),
                        DialKey(
                          number: '*',
                          onTap: () {
                            eval();
                            controller.text += '*';
                          },
                        ),
                        DialKey(
                          number: '4',
                          onTap: () {
                            controller.text += '4';
                          },
                        ),
                        DialKey(
                          number: '5',
                          onTap: () {
                            controller.text += '5';
                          },
                        ),
                        DialKey(
                          number: '6',
                          onTap: () {
                            controller.text += '6';
                          },
                        ),
                        DialKey(
                          number: '+',
                          onTap: () {
                            eval();
                            controller.text += '+';
                          },
                        ),
                        DialKey(
                          number: '1',
                          onTap: () {
                            controller.text += '1';
                          },
                        ),
                        DialKey(
                          number: '2',
                          onTap: () {
                            controller.text += '2';
                          },
                        ),
                        DialKey(
                          number: '3',
                          onTap: () {
                            controller.text += '3';
                          },
                        ),
                        DialKey(
                          number: '-',
                          onTap: () {
                            eval();
                            controller.text += '-';
                          },
                        ),
                        DialKey(
                          number: '+/-',
                          onTap: () {
                            controller.text += '0';
                          },
                        ),
                        DialKey(
                          number: '0',
                          onTap: () {
                            controller.text += '0';
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
              ),
              SizedBox(
                width: 400,
                child: Center(
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 0,
                    shrinkWrap: true,
                    children: [
                      DialKey(
                        number: '%',
                        onTap: () {
                          print(double.parse(controller.text));
                        },
                      ),
                      DialKey(
                        number: 'x^2',
                        onTap: () {
                          controller.text += '^()';
                          focusOnBack();
                        },
                      ),
                      DialKey(
                        number: 'sqrt(x)',
                        onTap: () {
                          controller.text += 'sqrt()';
                          focusOnBack();
                        },
                      ),
                      DialKey(
                        number: '/',
                        onTap: () {
                          eval();
                          controller.text += '/';
                        },
                      ),
                      DialKey(
                        number: '7',
                        onTap: () {
                          controller.text += '7';
                        },
                      ),
                      DialKey(
                        number: '8',
                        onTap: () {
                          controller.text += '8';
                        },
                      ),
                      DialKey(
                        number: '9',
                        onTap: () {
                          controller.text += '9';
                        },
                      ),
                      DialKey(
                        number: '*',
                        onTap: () {
                          eval();
                          controller.text += '*';
                        },
                      ),
                      DialKey(
                        number: '4',
                        onTap: () {
                          controller.text += '4';
                        },
                      ),
                      DialKey(
                        number: '5',
                        onTap: () {
                          controller.text += '5';
                        },
                      ),
                      DialKey(
                        number: '6',
                        onTap: () {
                          controller.text += '6';
                        },
                      ),
                      DialKey(
                        number: '+',
                        onTap: () {
                          eval();
                          controller.text += '+';
                        },
                      ),
                      DialKey(
                        number: '1',
                        onTap: () {
                          controller.text += '1';
                        },
                      ),
                      DialKey(
                        number: '2',
                        onTap: () {
                          controller.text += '2';
                        },
                      ),
                      DialKey(
                        number: '3',
                        onTap: () {
                          controller.text += '3';
                        },
                      ),
                      DialKey(
                        number: '-',
                        onTap: () {
                          eval();
                          controller.text += '-';
                        },
                      ),
                      DialKey(
                        number: '+/-',
                        onTap: () {
                          controller.text += '0';
                        },
                      ),
                      DialKey(
                        number: '0',
                        onTap: () {
                          controller.text += '0';
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 80,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white24,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.reference.tr())),
      body: Align(
          alignment: Alignment.topCenter,
          child: Text(LocaleKeys.reference_text.tr())
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.about_program.tr())),
      body: Align(
          alignment: Alignment.topCenter,
          child: Text(LocaleKeys.about_program_text.tr())
      ),
    );
  }
}
