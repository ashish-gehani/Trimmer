#include<stdio.h>
#include<string.h>
#include<stdlib.h>

struct stType {
  int (*callback) (int,int);
  char str[100];
};

void callback(struct stType st) {
	if(!strcmp(st.str, "add"))
		st.callback(3, 5);
	else if(!strcmp(st.str, "multiply"))
		st.callback(5, 6);
}

int add(int a, int b) {
	printf("%d\n", (a + b));
	return (a + b);
}

int multiply(int a, int b) {
	printf("%d\n", (a * b));
	return (a * b);
}

int main() {
	struct stType st;
	st.callback = &add;
	memcpy(st.str, "add", 3);
	callback(st);
}