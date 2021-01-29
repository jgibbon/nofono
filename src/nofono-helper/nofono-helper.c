#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char **argv) {
    char cmdline[4096];;
    if (setuid(0) != 0) {
        perror("Setuid failed, no suid-bit set?");
        return 1;
    }
    setuid(0);
    sprintf(cmdline, "killall -s9 ofonod");

    system(cmdline);
    return 0;
}
