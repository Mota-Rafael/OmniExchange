import 'package:flutter/material.dart';
import 'package:project/src/models/api_model.dart';
import 'package:project/src/models/currencies.dart';

class CurrencyMenu extends StatefulWidget {
  final String type;
  final ApiController controller;
  //Criando o construtor de CurrencyMenu
  const CurrencyMenu({
    required this.type,
    required this.controller,
    super.key,
  });

  @override
  State<CurrencyMenu> createState() => _CurrencyMenuState();
}

class _CurrencyMenuState extends State<CurrencyMenu> {
  //Iniciando o controller
  @override
  void initState() {
    currencies = widget.controller.getCurrencies();
    super.initState();
  }

  //Criando a lista futura que irá receber a lista de Currencies
  late Future<List<Currencies>> currencies;

  @override
  build(BuildContext context) {
    //Criando uma variável para determinar a largura do dispositivo
    final totalWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      //Determinando o tamanho lateral do dispositivo de acordo com a largura disponível
      width: (0.85 * totalWidth),
      //Utilizando o FutureBuilder para Receber os dados da API e desenhar na tela
      child: FutureBuilder(
        future: currencies,
        builder: ((context, snapshot) {
          //Verificando o estado da conexão
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return DropdownButtonFormField<Currencies>(
              //Estilizando o DropDown
              isExpanded: true,
              icon: const Icon(Icons.attach_money),
              hint: const Text("Escolha a moeda desejada"),
              decoration: InputDecoration(
                label: Text(widget.type),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onChanged: (value) {
                //Atribuindo valor da variável de acordo com qual DropDown ele estiver
                if (widget.type == "De") {
                  widget.controller.selectedCurrencyFrom = value;
                } else {
                  widget.controller.selectedCurrencyTo = value;
                }
              },
              //Verificando em qual das instâncias da entrada de Moeda ele está
              value: widget.type == "De"
                  ? widget.controller.selectedCurrencyFrom
                  : widget.controller.selectedCurrencyTo,
              //Reproduzindo a lista de opções de Moedas
              items: snapshot.data
                  ?.map((currency) => DropdownMenuItem(
                        value: currency,
                        child: Text(currency.name),
                      ))
                  .toList(),
            );
          } else {
            return const Center(child: Text("Erro ao carregar os dados"));
          }
        }),
      ),
    );
  }
}
