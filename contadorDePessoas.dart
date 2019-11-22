import 'package:flutter/material.dart';

/*

  1° app simples para contagem de pessoas.

*/

void main() {
  int cont = 0;
  runApp(MaterialApp(
      title: "Contador de Pessoas",
      home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int cont;
  String _texto = "Pode entrar!";

  _HomeState(){
    cont = 0;
  }

  void conta(int delta){
    setState(() {
        cont+=delta;

        if(cont<0)
          cont = 0;
        else if(cont>10)
          _texto = "Cheio!";
        else
          _texto = "Pode entrar!";

    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset("images/galaxia.jpg", fit:BoxFit.cover, height: 1000.0,),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Numero de Pessoas: $cont",
            style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 30.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "+1",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: (){
                  conta(1);
                },
                padding: EdgeInsets.all(10.0),
              ),
              FlatButton(
                child: Text(
                  "-1",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0),
                ),
                onPressed: () {
                  conta(-1);
                },
                padding: EdgeInsets.all(10.0),
              )
            ],
          ),
          Text(_texto,
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0))
        ],
      )
    ],);
  }
}
