import 'dart:math';
import '../core/constants.dart';
import '../core/grafo_tabuleiro.dart';
import '../core/regras_vitoria.dart';
import '../enums/jogador.dart';
import '../enums/vencedor.dart';
import '../models/lacuna.dart';

class JogoController {
  List<Lacuna> lacunas = [];
  List<int> movimentosJogador1 = [];
  List<int> movimentosJogador2 = [];
  Jogador? jogadorAtual;

  bool get temMovimentos =>
      (movimentosJogador1.length + movimentosJogador2.length) !=
          tamanhoTabuleiro;

  JogoController() {
    _inicializa();
  }

  void _inicializa() {
    movimentosJogador1.clear();
    movimentosJogador2.clear();
    jogadorAtual = Jogador.jogador1;
    lacunas =
    List<Lacuna>.generate(tamanhoTabuleiro, (index) => Lacuna(index + 1));
  }

  void restart() {
    _inicializa();
  }

  void preencheLacuna(index) {
    final lacuna = lacunas[index];
    if (jogadorAtual == Jogador.jogador1) {
      _jogador1PreencheLacuna(lacuna);
    } else {
      _jogador2PreencheLacuna(lacuna);
    }

    lacuna.habilitar = false;
  }

  void _jogador1PreencheLacuna(Lacuna lacuna) {
    lacuna.marca = marcaJogador1;
    lacuna.cor = corJogador1;
    movimentosJogador1.add(lacuna.id);
    jogadorAtual = Jogador.jogador2;
  }

  void _jogador2PreencheLacuna(Lacuna lacuna) {
    lacuna.marca = marcaJogador2;
    lacuna.cor = corJogador2;
    movimentosJogador2.add(lacuna.id);
    jogadorAtual = Jogador.jogador1;
  }

  bool _verificaCombinacoes(List<int> movimentos) {
    return regrasVitoria.any((regra) =>
    movimentos.contains(regra[0]) &&
        movimentos.contains(regra[1]) &&
        movimentos.contains(regra[2]));
  }

  Vencedor verificaVencedor() {
    if (_verificaCombinacoes(movimentosJogador1)) return Vencedor.jogador1;
    if (_verificaCombinacoes(movimentosJogador2)) return Vencedor.jogador2;
    return Vencedor.nenhum;
  }

  int fazMovimentoAleatorio() {
    var lista = List.generate(9, (i) => i + 1);
    lista.removeWhere((element) => movimentosJogador1.contains(element));
    lista.removeWhere((element) => movimentosJogador2.contains(element));

    var random = Random();
    var index = random.nextInt(lista.length - 1);
    return lacunas.indexWhere((lacuna) => lacuna.id == lista[index]);
  }

  //implementacao com grafo que retorna a posicao da proxima jogada do Jogador2 (PC)
  int buscarMovimento() {
    var posicoesOcupadas = [...movimentosJogador1, ...movimentosJogador2];
    //se o centro estiver vazio, Jogador2 realiza primeira jogada no centro
    //se nao, Jogador2 realiza primeira jogada em algum canto
    if (movimentosJogador2.isEmpty) {
      var centro = 5;
      List<int> cantos = [1, 3, 7, 9];
      if(!movimentosJogador1.contains(centro)) return lacunas.indexWhere((lacuna) => lacuna.id == centro);
      for (var canto in cantos) {
        if (!posicoesOcupadas.contains(canto)) {
          return lacunas.indexWhere((lacuna) => lacuna.id == canto);
        }
      }
    }
    //Jogador2(PC) busca a vitoria se possuir 2 movimentos em alguma regra de vitoria
    for (var movimento in movimentosJogador2) {
      for (var vizinho in grafoTabuleiro[movimento]!) {
        if(movimentosJogador2.contains(vizinho)) {
          for(var regra in regrasVitoria) {
            if(regra.contains(movimento) && regra.contains(vizinho)) {
              var posicao = regra.firstWhere((pos) => pos != movimento && pos != vizinho);
              if (!posicoesOcupadas.contains(posicao)) {
                return lacunas.indexWhere((lacuna) => lacuna.id == posicao);
              }
            }
          }
        }
      }
    }
    //Jogador2(PC) busca a vitoria se possuir vizinho vazio e 2 movimentos em alguma regra
    for (var movimento in movimentosJogador2) {
      for (var vizinho in grafoTabuleiro[movimento]!) {
        if (!posicoesOcupadas.contains(vizinho)) {
          for (var regra in regrasVitoria) {
            if (regra.contains(movimento) && regra.contains(vizinho)) {
              var posicao = regra.firstWhere((pos) => pos != movimento && pos != vizinho);
              if (movimentosJogador2.contains(posicao)) {
                return lacunas.indexWhere((lacuna) => lacuna.id == vizinho);
              }
            }
          }
        }
      }
    }
    //Jogador2(PC) impede a derrota se Jogador1 possuir 2 movimentos em alguma regra de vitoria
    for (var movimento in movimentosJogador1) {
      for (var vizinho in grafoTabuleiro[movimento]!) {
        if(movimentosJogador1.contains(vizinho)) {
          for(var regra in regrasVitoria) {
            if(regra.contains(movimento) && regra.contains(vizinho)) {
              var posicao = regra.firstWhere((pos) => pos != movimento && pos != vizinho);
              if (!posicoesOcupadas.contains(posicao)) {
                return lacunas.indexWhere((lacuna) => lacuna.id == posicao);
              }
            }
          }
        }
      }
    }
    //Jogador2(PC) impede a derrota se possuir Jogador1 vizinho vazio e 2 movimentos em alguma regra
    for (var movimento in movimentosJogador1) {
      for (var vizinho in grafoTabuleiro[movimento]!) {
        if (!posicoesOcupadas.contains(vizinho)) {
          for (var regra in regrasVitoria) {
            if (regra.contains(movimento) && regra.contains(vizinho)) {
              var posicao = regra.firstWhere((pos) => pos != movimento && pos != vizinho);
              if (movimentosJogador1.contains(posicao)) {
                return lacunas.indexWhere((lacuna) => lacuna.id == vizinho);
              }
            }
          }
        }
      }
    }
    //busca possivel caminho para a vitoria
    for (var movimento in movimentosJogador2) {
      for (var vizinho in grafoTabuleiro[movimento]!) {
        if (!posicoesOcupadas.contains(vizinho)) {
          for (var regra in regrasVitoria) {
            if (regra.contains(movimento) && regra.contains(vizinho)) {
              var posicao = regra.firstWhere((pos) => pos != movimento && pos != vizinho);
              if (!posicoesOcupadas.contains(posicao)) {
                return lacunas.indexWhere((lacuna) => lacuna.id == vizinho);
              }
            }
          }
        }
      }
    }

    List<int> vizinhosNaoOcupados = [];
    for (int posicao in movimentosJogador2) {
      for (int vizinho in grafoTabuleiro[posicao]!) {
        if (!posicoesOcupadas.contains(vizinho)) {
          vizinhosNaoOcupados.add(vizinho);
        }
      }
    }
    //retorna vizinho nao ocupado, caso haja
    if (vizinhosNaoOcupados.isNotEmpty) {
      return lacunas.indexWhere((lacuna) => lacuna.id == vizinhosNaoOcupados.first);
    }
    //faz movimento aleatorio caso nenhum movimento desejado seja possivel
    return fazMovimentoAleatorio();
  }
}
