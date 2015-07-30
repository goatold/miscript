#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/stat.h>
#include <fcntl.h>

#define MAXPENDING 5    /* Max connection requests */
#define BUFFSIZE 32
void Die(char *mess) { perror(mess); exit(1); }


int main(int argc, char *argv[]) {
  int skd;
  FILE *fpp;
  struct sockaddr_in;
  int rt;

  /* Create the TCP socket */
  if ((skd = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0) {
    Die("Failed to create socket");
  }
  if ((fpp = popen("tail", "w")) < 0) {
    Die("Failed to create pipe");
  }
  fprintf(stdout, "sfd:%d, fpp:%x\n", skd, fpp);

  rt = send(skd, "test", 5, MSG_NOSIGNAL);
  fprintf(stdout, "rt:%d\n", rt);
  perror("sock:\n");
  close(skd);
  rt = send(skd, "tes2", 5, 0);
  fprintf(stdout, "rt:%d\n", rt);
  perror("sock:\n");

  fprintf(fpp, "test\n");
  perror("pipe:\n");
  pclose(fpp);
  fprintf(fpp, "test\n");
  perror("pipe:\n");
}

