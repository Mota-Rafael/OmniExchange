import 'package:flutter/material.dart';
import 'package:project/src/components/currency_entry.dart';
import 'package:project/src/components/currency_menu.dart';
import 'package:project/src/models/api_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double result = 0;
  String? amount;
  //Instânciando o controller da Api
  final ApiController controller = ApiController();

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: const Text(
        "Omni Exchange",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    //Determinando o tamnho da tela utilizando MediaQuery
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return SizedBox(
      //Definindo o tamanho
      height: totalHeight,
      width: totalWidth,
      child: Scaffold(
        backgroundColor: Colors.white,
        //Desenhando e estilizando a appBar
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Chamando o widget para fazer o TextField
              CurrencyEntry(
                onChanged: (String text) {
                  //Armazenando o valor para utilizar futuramente na conversão
                  amount = text;
                },
              ),
              //Chamando o widget do DropDownButton com as opções recebidas pela API
              CurrencyMenu(
                type: "De",
                controller: controller,
              ),
              const SizedBox(height: 20),
              //Chamando o widget do DropDownButton com as opções recebidas pela API
              CurrencyMenu(
                type: "Para",
                controller: controller,
              ),
              const SizedBox(height: 20),
              //Implementando o botão para fazer a conversão
              ElevatedButton(
                onPressed: () {
                  try {
                    //Tratando para que não ocorra nenhum valor nulo nos campos
                    if (controller.selectedCurrencyFrom == null ||
                        controller.selectedCurrencyTo == null ||
                        amount == null) {
                      throw "Selecione um valor válido";
                    }
                    //Fazendo a chamada da função que faz a conversão e armazenando o resultado, após saber que os valores não são nulos
                    controller
                        .exchange(controller.selectedCurrencyFrom!.code,
                            controller.selectedCurrencyTo!.code, amount!)
                        //Atualizando o estado do resultado
                        .then((value) => setState(
                              () {
                                result = value;
                              },
                            ))
                        .onError((error, stackTrace) => throw error ?? "erro");
                  } catch (error) {
                    //Abrir um popup na tela caso ocorra o erro
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(error.toString()),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"))
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text("Converter"),
              ),
              const SizedBox(height: 20),
              //Espaço para mostrar o resultado após a conversão
              SizedBox(
                width: (0.8 * totalWidth),
                child: Column(
                  children: [
                    //Estilizando o texto
                    const Text(
                      "Resultado",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    //Mostrando o resultado após a conversão
                    Text(result.toStringAsFixed(2)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
