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

### Answer:
Following this declaration, we wrote the following:
```cpp
int main() {
  cout << &A[0][0] << "\n";
  cout << &A[3][7];
  ...
```
This produced the following console output:
```cpp
0x564b98a871a0
0x564b98a872c8
```
These hex values are 94882683711904 and 94882683712200 in decimal, respectively.  Notice that they are only 296 apart from each other.  We had a hunch that there were 37 structs in memory between the first memory value (&A[0][0]) and the second (&A[3][7]), so we divided 296 by 37 to obtain 8.  This makes sense, if each struct was allocated 8 bytes in memory!  Conveniently, doing the following in the main method:
```cpp
  ...
  cout << sizeOf(A[0][0])
}
```
produces:
```cpp
8
```

# Problem 2
(5 pts) Explain the meaning of the following C++ declarations:
```cpp
double *a[n];
double (*b)[n];
double (*c[n])();
double (*d())[n];
```

### Answer:

```cpp
double *a[n];
```

a is a size n array of pointers to doubles.

```cpp
double (*b)[n];
```

b is a pointer to a size n array of doubles.

```cpp
double (*c[n])();
```

c is a size n array of pointers to functions that return doubles.

```cpp
double (*d())[n];
```

d is a function that returns a pointer to a size n array of doubles.

# Problem 3
(5 pts) Consider the following declaration in C++:
```cpp
double (*f(double (*)(double, double[]), double)) (double, ...);
```
Describe rigorously, in English, the type of f.

### Answer:

```cpp
f is a function that passes in 
  a pointer to a function that passes in a double and a double array of undefined size and returns a double 
    and a double 
  and returns
a pointer to a function that passes in a double and a rest parameter 
and returns a double.
```

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

### Answer:

The only b field that is accessible for reading and writing is the int b from the Derived subclass. When you try to assign a string to b of a Derived object, like so...

```cpp
int main() {
	Derived* d = new Derived();
	d->a = 5;
	d->b = "hi";
	d->b = 7;
	d->c = 7.7;
}
```

it prints the following error...

```cpp
jdoodle.cpp: In function 'int main()':
jdoodle.cpp:22:9: error: invalid conversion from 'const char*' to 'int' [-fpermissive]
  (*d).b = "hi";
         ^
```

This makes sense with our hypothesis because the error says the program is trying to assign a 'const char*' (which we found out is the first element of an array of chars which is a string) to the int b.

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
