# Identificação do trabalho e do grupo

### Elementos (Grupo: Freedom_4)

- Mafalda Costa -
- Sara Moreira Reis - 202005388

### Contribuição
- Mafalda (50%)
- Sara (50%)

# Instalação e Execução:

# Descrição do jogo:

*Freedom* é normalmente jogado num tabuleiro quadrado de 10x10, no entanto outros tamanhos podem ser usados para jogos mais rápidos ou longos.

O objetivo de Freedom é ter mais pedras "vivas" no final do jogo do que o adversário. Uma pedra é considerada "viva" se fizer parte de uma linha horizontal, vertical ou diagonal de exatamente 4 pedras da mesma cor.

Na ilustração abaixo, o jogador Preto vence o jogo: há 11 pedras Pretas "vivas" (fazendo parte de três linhas de 4) e 8 pedras Brancas "vivas" (fazendo parte de duas linhas de 4). Note que uma das pedras Pretas "vivas" faz parte de duas linhas de 4, mas é contada apenas uma vez.

![image](images/board_example.png)

Um jogo começa com um tabuleiro vazio.
Cada jogador tem uma cor atribuída: Branca e Preta.
A Branca joga primeiro, colocando uma pedra branca em qualquer lugar do tabuleiro.

Após este movimento, os jogadores alternam, colocando as suas pedras em células vazias adjacentes à última pedra do adversário. Se todas as células adjacentes à última pedra do adversário estiverem ocupadas, o jogador tem o direito ("liberdade") de colocar a sua pedra em qualquer célula vazia do tabuleiro.

O jogo termina quando o tabuleiro estiver cheio de pedras. O último jogador tem o direito de não jogar na sua última vez (e deixar a última célula vazia) se reduzir a sua pontuação ao colocar a última pedra .

#  Lógica do Jogo
