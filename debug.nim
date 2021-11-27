import std/terminal;

proc printDebug*(str: string) = 
    setBackgroundColor bgBlue;
    echo str;
    setBackgroundColor bgBlack;

proc printError(str: string) =
    setBackgroundColor bgRed;
    echo str;
    setBackgroundColor bgBlack;
