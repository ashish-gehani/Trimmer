using namespace llvm;
using namespace std;

#define None 0
#define Hashim 1
#define Abubakar 2
#define All 3

Instruction* debugInst;
#define debugLevel None

class debug {
    public:
    debug(int level) {
        if(debugLevel == All || level == debugLevel || level == All)
            ignore = false;
        else
            ignore = true;
    }
    template<class T>
    debug & operator << (const T &x) {
        if(!ignore)
            errs() << x;
        return *this;
    }

    private:
        bool ignore;
};
