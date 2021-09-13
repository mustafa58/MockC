#include <stdio.h>

void test(void) {
    puts("This is original.");
}


void caller(void) {
    test();
}

int main(int argc, char ** argv) {
    test();
    return 0;
}