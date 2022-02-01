import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Calcular IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool male = false;
  bool female = true;

  final cpeso = TextEditingController();
  final caltura = TextEditingController();

  double _peso = 0.0;
  double _altura = 0.0;
  String _imc = '';

  final _imcH =
      'IMC ideal\n19-24\n20-25\n20-25\n21-26\n22-27\n23-38\n24-29\n25-30';

  final _imcM =
      'IMC ideal\n19-24\n19-24\n19-24\n20-25\n21-26\n22-27\n23-28\n25-30';

  String _msj = '';

  void sexo() {
    _msj = male ? _imcH : _imcM;
  }

  void peso() {
    _peso = double.parse(cpeso.text.toString());
  }

  void altura() {
    _altura = double.parse(caltura.text.toString());
  }

  void imc() {
    _imc = (_peso / (_altura * _altura)).toStringAsFixed(3);
  }

  void inversion() => setState(
        () {
          female = !female;
          male = !male;
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  cpeso.clear();
                  caltura.clear();
                },
              );
            },
            icon: const Icon(Icons.delete_forever),
            color: Colors.white,
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Wrap(
          spacing: 20, // to apply margin in the main axis of the wrap
          runSpacing: 20,
          children: <Widget>[
            const Center(
              child: Text(
                'Ingrese sus datos para calcular el IMC',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.female),
                  iconSize: 60,
                  color: female ? Colors.pink : Colors.grey,
                  onPressed: () {
                    female ? null : inversion();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.male),
                  iconSize: 60,
                  color: male ? Colors.blue : Colors.grey,
                  onPressed: () {
                    male ? null : inversion();
                  },
                ),
              ],
            ),
            Expanded(
              child: TextField(
                controller: caltura,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  icon: const Icon(Icons.square_foot),
                  enabledBorder: const OutlineInputBorder(),
                  labelText: "Ingresar altura (M)",
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      width: 3,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: cpeso,
                keyboardType: TextInputType.number,
                obscureText: false,
                decoration: InputDecoration(
                  icon: const Icon(Icons.monitor_weight),
                  enabledBorder: const OutlineInputBorder(),
                  labelText: "Ingresar peso (KG)",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 3,
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                child: const Text('Calcular'),
                onPressed: () {
                  altura();
                  peso();
                  imc();
                  sexo();
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Tu IMC: $_imc'),
                      content: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          Text(male
                              ? "Tabla de IMC para hombres"
                              : "Tabla de IMC para mujeres"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                  'Edad\n16\n17\n18\n19-24\n25-34\n35-54\n55-64\n65-90'),
                              Text(_msj),
                              //   'IMC ideal\n19-24\n20-25\n20-25\n21-26\n22-27\n23-38\n24-29\n25-30'),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: const Text(
                              "Aceptar",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
