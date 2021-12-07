import std/terminal;
import osproc;
import debug;

const
    screenResX*: int = 2048
    screenResY*: int = 2048;

type
    screenChar* = object
        character*: char
        backColor*: BackgroundColor
        foreColor*: ForegroundColor;

var 
    screen*: array[screenResX, array[screenResY, screenChar]]
    xRes*, yRes*: int
    error*: bool = false
    backgroundScreenChar*: screenChar = screenChar(
        character : ' ',
        backColor : bgBlack,
        foreColor : fgWhite
    );

# Call this function to create the screen
proc initializeScreen*(xResInp: int, yResInp: int, backgroundChar: char = ' ') =
#[ xResInp - Horizontal resolution of the screen
   yResInp - Vertical resolution of the screen ]#

    try:
        xRes = xResInp;
        yRes = yResInp;

        backgroundScreenChar.character = backgroundChar;
        
        for i in 0..screenResX-1:
            for ii in 0..screenResY-1:
                screen[i][ii] = backgroundScreenChar;
        
    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();
    

# Draws all the content in the screen
proc draw*() =
    discard execCmd "clear";
    for i in 0..yRes:
        for ii in 0..xRes:
            stdout.write screen[i][ii].character;
        stdout.write '\n';

# Puts a character on the screen in the specified coordiantes
proc putCharOnScreen*(posX: int, posY: int, ch: char) =
    try:
        screen[posY][posX].character = ch; 
        draw();
    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();

# Draws a rectangle
proc drawRectangleOnScreen*(posX: int, posY: int, height: int, width: int, ch: char) =
    try:
        for i in 0..height-1:
            for ii in 0..width-1:
                putCharOnScreen i+posX, ii+posY, ch;
    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();