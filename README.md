# Grafos1_jogo_da_velha

# Jogo da Velha

**Número da Lista**: X<br>
**Conteúdo da Disciplina**: Grafos1<br>

## Alunos
|Matrícula | Aluno |
| -- | -- |
| 14/0158278  | Pedro Helias Carlos |
| 17/0069991  |  João Victor Max Bisinotti de Oliveira |

## Sobre 
O projeto Jogo da Velha tem como objetivo implementar um jogo da velha no modo Single Player. O jogo possui uma interface gráfica simples, onde o jogador pode selecionar uma posição do tabuleiro para fazer a jogada, e o algoritmo faz sua jogada logo em seguida. O algoritmo faz suas jogadas com base na configuração atual do tabuleiro, considerando quais posições ocupadas representam movimentos do jogador e quais representam movimentos do algoritmo. Com base nisso, a algoritmo busca busca uma jogada que possibilite um caminho para vitória ou impedir a derrota, analisando cada movimento e seus vizinhos. Caso não seja possível efetuar a jogada desejada, é o algoritmo tenta efetuar a jogada em no primeiro vizinho desocupado de um movimento que já realizou.
Em último caso, a jogada é efetuada uma posição qualquer que esteja desocupada.

## Screenshots
Adicione 3 ou mais screenshots do projeto em funcionamento.

## Instalação 
**Linguagem**: Dart<br>
**Framework**: Flutter<br>

1. Instale o Flutter em seu computador seguindo os passos descritos na documentação oficial: https://flutter.dev/docs/get-started/install
2. Clone o repositório do projeto em sua máquina
3. Execute o comando `flutter pub get` no diretório raiz do projeto para instalar as dependências necessárias
4. Conecte seu dispositivo móvel ao computador ou inicie um emulador de dispositivo móvel ou selecione o navegador(Chrome(web)) como Flutter Device.
5. Execute o comando `flutter run` no diretório raiz do projeto para iniciar o aplicativo


## Uso 
Após executar o aplicativo, o jogador pode clicar em uma posição do tabuleiro para fazer a jogada. O computador fará sua jogada logo em seguida. O jogo termina quando alguém vence ou empatam. Caso deseje jogar novamente, basta clicar no botão "Restart".
