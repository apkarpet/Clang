# The C Foundations

The programs I wrote in my first year of Computer Engineering at the University of Patras,
for the *Introduction to Programming* course. They start at "Hello, World" and work up to
structs, string arrays, sorting and file I/O, one lab at a time.

- [`labwork/`](labwork): the weekly lab assignments (Labs 1–11), with the assignment sheets
  as PDFs where I kept them.
- [`codes/`](codes): the same exercises redone and extended at home, plus extra practice
  (pointers, student records, a word counter).

## Demo

```text
$ ./build.sh
  ok      labwork-Lab3-HailstoneSeq-Vol1
  ok      labwork-Lab7-Divisors
  ...
71 built, 9 skipped, 7 failed. Binaries are in build/.

$ ./build/labwork-Lab3-HailstoneSeq-Vol1          # Collatz sequence
Hailstone Vol1 running:
Enter starting number: 7
22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1

$ ./build/labwork-Lab9-Ex2                         # three-digit Armstrong numbers
The sum of 153's digits raised to the power of 3 is equal to 153. (3^3+5^3+1^3=153)
The sum of 370's digits raised to the power of 3 is equal to 370. (0^3+7^3+3^3=370)
The sum of 371's digits raised to the power of 3 is equal to 371. (1^3+7^3+3^3=371)
The sum of 407's digits raised to the power of 3 is equal to 407. (7^3+0^3+4^3=407)

$ ./build/labwork-Lab10-StudentsApp                # structs, search, save/load to file
--- Student Management System ---
1. Create a new team of students
2. Print team roster
3. Load team from file
4. Search student by ID
5. Search student by name/lastname
6. Save team to file
7. Exit
Enter your choice: 4
Enter student ID to search: 10567
Student found:
Name: Nikos Georgiou
ID: 10567
```

Some prompts are in Greeklish (Greek written in Latin letters), as we wrote them in the lab:
*"Dose arithmo"* means "enter a number".

## What's in each lab

| Lab | Programs | What it practises |
| --- | --- | --- |
| [1](labwork/Lab1) | `HelloWorld`, `mainCUSTOM` | first programs, printing a triangle of `X`s |
| [2](labwork/Lab2) | `Add2Numbers` (2 versions) | reading input with `scanf`, arithmetic |
| [3](labwork/Lab3) | `Average`, `FibonacciSeq`, `HailstoneSeq` | loops, sequences, the Collatz conjecture |
| [4](labwork/Lab4) | `LogNum`, `MinAndMax` (3 versions), `Power` | functions, `math.h`, input validation |
| [5–6](labwork/Lab5_6) | `Menu`, `StringHandling`, `WordsHandlingFinal` | menu-driven calculator, strings, arrays of words |
| [6](labwork/Lab6) | `Menu`, `MinAndMax` (4 versions), `StringHandling`, `WordsHandling` | arrays, sorting integers and strings |
| [7](labwork/Lab7) | `AddNumbersAdvanced`, `Divisors`, `MostFrequentNumber` | prime test and divisors, frequency counting |
| [8](labwork/Lab8) | `Fractions` (2 versions) | a fraction calculator with structs and the GCD (`+ 1/2 3/4`) |
| [9](labwork/Lab9) | `Ex1`, `Ex2` | price with discount, Armstrong numbers |
| [10](labwork/Lab10) | `StudentsApp`, `OrdersHandling` | structs, searching, saving and loading files |
| [11](labwork/Lab11) | `BubbleSort`, `BubbleSortWithLetters` | bubble sort on numbers and on random strings |

`codes/` follows the same topics with extra versions, plus extra practice such as `Swap_Pointers`
(swapping through pointers) and `Students`.

## Building

You need `gcc` (or `clang`) and bash.

```sh
./build.sh            # build every program into build/
./build.sh labwork    # only the lab assignments
./build/labwork-Lab7-Divisors
```

Or compile a single program by hand from its folder:

```sh
cd labwork/Lab7/Divisors
gcc -std=gnu17 -fpermissive main.c -o divisors -lm
./divisors
```

About the build results:

- **`-std=gnu17 -fpermissive`**: some early programs call functions before declaring them,
  which older compilers accepted and GCC 14+ rejects by default. These flags let them build
  unchanged.
- **Skipped (9):** the course gave us a helper library, `libi2p` (`i2p.h` + `libi2p.dll`),
  for input and sorting. It only exists as a Windows DLL, so programs that use it build only
  on Windows with Dev-C++ (the `.dev` project files and `Makefile.win` are for that).
- **Failed (7):** drafts that never compiled (a typo like `pritnf`, a missing brace, or
  unfinished code such as `Lab10/OrdersHandling`, the start of an order-tracking program).
  They're kept as they were written.

## Tools

C (C89/C99 style), GCC, Dev-C++ on Windows in the lab, VS Code and CLion at home.
