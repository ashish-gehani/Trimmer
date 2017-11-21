extern volatile int stop;
extern int max_x, max_y;

void determine_terminal_size(int *max_y, int *max_x);
void handler(int sig);
