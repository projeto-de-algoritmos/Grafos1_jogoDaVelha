import 'package:flutter/material.dart';
import '../controllers/jogo_controller.dart';
import '../core/constants.dart';
import '../enums/jogador.dart';
import '../enums/vencedor.dart';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  State<Jogo> createState() => _JogoState();

}

class _JogoState extends State<Jogo> {
  final _controller = JogoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildTela(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(nomeJogo),
      centerTitle: true,
    );
  }

  _buildTela() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTabuleiro(),
        _buildBotaoRestart(),
      ],
    );
  }

  _buildBotaoRestart() {
    return ElevatedButton(
      onPressed: _recomecarJogo,
      child: const Text(restart),
    );
  }

  _buildTabuleiro() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: tamanhoTabuleiro,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: _buildLacuna,
      ),
    );
  }

  Widget _buildLacuna(context, index) {
    return GestureDetector(
      onTap: () => _marcaLacuna(index),
      child: Container(
        color: _controller.lacunas[index].cor,
        child: Center(
          child: Text(
            _controller.lacunas[index].marca,
            style: const TextStyle(
              fontSize: 72.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _recomecarJogo() {
    setState(() {
      _controller.restart();
    });
  }

  _marcaLacuna(index) {
    if (!_controller.lacunas[index].habilitar) return;

    setState(() {
      _controller.preencheLacuna(index);
    });

    _verificaVencedor();
  }

  _verificaVencedor() {
    var vencedor = _controller.verificaVencedor();
    if (vencedor == Vencedor.nenhum) {
      if (!_controller.temMovimentos) {
        _empatou();
      } else if (_controller.jogadorAtual == Jogador.jogador2) {
        final index = _controller.buscarMovimento();
        _marcaLacuna(index);
      }
    } else {
      String marca =
      vencedor == Vencedor.jogador1 ? marcaJogador1 : marcaJogador2;
      _mostrarVencedor(marca);
    }
  }

  _mostrarVencedor(String marca) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(quemVenceu.replaceAll('[MARCA]', marca)),
          content: const Text(mensagem),
         actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
         ],
        );
      },
    );
  }

  _empatou() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: const Text(nomeEmpate),
          content: const Text(mensagem),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}