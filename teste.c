
#include "types.h"      //maybe needed to use some types of variables
#include "user.h"       //functios like printf and syscalls

#define N 6

void loop(){
    int x, i = 0;

    for(x=0; x<112345678; x++){
        i--;
    }

    for(x=0; x<112345678; x++){
        i--;
    }

}

int main(){
    int pid;
    int i;
    for (i=1;i<=N;i++){
            pid=fork(1000/i); //dividido ou multiplicado para mudar as parada de ordem
            if(pid==0){
                loop();
                exit();
            }
    }
   while(1){
        pid=wait();
        if(pid<0)break;
    }



    exit();
}
