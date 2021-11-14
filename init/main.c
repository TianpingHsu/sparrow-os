#include <sched.h>
#include <tty.h>
extern int printk(const char *fmt, ...);
extern void trap_init(void);
extern void sched_init(void);
extern void trap_init(void);
char* hello_world = "HELLO WORLD";
void start_kernel(void)
{
    con_init();    
    sched_init();
    trap_init();
    /*
    for (int i = 0; i < 25; i++) {
        for (int j = 0; j < 80; j++) {
            printk("%c", ' ');
        }
    }
    */
    //printk("%s", hello_world);
    for (;;) {}
    return ;
}
