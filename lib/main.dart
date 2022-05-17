// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final List<String> _measure = [
    'metros',
    'kilometros',
    'gramos',
    'kilogramos',
    'pies',
    'millas',
    'libras',
    'onzas',
  ];

  String _startM = "";
  String _endM = "";

  String endValue = "0";
  late int _startI;
  late int _endI;

  final _formulas = [
    [1, 0.001, 0, 0, 3.288084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.0001, 0, 0, 0.0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0.02835, 3.288084, 0, 0.0625, 1],
  ];

  final valueController = TextEditingController();

  @override
  void initState() {
    this._startI = 0;
    this._endI = 1;

    this._startM = this._measure[this._startI];
    this._endM = this._measure[this._endI];

    _formulas[0][1];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    //String? _startM = _measure[0];

    final labelStyle = TextStyle(color: Colors.blueGrey, fontSize: 20);
    final measureStyle = TextStyle(color: Colors.blue[700], fontSize: 20);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Medidor App 2",
          ),
        ),
        // ignore: avoid_unnecessary_containers
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
            child: Column(children: [
              //Text(_startM),
              //SizedBox(
              // height: 20,
              //),
              Text(
                "Valor",
                style: labelStyle,
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: valueController,
                decoration: InputDecoration(
                    hintText: "Valor Inicial",
                    contentPadding:
                        EdgeInsets.all(8)), //Funciona como placeholder
                onChanged: (value) {
                  // ignore: avoid_print
                  print(value);
                },
              ),
              SizedBox(
                height: 8,
              ),
              Text("De"),
              SizedBox(
                height: 8,
              ),
              DropdownButton(
                  isExpanded: true,
                  value: _startM,
                  items: _measure.map((m) {
                    return DropdownMenuItem(
                        value: m,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            m,
                            style: measureStyle,
                          ),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startM = value.toString();
                      _startI = _measure.indexOf(_startM);
                    });
                  }),
              SizedBox(
                height: 8,
              ),
              Text("Para"),
              SizedBox(
                height: 8,
              ),
              DropdownButton(
                  isExpanded: true,
                  value: _endM,
                  items: _measure.map((m) {
                    return DropdownMenuItem(
                        value: m,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            m,
                            style: measureStyle,
                          ),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _endM = value.toString();
                      _endI = _measure.indexOf(_endM);
                    });
                  }),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  try {
                    //Obtenemos el valor del usuario
                    // ignore: unused_local_variable
                    final value = double.parse(valueController
                        .text //en vez de var fijate de poner final
                        .trim()); //trim quita espacio en los extremos.
                    setState(() {
                      //aplicamos los calculos
                      this.endValue = "${value * _formulas[_startI][_endI]}";
                    });

                    //FocusScope.of(context).unfocus();
                    //Ocultar teclado
                    FocusScope.of(context).requestFocus(FocusNode());
                  } catch (e) {
                    // ignore: avoid_print
                    print("Problemas con la conversión");
                  }

                  // ignore: avoid_print
                  print(valueController.text);
                },
                child: Text("Convertir"),
              ),
              //Spacer(), //Tira todo para abajo
              Text(
                "res: $endValue",
                style: labelStyle,
              ),
              SizedBox(
                height: 8,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
