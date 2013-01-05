#include <iostream>
#include <string>
#include <sstream>
#include <algorithm>
#include <iterator>
#include <vector>
using namespace std;


int main() 
{
  string sentence = "   Something in the way she   moves...  ";
  istringstream iss(sentence);
  /*
  copy(istream_iterator<string>(iss),
      istream_iterator<string>(),
      ostream_iterator<string>(cout, "\n"));
  */
  vector<string> tokens;
  copy(istream_iterator<string>(iss),
      istream_iterator<string>(),
      back_inserter<vector<string> >(tokens));
  for(unsigned i=0; i < tokens.size(); i++)
  {
    cout << tokens[i] << endl;
  }
}
