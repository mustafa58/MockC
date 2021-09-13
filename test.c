#include <stdio.h>
#include "mock.h"
extern void caller(void);


/*@weaken*/
void test (void);

mock_func_init(void, test);
/* {
    puts("This is test double.");
} */

void test_success() {
    puts("This is OK.");
}

void test_fail() {
    puts("This is FAILED!.");
}

void runtest1() {
    mock_set(test, test_success);
    caller();
}

void runtest2() {
    mock_set(test, test_fail);
    caller();
}

int main(int argc, char ** argv) {
    runtest1();
    runtest2();
    return 0;
}