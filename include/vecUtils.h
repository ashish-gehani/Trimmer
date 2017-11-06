using namespace std;
using namespace llvm;

template <typename F>
bool findInVect(vector<F> & vect, F val) {
  return find(vect.begin(), vect.end(), val) != vect.end();
}

template <typename F>
bool findInVect(SmallVector<F, 16> vect, F val) {
  for(unsigned i = 0; i < vect.size(); i++) {
    if(vect[i] == val)
      return true;
  }
  return false;
}

template <typename F>
int findIndex(vector<F> & vect, F val) {
  for(unsigned i = 0; i < vect.size(); i++) {
    if(vect[i] == val)
      return i;
  }
  return -1;
}

template <typename F>
void InsertUnique(vector<F> & vect, F val) {
  if(!findInVect(vect, val))
    vect.push_back(val);
}

template <typename F>
void InsertUnique(vector<F> & vect1, vector<F> vect2) {
  for(unsigned i = 0; i < vect2.size(); i++)
    InsertUnique(vect1, vect2[i]);
}
