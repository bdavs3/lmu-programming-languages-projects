#include <cassert>
#include <iostream>
#include <string>

using namespace std;

int main() {
  assert(say() == "");
  assert(say("Hi")() == "Hi");
  assert(say("Hello, ")("world!") == "Hello, world!");
  assert(say("Just")("saying")("hi")() == "Just saying hi");

  cout << "All tests passed\n";
}
