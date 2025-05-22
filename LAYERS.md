# Capas de Colisión

| Capa      | Layer Nº | Máscara                          | Descripción                                |
|-----------|----------|----------------------------------|--------------------------------------------|
| `PLAYER`  | 1        | 4 (LEVEL)               			| Palas de los jugadores, colisionan con pelotas |
| `BALL`    | 2        | 1 (PLAYER), 3 (GOAL), 4 (LEVEL)  	| Pelotas en juego, colisionan con palas, porterías y nivel |
| `GOAL`    | 3        | 2 (BALL)                      	| Porterías, solo detectan pelotas |
| `LEVEL`   | 4        | -                             	| No colisiona, pero otros si colisionan contra el nivel |
