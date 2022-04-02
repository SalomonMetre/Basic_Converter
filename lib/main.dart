import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    ),
  );
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double _fromNumber=0, _convertedNumber=0;
  String _fromUnit='meters', _toUnit='meters';
  final _units = <String>[
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];
  final formulas = <int, List>{
    0: [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    1: [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    2: [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    3: [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    4: [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    5: [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    6: [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    7: [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  void convert() {
    final fromIndex = _units.indexOf(_fromUnit);
    final toIndex = _units.indexOf(_toUnit);
    final formula = formulas[fromIndex]?[toIndex];
    setState(() {
      _convertedNumber = _fromNumber*formula;
    });
  }

  void updateFromNumber(String input) {
    setState(() {
      _fromNumber = double.parse(input);
    });
  }

  void selectFromUnit(value) {
    setState(() {
      _fromUnit = value;
    });
  }

  void selectToUnit(value) {
    setState(() {
      _toUnit = value;
    });
  }

  @override
  void initState() {
    _fromNumber = 0;
    _convertedNumber = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  textInputAction: TextInputAction.done,
                  onChanged: updateFromNumber,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Value to Convert',
                    hintText: 'Enter the value : ',
                  ),
                ),
                DropdownButton(
                  value: _fromUnit,
                  onChanged: selectFromUnit,
                  items: _units
                      .map((value) =>
                          DropdownMenuItem(child: Text(value), value: value))
                      .toList(),
                ),
                DropdownButton(
                  value: _toUnit,
                  onChanged: selectToUnit,
                  items: _units
                      .map((value) =>
                          DropdownMenuItem(child: Text(value), value: value))
                      .toList(),
                ),
                Card(
                    color: Colors.lightBlue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(
                        '$_fromNumber $_fromUnit = $_convertedNumber $_toUnit',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                TextButton.icon(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue.shade900),
                  ),
                  onPressed: convert,
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Convert'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
