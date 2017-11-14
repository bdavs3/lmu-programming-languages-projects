**CMSI 386** Homework 3 - Written Problems, 11/14/2017

# Problem 1
(5 pts) Given the C++ declaration:
```cpp
struct {
  int n;
  char c;
} A[10][10];
```
On your machine, find the address of A[0][0] and A[3][7]. Explain why these values are what you found them to be.

<mark>Answer: </mark>

# Problem 2
(5 pts) Explain the meaning of the following C++ declarations:
```cpp
double *a[n];
double (*b)[n];
double (*c[n])();
double (*d())[n];
```

# Problem 3
(5 pts) Consider the following declaration in C++:
```cpp
double (*f(double (*)(double, double[]), double)) (double, ...);
```
Describe rigorously, in English, the type of f.

# Problem 4
(5 pts) What happens when we “redefine” a field in a C++ subclass? For example, suppose we have:
```cpp
class Base {
public:
  int a;
  std::string b;
};

class Derived: public Base {
public:
  float c;
  int b;
};
```
Does the representation of a Derived object contain one b field or two? If two, are both accessible, or only one? Under what circumstances? Tell the story of how things are.

# Problem 5
(5 pts) What does the following C++ program output?
```cpp
#include <iostream>
int x = 2;
void f() { std::cout << x << '\n'; }
void g() { int x = 5; f(); std::cout << x << '\n'; }
int main() {
  g();
  std::cout << x << '\n';
}
```
Verify that the answer you obtained is the same that would be inferred from apply the rules of static scoping. If C++ used dynamic scoping, what would the output have been?

# Problem 6
(5 pts) Suppose you were asked to write a function to scramble (shuffle) a given array, in a mutable fashion. Give the function signature for a shuffle function for (a) a raw array, and (b) a std::array.
