import 'package:flutter/material.dart';
// aplicar no terminal: flutter pub add shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Calculadora(),
      ),
    ),
  );
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final TextEditingController _controlaX = TextEditingController();
  final TextEditingController _controlaY = TextEditingController();
  int resultado = 0;
  int counterX = 0;
  int counterY = 0;

  @override
  void initState() {
    super.initState();
    carrega();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controlaX,
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: _controlaY,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: soma,
          child: const Text('Soma'),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          'Resultado: $resultado',
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: salva, child: const Text('Salva')),
            // ElevatedButton(onPressed: carrega, child: const Text('Carrega')),
            ElevatedButton(onPressed: limpa, child: const Text('Limpa')),
          ],
        ),
      ],
    );
  }

  void soma() {
    int _x = int.parse(_controlaX.text);
    int _y = int.parse(_controlaY.text);

    setState(() {
      resultado = _x + _y;
    });
  }

  void salva() async {
    // Load and obtain the shared preferences for this app.

    final prefs = await SharedPreferences.getInstance();

    // Save the counter value to persistent storage under the 'counter' key.
    await prefs.setInt('valX', int.parse(_controlaX.text));
    await prefs.setInt('valY', int.parse(_controlaY.text));
  }

  void limpa() async {
    final prefs = await SharedPreferences.getInstance();

    // Remove the counter key-value pair from persistent storage.
    await prefs.remove('valX');
    await prefs.remove('valY');
  }

  void carrega() async {
    final prefs = await SharedPreferences.getInstance();
    counterX = 0;
    counterY = 0;

// Try reading the counter value from persistent storage.
// If not present, null is returned, so default to 0.
    // final counter = prefs.getInt('counter') ?? 0;
    // counter já foi declarado como variável "global" por isso não a declaro aqui
    counterX = prefs.getInt('valX') ?? 0;
    counterY = prefs.getInt('valY') ?? 0;
    setState(() {
      resultado = 0;
      _controlaX.text = counterX.toString();
      _controlaY.text = counterY.toString();
    });
  }
}
