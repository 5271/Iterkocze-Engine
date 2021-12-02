import std/terminal;

proc printDebug*(str: string) = 
    setBackgroundColor bgBlue;
    setForegroundColor fgWhite;
    stdout.write "[DEBUG]";
    setBackgroundColor bgBlack;
    resetAttributes();
    setForegroundColor fgBlue;
    var strOpt: string = " " & str & "\n";
    stdout.write strOpt;
    resetAttributes();

proc printError*(str: string) =
    setBackgroundColor bgRed;
    stdout.write "[ERROR]";
    resetAttributes();
    setForegroundColor fgRed;
    var strOpt: string = " " & str & "\n";
    stdout.write strOpt;
    setForegroundColor fgWhite;

proc printWarning*(str: string) =
    setBackgroundColor bgGreen;
    setForegroundColor fgBlack;
    stdout.write "[WARNING]";
    resetAttributes();
    setForegroundColor fgGreen;
    var strOpt: string = " " & str & "\n"
    stdout.write strOpt;
    resetAttributes();