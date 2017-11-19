#include<stdio.h>
#include<string.h>
#include<stdlib.h>


class MyClass {
public:
	MyClass() {
		name = (char *) malloc(sizeof(char) * 100);
		x = y = z = -1;
	}
	~MyClass() {
		free(name);
	}
	void set(long xv, long yv, long zv) {
		x = xv;
		y = yv;
		z = zv;
	}
	long getSum() {
		return x + y + z;
	}
private:
	long x, y, z;
	char * name;	
};
MyClass mc;
int main() {
	mc.set(3, 4, 5);
	long sum = mc.getSum();
	printf("%ld\n", sum);
}