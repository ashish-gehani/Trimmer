
__attribute__((weak)) void __dummy(void *x) { }
int main() {
	void *x;
	__dummy(x);
}
