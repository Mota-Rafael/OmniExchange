import 'package:flutter/material.dart';

class CurrencyEntry extends StatefulWidget {
  final Function(String) onChanged;
  const CurrencyEntry({required this.onChanged, super.key});

  @override
  State<CurrencyEntry> createState() => _CurrencyEntryState();
}

class _CurrencyEntryState extends State<CurrencyEntry> {
  late TextEditingController inputController;
  final text = '';

  //Inicializando o controller
  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      //Criando o TextField
      child: TextField(
        //Determinando a entrada no modo de somente números
        keyboardType: TextInputType.number,
        //Estlizando o TextField
        decoration: InputDecoration(
          labelText: "Digite o valor que deseja converter",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        controller: inputController,
        //Armazenando o valor caso o TextField receba algum input
        onChanged: (String value) {
          widget.onChanged(inputController.text);
        },
      ),
    );
  }
}
