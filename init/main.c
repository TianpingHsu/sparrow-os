#include <sched.h>
#include <tty.h>

extern int printk(const char *fmt, ...);

char* hello_world = "HELLO WORLD";
void start_kernel(void)
{
    con_init();    
    printk("%s", hello_world);
    return ;
}
