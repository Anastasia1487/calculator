import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView Demo')),
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
              decoration: const InputDecoration(),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 0,
              shrinkWrap: true,
              children: [
                DialKey(
                  number: '%',
                ),
                DialKey(
                  number: 'x^2',
                ),
                DialKey(
                  number: 'sqrt(x)',
                ),
                DialKey(
                  number: '/',
                ),
                DialKey(
                  number: '7',
                ),
                DialKey(
                  number: '8',
                ),
                DialKey(
                  number: '9',
                ),
                DialKey(
                  number: '*',
                ),
                DialKey(
                  number: '4',
                ),
                DialKey(
                  number: '5',
                ),
                DialKey(
                  number: '6',
                ),
                DialKey(
                  number: '+',
                ),
                DialKey(
                  number: '1',
                ),
                DialKey(
                  number: '2',
                ),
                DialKey(
                  number: '3',
                ),
                DialKey(
                  number: '-',
                ),
                DialKey(
                  number: '+/-',
                ),
                DialKey(
                  number: '0',
                ),
                DialKey(
                  number: ',',
                ),
                DialKey(
                  number: '=',
                  onTap: () {},
                ),
              ],
            ),
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
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.all(4),
      child: FloatingActionButton(
        onPressed: onTap,
        backgroundColor: Colors.grey.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Text(
          number,
          style: const TextStyle(
              color: Colors.white,
              //fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
