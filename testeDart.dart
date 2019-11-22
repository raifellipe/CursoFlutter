
/*
Arquivo de resumo da linguagem e testes de funcionamento.
*/


class Pessoa{

  //por convenção o _ antes é variavel privada
  String _nome;
  int idade;
  double altura;
  
  Pessoa(this._nome, this.idade, this.altura);
  /*
    O construtor Pessoa(this.nome, this.idade, this.altura); é igual a
    
    Pessoa(String nome, String idade, String altura){
      this.nome = nome;
      this.idade = idade;
      this.altura = altura;
    }
    
   * */
  
  //Construtor com nome
  Pessoa.nascer(this._nome, this.altura){
    idade = 0;
  }
  
  //get
  String get nome => _nome;
  
  //set
  set nome (String nome){
    _nome = nome;
  }
 
}

 class InfosPessoa {
  
  int idade;
  
    InfosPessoa(this.idade);
  }

class Animal{
  
  String nome;
  int idade;
  
  void comer(){
    
    print("O $nome Comeu");
    
  }
  
  Animal(this.nome, this.idade);
  
}

class Cachorro extends Animal{
  
  String raca;
  
  void latir(){
    print(this.nome + " latiu!");
  }
  
  //super para chamar o construtor da pai
  Cachorro(String nome, int idade, this.raca) : super(nome, idade);
  
  
  //tag para sobrescrita de metodo;
  @override
  void comer(){
    print(this.nome + " Comeu, mas deitado"); 
  }
  
}

class Gato extends Animal{
  
  String raca;
  
  /* parece que não aceita sobrecarga!
   void miar(){
    print(this.nome + " miou!"); 
  }  
   */
  
  void miar(String a){
    print(this.nome + " disse: " +a); 
  }
  
  Gato(String nome, int idade, this. raca) : super(nome, idade);
  
}

//Static é uma variavel da classe, pode ser acessada sem instanciar um objeto;
class Valores{

  static double pi = 3.14;

}

main() {
  
  String str;
  int inteiro;
  double doub;
  bool boo;
  var varia; // assume qualquer variável, mas depois da primeira declaração ela     fica com aquele tipo.
  dynamic dinamico; // assume qualquer variável. 
  dinamico  = "Hello World";
  print("Teste 1: $dinamico");
  dinamico = 2;
  print ("\nTeste $dinamico");
   
  String info1;
  String info2 = info1 ?? "Nulo"; // Se null então condição, info2 é nulo? se     true = a string "Nulo"
  
  print("\nTeste 3: "+info2);
  info1 = "Não nulo";
  info2 = info1 ?? "Nulo";
  print ("\nTeste 4: " + info2);
  
  print ("\nTeste 5: " + area(10).toString()); 
  
  //Funções com parametros opcionais devem ser acessadas pelo nome do parametro: valor, os parametros não opcionais tem que estar sempre presentes
  print ("\nTeste 6: ");
  imprime("Rai");
  print ("\nTeste 7: ");
  imprime("Rai",b:"Fellipe");
  print ("\nTeste 8: ");
  imprime("Rai",c:"Borges");
  print ("\nTeste 9: ");
  imprime("Rai",c:"Borges", b:"Fellipe");
  
  //chamada de função anonimas
  funcChamado("\nTeste 10: ", (){print("Função anonima");});
  String s = "Teste";
  funcChamado2("\nTeste 11: ", (String s){print(s);});
  funcChamadoRetorno("\nTeste 12: ", ()=>"Teste arrow");
  
  
  //chamada de função com função no parametro
  funcChamado("\nTeste 13: ", test);
  funcChamado2("\nTeste 14: ", test2);
  
  Pessoa pessoa = new Pessoa("Rai", 23, 1.86);
  print ("\nTeste 15: " + pessoa.nome);
  
  Pessoa nova = new Pessoa.nascer("João", 0.40);
  print ("\nTeste 16: \nO "+ nova.nome +" tem "+nova.idade.toString() +    " anos");
  
  pessoa.nome = "Raito";
  print ("\nTeste 17: " + pessoa.nome);
  
  Cachorro gato = new Cachorro("Gato", 120, "Husky");
  print ("\nTeste 18: ");
  gato.comer();
  gato.latir();
  
  print ("\nTeste 19: ");
  Gato cachorro = new Gato("Cachorro", 120, "Siames");
  //cachorro.miar(); não aceita sobrecarga
  cachorro.miar("Miau!");
  cachorro.comer();

  //chamada de uma variável de classe estatica;
  print("\nTeste 20: Pi = " + Valores.pi.toString());
  
  /*
   * Const é uma variavel que não muda seu valor nunca, e é definida em tempo de compilação;
   * Final é uma variavel que não muda valor, mas é definida em tempo de execução;
   */
  
  print ("\nTeste 21: ");
  List<String> nomes = ["Rai", "João", "Maria"];
  print(nomes);
  //add na lista
  nomes.add("José");
  print(nomes);
  //remove na posição
  nomes.removeAt(2);
  print(nomes);
  //insere na posição
  nomes.insert(1, "Mateus");
  print(nomes);
  //retorna o tamanho
  print(nomes.length);
  //retorna na posição
  print(nomes[2]);
  //busca na lista
  print(nomes.contains("Rai"));
  int cont = 0;
  //for que passa por todos os elementos na lista
  for(String s in nomes){
    cont++;
    print(s + " " +cont.toString());
   }
  
  print ("\nTeste 22: ");
  Map<String, InfosPessoa> _pessoas = Map(); 
  //Instancia de map com objeto;
	_pessoas["João"] = InfosPessoa(30);
  _pessoas["Marcelo"] = InfosPessoa(20);
  
  //acesso ao value pela key
  print(_pessoas["João"].idade);
  //imprime todas as chaves
  print(_pessoas.keys);
  //remove do map de acordo com a key
  _pessoas.remove("João");
  print(_pessoas.keys);
  //verifica se joão existe
  print(_pessoas.containsKey("João"));
  //add outro
  _pessoas["Rai"] = InfosPessoa(23);
  print(_pessoas.keys);
  
  print ("\nTeste 23: ");
  Map<int, String> ddds = Map();
  ddds[11] = "São Paulo";
  ddds[19] = "Campinas";
  ddds[13] = "Não sei";
  print(ddds);
  //pra alterar valor basta sobrescrever
  ddds[13] = "Lorena";
  print(ddds);

  
}
double area (double raio) => 3.14 * raio * raio; // => indica o retorno;

  void test(){
   print("Função não anonima"); 
  }

  void test2(String a){
    print(a);
  }

//Função com parametros opcionais (b e c)
  void imprime (String a, {String b, String c}){
   print(a);
   print(b ?? "sem valor");
   print(c ?? "sem valor");
}


  //função que passa outra função do parametro
  void funcChamado(String a, Function funcao){   
    print(a);
    funcao();
  }    

  void funcChamado2(String a, Function funcao){   
    print(a);
    funcao("Teste com parametro");
  }  

  void funcChamadoRetorno(String a, Function funcao){   
    print(a);
    String b = funcao();
    print(b);
  }    