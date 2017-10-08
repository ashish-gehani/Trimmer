
struct configStruct{
  int a;
  int b;
};

void read_config(int argc, char *argv[], struct configStruct config){

  for(int j = 0; j < argc; j++){
    char *flag = argv[j];
    config.a = 5;
    config.b = 4;
  }
}

int main(int argc, char *argv[]){

  struct configStruct config;
  read_config(argc, argv, config);  
  
  return 0;  
}
