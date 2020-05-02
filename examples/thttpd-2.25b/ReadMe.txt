Currently the bitcode produced after make step
has opt-none. Temp fix is to disassemble, remove optnone
then reassemble before running trimmer
