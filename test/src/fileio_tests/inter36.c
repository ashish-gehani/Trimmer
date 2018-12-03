#include <stdio.h>
#include <string.h>
//tests open, read and lseek 2

#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

struct Config {
  int max_connections;
  int num_cons;
  char ** conn_list;
  char * username, * password, * ip, * port;
};

struct Config * get_new_config() {
  struct Config * new_config = malloc(sizeof(struct Config));
  memset((char *) new_config, 0, sizeof(struct Config));
  new_config->max_connections = 100;
  return new_config; 
}

char * getLine(int fd, char * line, int size) {
	int offset = lseek(fd, 0, SEEK_CUR);
	int bytes_read = read(fd, line, size);
  if(bytes_read <= 0) return NULL;
  if(bytes_read < size) line[bytes_read] = '\0';
  int idx = strcspn(line, "\n");
  if(idx < size) line[idx + 1] = '\0';
	offset = lseek(fd, offset + idx + 1, SEEK_SET);
	return line;
}

int check_and_move(char * token, char ** line) {
  int size = strlen(token);
  if(!strncmp(token, *line, size)) {
    *line += size + 1;
    return 1;
  }
  return 0;
}

char * get_tok_val(char * str) {
  int size = strcspn(str, "\n");
  char * new_str = malloc(size + 1);
  memcpy(new_str, str, size);
  new_str[size] = '\0';
  return new_str;
}

int parse_input(char  * fname, struct Config * config) {
  int fd = open(fname, O_RDONLY);
  if(fd < 0) printf("file not found\n");
  char * line = malloc(1024);
  int num = 1;
  while(getLine(fd, line, 1024)) {
    if(check_and_move("username", &line)) config->username = get_tok_val(line);
    else if(check_and_move("password", &line)) config->password = get_tok_val(line);
    else if(check_and_move("ip", &line)) { 
      config->ip = get_tok_val(line);
    } else if(check_and_move("port", &line)) { 
      config->port = get_tok_val(line);
    }
    else  if(check_and_move("max_connections", &line)) { 
      int max_connections = atoi(line);
      if(max_connections > 100) printf("max_connections should be <= 100\n");
      if(config->conn_list) printf("a connection should not be added until max_connections is specified\n");
      config->max_connections = max_connections;
    } else  if(check_and_move("add_connection", &line)) {
      if(!config->conn_list) config->conn_list = malloc(sizeof(char *) * config->max_connections);
      config->conn_list[config->num_cons] = get_tok_val(line);
      config->num_cons++;
    }
    num++;
  } 
  close(fd);
  return 1;
}

void branchPruned(struct Config * config) {
  if(config->max_connections == 100 &&
  config->num_cons == 4 &&
  !strcmp(config->username, "Muhammad") &&
  !config->password &&
  !strcmp(config->ip, "1.2.3.4") &&
  !strcmp(config->port, "2345") &&
  !strcmp(config->conn_list[0], "3.4.5.6") &&
  !strcmp(config->conn_list[1], "4.5.6.7") &&
  !strcmp(config->conn_list[2], "5.6.7.8") &&
  !strcmp(config->conn_list[3], "6.7.8.9"))
    printf("branchPruned\n");
}

int main(int argc, char ** argv) {
  struct Config * config = get_new_config();
  parse_input("../data/configFile36.txt", config);
  branchPruned(config);
  return 0;
}
