import 'package:project/src/models/currencies.dart';
import "dart:convert";
import "package:http/http.dart" as http;

class ApiController {
  Currencies? selectedCurrencyFrom;
  Currencies? selectedCurrencyTo;

  Future<List<Currencies>> getCurrencies() async {
    //Fazendo a chamada da API com a lista de moedas existentes
    const request = "https://api.frankfurter.app/currencies";
    final response = await http.get(Uri.parse(request));
    //Caso a chamada da API funcione
    if (response.statusCode == 200) {
      //Decodificando o json
      final currencies = json.decode(response.body);
      //Criando uma lista de Currencies para receber o conteído do json
      List<Currencies> listCurrencies = [];
      //Passando os dois elementos de cada moeda disponível para a Lista de Currencies
      currencies.forEach((key, value) {
        listCurrencies.add(Currencies(code: key, name: value));
      });
      //Retornando a Lista de Currencies
      return listCurrencies;
    } else {
      //Caso não seja possível fazer o acesso é lançado uma exceção
      throw Exception("Houve um erro ao carregar os dados");
    }
  }

  Future<double> exchange(String from, String to, String amount) async {
    //Fazendo a chamada da API para fazer a conversão passando os valores interpolados na Url
    final request =
        "http://api.frankfurter.app/latest?from=$from&to=$to&amount=$amount";
    final response = await http.get(Uri.parse(request));
    //Decodificando o json
    final body = jsonDecode(response.body);
    //Pegando o valor já convertido, acessando por meio do nome da variável que vai ser convertido, visto que só existe um único índice no retorno do campo rates
    var valor = body['rates'][to];
    //Retornando o valor do campo rates como String
    return valor as double;
  }
}
