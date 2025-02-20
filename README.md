# Game_Of_Life_Assembly
## An implementation of Game of Life in Intel x86 32bit Assembly

Conway's Game of Life is a two-dimensional zero-player game invented by mathematician JohnHorton Conway in 1970. The purpose of this game is to observe the evolution of a cell system,starting from an initial configuration, introducing rules regarding death, respectively the creation of onenew cells in the system. This evolutionary system is Turing-complete. The state of a system is described by the cumulative state of the component cells, and for these we have the following rules:

Underpopulation. Each cell (that is alive in the current generation) with less than twoneighbors in life, dies in the next generation.
Continuity of living cells. Each cell (which is alive in the current generation), with two or three neighbors in life, will exist in the next generation.
Ultrapopular. Each cell (which is alive in the current generation), which has more than three neighbors alive, dies in the next generation.
Creation. A dead cell that has exactly three living neighbors will be created in the next generation.
Dead cell continuity. Any other dead cell, which does not fit into the rule of creation, a dead cell remains.
We define the state of a system at generation n as a matrix Sn ∈ Mm×n({0, 1}) (m - the number oflines, respectively n - the number of columns), where element 0 represents a dead cell, respectively 1 represents a living cell (in the current generation). We define a k-evolution (k ≥ 0) of the system an iteration S0 → S1 → · · · → Sk, where each Si+1 get from Si, applying the five rules stated above.

Observation. For the cells on the first line, first column, last line, respectively last column, the expansion to 8 neighbors is considered, by considering those that are not in the matrix as being dead cells.

Symmetric encryption scheme. We define an encryption key (starting from a configuration initial S0 and a k-evolution) as the operation < S0, k >, which represents the one-dimensional array of data (understood as a string of bits) obtained after concatenating the lines in the matrix in the extended matrix obtained, S'k.

We consider m a clear message (a string of characters without spaces). The encryption {m}<S0,k> will mean XORing the clear message m with the result given by < S0, k >. There are the following cases: • if the message and the key have the same length, it is XORed element by element, until the result is obtained; • if the message is shorter than the key, only the first part of the key is used, corresponding to the length of the message; • if the message is longer than the key, the replication of the key is considered whenever necessary to encrypt the entire message.

For decryption, the same mechanism is applied, the decrypted message will be XORed with the calculated key, and we will finally have m XOR k XOR k = m. (k XOR k = 0, and m XOR 0 = m, from the associativity of XOR, respectively from the calculation rules). When decrypting, the message will not be displayed in hexadecimal, but in clear.

## Requirements:
REQUIREMENT 0x00

The number of lines m, the number of columns n, the number of live cells are read from the keyboard (STDIN). The number of live cells p, the positions of the live cells in the matrix, respectively an integer k. At this step, it is requested that the system configuration be displayed to STDOUT after a k-evolution. Note: The elements on A line will be displayed with a space between them.

REQUIREMENT 0x01

The number of lines m, the number of columns n, the number of live cells are read from the keyboard (STDIN). The number of live cells p, the positions of the living cells in the matrix, an integer k, an integer o that can be 0 or 1 (0 for encryption, 1 for decryption), respectively a message m that can be clear, for encryption (a string of form 0x..., for decryption). Encryption/decryption of the received message is required, according to the key that must be calculated, according to the specifications in the theme formulation. Note: The same conditions as in the case of the first requirement are guaranteed, respectively the correctness of the input data, the messages to be encrypted will be messages without spaces, consisting of characters alpha-numeric (numbers, lowercase letters, uppercase letters), and the messages to be decrypted will be hexadecimal strings which will start with 0x and will contain symbols from the set {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E, F}. The messages (considered in the clear) will have a maximum of 10 characters!

REQUIREMENT 0x02

Restore, in a separate source file, the request 0x00, so that the input should be read from an in.txt file, and the output should be written in an out.txt file, using functions from the C language.

