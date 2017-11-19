#include <string> 
using namespace std;
using namespace llvm;

#define MaxArgs 10

// format : |arg1 arg2 arg3|

vector<string> parse_args(string s) {
    string temp = "";
    vector<string> ret;
    for(unsigned i = 0; i < s.size(); i++) {
        if(s[i] == ' ') {
            ret.push_back(temp);
            temp = "";
        } else
            temp += s[i];   
    }
    ret.push_back(temp);
    return ret;
} 

int parse_args(string s, char** arr) {
	int count = 0;
	string temp = "";
	for(unsigned i = 0; i < s.size(); i++) {
		if(s[i] == ' ') {
			arr[count] = new char[temp.size()];
			errs() << temp << " " << temp.size() << "\n";
			strcpy(arr[count], temp.c_str());
			count++;
			temp = "";
		} else
			temp += s[i];   
	}
	arr[count] = new char[temp.size()];
	strcpy(arr[count], temp.c_str());
	count++;	
	errs() << count << "\n";
	return count;
}  