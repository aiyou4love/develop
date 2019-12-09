#include "WinMethod.hpp"

#include <iostream>
#include <string>

using namespace cc;

using std::cin;
using std::cout;
using std::endl;
using std::string;

int main(int argc, char *argv[]) {
  initMemoryLeak();
  int *leak = new int[10];
  cin.get();
  return 0;
}
