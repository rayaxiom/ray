#include <iostream>
#include <fstream>
#include <string>


using namespace std;
int main(int argc, char* argv[])
{
  string line;
  ifstream myfile (argv[1]);
  unsigned current_line_number = 1;
  if (myfile.is_open())
  {
    while ( myfile.good() )
    {
      getline (myfile,line);
      cout << line << " ";
      
      if((current_line_number%4) == 0)
      {
        cout << endl;
        current_line_number = 0;
      }
      current_line_number++;
    }
  }
  else
  {
   cout << "Unable to open file";
  }
  return 0;
}

