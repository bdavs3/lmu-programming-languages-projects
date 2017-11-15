#include <iostream>
#include <stdexcept>
using namespace std;

template <typename T>
class Queue {

  struct Node {
    T data;
    Node* next;
  };

  int size = 0;
  Node* head = nullptr;
  Node* tail = nullptr;

  Node* copy(Node* n) {
    return new Node {n->data, n->next ? copy(n->next) : nullptr};
  }

public:

  ~Queue() {
    while (head != nullptr) {
      dequeue();
    }
  }

  Queue() = default;

  Queue(const Queue& s) = delete;
  Queue& operator=(const Queue& s) = delete;

  Queue(Queue&& s): size(s.size), head(s.head) {
    s.head = nullptr;
    s.size = 0;
  }

  Queue& operator=(Queue&& s) {
    if (&s != this) {
      delete head;
      size = s.size;
      head = s.head;
      tail = s.tail;
      s.tail = nullptr;
      s.head = nullptr;
      s.size = 0;
    }
    return *this;
  }

  int get_size() {
    return size;
  }

  T dequeue() {
    if (size == 0) throw underflow_error("Can't dequeue from empty queue");
    Node* nodeToDelete = head;
    T valueToReturn = head->data;
    head = head->next;
    size--;
    if (size == 0) tail = nullptr;
    delete nodeToDelete;
    return valueToReturn;
  }

  void enqueue(T d) {
    Node* newTail = new Node {d, nullptr};
    if (size == 0) {
      tail = newTail;
      head = tail;
    } else {
      tail->next = newTail;
      tail = tail->next;
    }
    size++;
  }
  friend ostream& operator<<(ostream& os, const Queue& q) {
    if (q.size == 0) return os << "empty";
    return os << "size:"<< q.size << " head:" << q.head->data << " tail:" << q.tail->data;
  }
};
