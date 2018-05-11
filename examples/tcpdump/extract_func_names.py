


if __name__ == "__main__":

    f = open("CVEs.txt")
    str = f.read()
    words = str.split()
    for word in words:
        word = word.split(":")[-1] 
        if ("_print" in word):
            if "()" in word:
                word = word[0:-3]
                print word 
            else:
                print word 
