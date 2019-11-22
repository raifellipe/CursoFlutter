import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey <FormState> _formKey = GlobalKey <FormState>(); //key do formulario, usada para verificar se os elementos foram validados
  String _texto = "Entre com os dados!";
  TextEditingController alturaControler = TextEditingController(); //variável de controle, recebe o valor do form.
  TextEditingController pesoControler = TextEditingController(); //variável de controle, recebe o valor do form.

  //função que reseta os formulários do app
  void _resetFields(){
    setState(() { //função que regarreca a tela ao mudar o estado
      _texto = "Entre com os dados!";
      _formKey = GlobalKey<FormState>(); // recria a chave para resetar a verificação dos formularios
    });
    alturaControler.text = "";
    pesoControler.text = "";
  }

  //função que é chamada para calcular o imc
  void calculaIMC() {
    setState(() {
        //passa o texto para double (parse) ao usar o metodo .toString() não foi possivel converter para double, então usar o .text
        var result = double.parse(pesoControler.text) / ((double.parse(alturaControler.text)/100) * (double.parse(alturaControler.text)/100));
        _texto = "Imc calculado + $result"; //seta o estado com o calculo do novo imc
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // widget que é usado para facilitar o uso de ferramentas do Material Design
      appBar: AppBar(
        title: Text("Calculadora Imc"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        actions: <Widget>[ // Usada para colocar botões na app bar
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields, //chamada a função de reset do app
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: Colors.white70,
      body:SingleChildScrollView( // scroll view serve para possibilitar o scroll da tela do app, mesmo com o teclado ativo (usado para telas grandes e forms longos)
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0), //Distancia o elemento da borda
        child: Form( //widget usado para possibilitar a validação
          key: _formKey,
          child: Column( // column é usado para uma disposição horizontal dos widgets (linear layout horizontal)
            crossAxisAlignment: CrossAxisAlignment.stretch, // Alonga os elementos para que preencham toda a largura
            children: <Widget>[
              Icon(Icons.person_outline, color: Colors.teal, size: 150.0),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: pesoControler,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.teal)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal, fontSize: 20),
                  validator: (value){   //função de validação, pode ser usada para validade de qualquer forma.
                    if(value.isEmpty)
                      return "Favor escolher um peso!";
                  },
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: alturaControler,
                  decoration: InputDecoration(
                      labelText: "Altura (Cm)",
                      labelStyle: TextStyle(color: Colors.teal)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.teal, fontSize: 20),
                validator: (value){
                  if(value.isEmpty)
                    return "Favor escolher uma altura!";

                },
              ),
              Padding( //widget para espaçar os itens
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container( // container usado para dar mais altura ao botão
                    height: 50.0,
                    child: RaisedButton(
                      child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                      onPressed: (){
                        if(_formKey.currentState.validate()) // verifica se o form está validado
                          calculaIMC();
                      },
                      color: Colors.teal,
                    )
                ),
              ),
              Text(_texto, textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0, color:Colors.teal),)
            ],
          ),
        ),
      ),
    );
  }
}
