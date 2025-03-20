import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _imagemApp = AssetImage("images/padrao.png");
  var _resultadoFinal = "Boa sorte!!!";
  bool _isDarkMode = false; // Variável para alternar entre os modos

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];

    // Atualiza a imagem do App
    setState(() {
      _imagemApp = AssetImage("images/$escolhaApp.png");
    });

    // Define o resultado final
    if ((escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")) {
      setState(() {
        _resultadoFinal = "Parabéns!!! Você ganhou 🎉";
      });
    } else if ((escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")) {
      setState(() {
        _resultadoFinal = "Puxa!!! Você perdeu 😢";
      });
    } else {
      setState(() {
        _resultadoFinal = "Empate!!! Tente novamente 😐";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definição de cores dinâmicas para os modos claro e escuro
    Color backgroundColor = _isDarkMode ? Colors.black : Colors.white;
    Color textColor = _isDarkMode ? Colors.white : Colors.black;
    Color cardColor = _isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Text(
          'JokenPO',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 5,
        actions: [
          Switch(
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            activeColor: Colors.yellowAccent,
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Texto "Escolha do App"
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
                "Escolha do App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            // Imagem da escolha do app
            Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image(image: _imagemApp, height: 150),
              ),
            ),
            // Texto "Escolha uma opção abaixo"
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
                "Escolha uma opção abaixo:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            // Botões de escolha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _botaoOpcao("pedra"),
                _botaoOpcao("papel"),
                _botaoOpcao("tesoura"),
              ],
            ),
            // Resultado final
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
                _resultadoFinal,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para os botões de escolha
  Widget _botaoOpcao(String escolha) {
    return GestureDetector(
      onTap: () => _opcaoSelecionada(escolha),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Image.asset('images/$escolha.png', height: 100),
      ),
    );
  }
}
