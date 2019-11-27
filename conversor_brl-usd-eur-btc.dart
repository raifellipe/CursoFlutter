import 'package:flutter/material.dart';

//Lembrar de importar esse package
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const requestApi = "https://api.hgbrasil.com/finance";

void main() {
  runApp(MyApp());
}

//função de acesso a API, sempre async para usar uma requisição 
Future<Map> getData() async {
  //await para esperar a requisição ser completa
  http.Response response = await http.get(requestApi);

  //basicamente um parser json para map
  return json.decode(response.body);
}

//stfull
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double dollar;
  double euro;
  double btc;

  //Controladores dos TextEdits
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();
  final btcController = TextEditingController();

  //função para atualizar os valores das moedas
  void atualizaValor() async {
    http.Response response = await http.get(requestApi);
    dollar = json.decode(response.body)["results"]["currencies"]["USD"]["buy"];
    euro = json.decode(response.body)["results"]["currencies"]["EUR"]["buy"];
    btc = json.decode(response.body)["results"]["currencies"]["BTC"]["buy"];
  }

  //função executada a cada mudança no texto (after text changed)
  void _realChanged(String Text) {
    if (Text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(Text);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    btcController.text = (real / btc).toStringAsFixed(3);
  }

  //função executada a cada mudança no texto (after text changed)
  void _dollarChanged(String Text) {
    if (Text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(Text) * dollar;
    realController.text = real.toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    btcController.text = (real / btc).toStringAsFixed(3);
  }
  
  //função executada a cada mudança no texto (after text changed)
  void _euroChanged(String Text) {
    if (Text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(Text) * euro;
    realController.text = real.toStringAsFixed(2);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    btcController.text = (real / btc).toStringAsFixed(3);
  }

  //função executada a cada mudança no texto (after text changed)
  void _btcChanged(String Text) {
    if (Text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(Text) * btc;
    realController.text = real.toStringAsFixed(2);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  //função que limpa os campos
  void _clearAll() {
    realController.text = "";
    dollarController.text = "";
    euroController.text = "";
    btcController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          hintColor: Colors.blueAccent,
          primaryColor: Colors.white,
          //precisa para estilizar a borda
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ))),
      home: Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          title: Text(
            "Conversor",
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: atualizaValor,
              color: Colors.white,
            )
          ],
        ),

        // o FutureBuilder recebe uma função async e aguarda monta a tela de acordo com o resultado dela.
        body: FutureBuilder<Map>(
          //future: é a função q o builder depende
          future: getData(),
          builder: (context, snapshot) {
            //usa um switch case para tratar todas as possibilidades
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text(
                  "Carregando Dados...",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Erro ao carregar :/",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                } else {
                  dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  btc = snapshot.data["results"]["currencies"]["BTC"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    //layout linear horizontal
                    child: Column(
                      //CrossAxisAlignment.stretch ajusta tudo ao centro
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.monetization_on,
                          size: 150.0,
                          color: Colors.amber,
                        ),
                        //função que retorna uma build de TextField
                        buildTextField(
                            "Real", "R\$", realController, _realChanged),
                        //Divider da um espaço entre os componentes
                        Divider(),
                        buildTextField(
                            "Dollar", "U\$", dollarController, _dollarChanged),
                        Divider(),
                        buildTextField(
                            "Euro", "EUR", euroController, _euroChanged),
                        Divider(),
                        buildTextField(
                            "BitCoin", "BTC", btcController, _btcChanged)
                      ],
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}


Widget buildTextField(
    String label, String prefix, TextEditingController ctlr, Function f) {
  return TextField(
    controller: ctlr,
    //tipo de TextImputType para habilitar decimal no ios
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    //seleciona a função para o onchange
    onChanged: f,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueAccent),
        border: OutlineInputBorder(),
        prefixText: prefix + " "),
    style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
  );
}
