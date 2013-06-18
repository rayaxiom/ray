#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <algorithm>
#include <iterator>
#include <vector>
using namespace std;

namespace RayGlobalVars
{
  enum LoopType {SIMPLE_LOOP, BETA, GAMMA};
}

void get_tokens(string &myfile_str, unsigned &ntokens,
                vector<vector<string> > &tokens)
{
  // Set the ntokens to 0, it should already be 0.
  ntokens = 0;
  
  // The file
  ifstream myfile (myfile_str.c_str());
  
  // string for holding the current line.
  string RAYDOINGline;
  string RAYITSline;

  string RAYDOING="RAYDOING";
   
  // Here we split the file per row
  // Then within each row, we split it per words 
  if (myfile.is_open())
  {
    bool skip_raydoing = false;
    
    // Get the first line in the pair
    while ( myfile.good() )
    {
      // Get the first line in the pair
      if(!skip_raydoing)
      {
        getline(myfile,RAYDOINGline);
      }
      else
      {
        skip_raydoing = false;
      }

      // Get the second line in the pair
      getline(myfile,RAYITSline);
      
      //std::cout << RAYDOINGline << std::endl;
      //std::cout << RAYITSline << std::endl; 
      
      
      if (std::string::npos != RAYITSline.find(RAYDOING))
      {
        std::cout << "There is a failed test." << std::endl;
        skip_raydoing = true;
      }
      
      // If we need to skip the next ray_doing, this means
      // there is a failed test in the current iteration...
      // So we put an empty string in for this and prepare for
      // the next pair.
      if(skip_raydoing)
      {
        vector<string> temp;
        temp.push_back("FAIL");
        tokens.push_back(temp);
        ntokens++;

        // Prepare the next pair.
        RAYDOINGline = RAYITSline;
      }
      else
      {
      // the current tokens
      vector<string> current_line_tokens;
      
      istringstream iss(RAYITSline);
      copy(istream_iterator<string>(iss),
           istream_iterator<string>(),
           back_inserter<vector<string> >(current_line_tokens));
      
      // current_line_tokens now contains tokens delimited by space and tabs.
      // i.e.
      // RAYITS:	0	68 250 256 	191.3(3)
      // 
      // So indices:
      // 0 - the "key"
      // 1 - the number of Newton solves
      // 2 - size()-2: the values of w/e key defines
      // size()-1: the average of the values
      //
      // I only want to keep the averages for now...
      unsigned ncurrenttokens = current_line_tokens.size();
      vector<string> temp;
      temp.push_back(current_line_tokens[ncurrenttokens-1]);
      
      // Update the total number of tokens we decide to keep.
      ntokens += temp.size();
      tokens.push_back(temp);
      }
    }
  }
  else
  {
    cout << "Unable to open file" << endl;
  }
//  std::cout << "tokens length: " << tokens.size() << std::endl; 
//  for(unsigned i = 0; i < tokens.size(); i++)
//  {
//    std::cout << "i: " << i << ", token: " << tokens[i][0] << std::endl; 
//    
//  }
// pause(); 
}

void check_nrows_ncols(unsigned &nrows, unsigned &ncols, unsigned &ntokens)
{
  unsigned nrowsxncols = nrows*ncols;
  if(nrowsxncols != ntokens)
  {
    std::cout << "nrow * ncol = " << nrows << " x " << ncols 
              << " = " << nrowsxncols  << std::endl;
    std::cout << "But ntokens = " << ntokens << std::endl;
    std::cout << "Is this correct? (y/n, default is n)" << std::endl; 
    string answer;
    std::cin >> answer;

    if((answer.compare("y") == 0) || (answer.compare("Y") == 0))
    {
      std::cout << "Okay... you are strange..." << std::endl;
    }
    else
    {
      std::cout << "Fix this using maniedit and re-run maniprint" << std::endl; 
    }
  }
}

void print_tokens(vector<vector<string> >&tokens, unsigned ntokens)
{
  unsigned nrows = 18; //36;
  unsigned ncols = 4; //7;
  RayGlobalVars::LoopType current_loop_type = RayGlobalVars::SIMPLE_LOOP;
  
  check_nrows_ncols(nrows,ncols,ntokens);

  switch(current_loop_type)
  {
    case RayGlobalVars::SIMPLE_LOOP :
    {
      // This is a simple two-loop scheme loop.
      //
      // 0,  1,  2,  3,  4,  5,  6
      // 7,  8,  9,  10, 11, 12, 13
      // 14, 15, 16, 17, 18, 19, 20
      // 21, 22, 23, 24, 25, 26, 27
      // 28, 29, 30, 31, 32, 33, 34
      //
      // 35, 36, 37, 38, 39, 40, 41
      // 42, 43, 44, 45, 46, 47, 48
      // 49, 50, 51, 52, 53, 54, 55
      // 56, 57, 58, 59, 60, 61, 62
      // 63, 64, 65, 66, 67, 68, 69
      for(unsigned i = 0; i < nrows; i++) // Goes through the rows
      {
        for(unsigned j = 0; j < ncols; j++) // Goes through the columns
        {
          std::cout << tokens[j + i*ncols][0] << " ";
        }
        std::cout << endl;
      }
    } break;
    default:
    {
      std::cout << "I do not recognise this loop type..." << std::endl; 
    } break;
  }
  
}

int main(int argc, char* argv[])
{ 
  std::string myfilename(argv[1]);
  std::vector< vector<string> > tokens;
  unsigned ntokens = 0;
  
  get_tokens(myfilename,ntokens,tokens);
  print_tokens(tokens,ntokens);
  // Here I am looping through everything to test if it works.
  // It does!
  /*
  for (vector< vector<string> >::iterator row_iterator = tokens.begin();
       row_iterator != tokens.end(); row_iterator++)
  {
    for(vector<string>::iterator column_iterator = (*row_iterator).begin();
        column_iterator != (*row_iterator).end(); column_iterator++)
    {
      cout << *column_iterator << " ";
    }
    cout << endl;
  }
  */

  // The data was in the format:
  // 3(1)
  // 6(4)
  // 8(4)
  // ...
  // So we only ever concern ourselves with the first entry of the row
  // hence token[x][0] is used.
  // x is looping through as follows:
  // lines: ->
  // 0, 5, 10, 15
  // 1, 6, 11, 16
  // 2, 7, 12, 17
  // 3, 8, 13, 18
  // 4, 9, 14, 19
  // load in first_data.dat to see.
  /*
  for(unsigned i = 0; i < 5; i++) // Goes through each row.
  {
    for(unsigned j = 0; j < 4; j++) // Goes through each column
    {
      cout << tokens[j*5 + i][0] << " ";
    }
    cout << endl;
  } 
  */

  /*
  // The data
  // Note, this is for the Step problem where the Reynolds numbers is in the 
  // inner-most loop. Thus we has something like:
  // (Note that the loop directly above is for just one angle) so we want:
  //
  // 0, 5, 10, 15
  // 1, 6, 11, 16
  // 2, 7, 12, 17
  // 3, 8, 13, 18
  // 4, 9, 14, 19
  // 
  // 20, 25, 30, 35 
  // 21, 26, 31, 36
  // 22, 27, 32, 37
  // 23, 28, 33, 38
  // 24, 29, 34, 39
  //
  // etc...
  //
  
  unsigned n_angle = 10;
  unsigned n_rey = 5;
  unsigned n_el = 7;

  unsigned angle_incre = 35;
  unsigned rey_incre = 1;
  unsigned noel_incre = 5;
  for(unsigned k = 0; k < n_angle; k++) // Through each block (angle) This increases by 20?
  {
    for(unsigned i = 0; i < n_rey; i++) // Through each row (Reynolds) This increases by one.
    {
      for(unsigned j = 0; j < n_el; j++) // Through each column (Noel) This increases by 5?
      {
        // Look at the loop above to understand the indicies of this one.
        cout << tokens[j*noel_incre + i*rey_incre + k*angle_incre][0] << " ";
        //cout << (j*noel_incre + i*rey_incre + k*angle_incre) << " ";
      }
      cout << endl;
    }
  }
  // */

  return EXIT_SUCCESS;
}
