#include <cassert>
#include <iostream>

using namespace std;

Queue<int> oneTwoThree() {
  Queue<int> z;
  z.enqueue(3);
  z.enqueue(2);
  z.enqueue(1);
  return z;
}

int main() {
  Queue<int> s;
  assert(s.get_size() == 0);
  s.enqueue(100);
  assert(s.get_size() == 1);
  s.enqueue(200);
  assert(s.get_size() == 2);
  assert(s.dequeue() == 100);
  assert(s.get_size() == 1);
  assert(s.dequeue() == 200);
  assert(s.get_size() == 0);

  Queue<int> t = oneTwoThree();
  t = oneTwoThree();

  assert(t.get_size() == 3);
  assert(t.dequeue() == 3);
  assert(t.dequeue() == 2);
  assert(t.dequeue() == 1);
  assert(t.get_size() == 0);

  cout << "All tests passed\n";
}

// The copying and assignment prohibition cannot be tested because trying to use
// them at all would lead to a compilation error.
