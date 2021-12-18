import std/terminal;
import osproc;
import debug;

const
    resX*: int = 2048
    resY*: int = 2048;

type
    ScreenChar* = object
        character*: char
        backColor*: BackgroundColor
        foreColor*: ForegroundColor
    Position* = object
        X* : int
        Y* : int;

var 
    screen*: array[resX, array[resY, ScreenChar]]
    xResScreen*, yResScreen*: int
    error*: bool = false
    backgroundScreenChar*: ScreenChar = ScreenChar(
        character : ' ',
        backColor : bgBlack,
        foreColor : fgWhite
    );

# Call this function to create the screen
proc initializeScreen*(xResInp: int, yResInp: int, backgroundChar: char = ' ') =
#[ 
    xResInp - Width of the screen
    yResInp - Height of the screen 
    backgroundChar - Symbol that fills the background of the screen
]#

    try:
        xResScreen = xResInp;
        yResScreen = yResInp;

        backgroundScreenChar.character = backgroundChar;
        
        for i in 0..resX-1:
            for ii in 0..resY-1:
                screen[i][ii] = backgroundScreenChar;
        
    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();
    

# Draws all the content of the screen
proc draw*() =
    try:
        discard execCmd "clear";
        for i in 0..yResScreen:
            for ii in 0..xResScreen:
                stdout.write screen[i][ii].character;
            stdout.write '\n';

    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();

# Puts a character on the screen in the specified coordiantes
proc putCharOnScreen*(pos: Position, ch: char) =
#[
    pos - Position on screen
    ch - Character to put
]#
    try:
        screen[pos.Y][pos.X].character = ch; 
        draw();

    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();

proc getCharFromScreen*(pos: Position) : char =
#[
    pos - Position on screen
]#
    try:
        return screen[pos.Y][pos.X].character;

    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();

# Draws a rectangle
proc drawRectangleOnScreen*(pos: Position, height: int, width: int, ch: char) =
#[
    pos - Position of start of the rectangle on screen
    (Start of the rectangle is top left corner)
    height - Height of the rectangle
    width - Width of the rectangle
    ch - Character that fills the rectangle
]#
    try:
        for i in 0..height-1:
            for ii in 0..width-1:
                putCharOnScreen Position(X : i+pos.X, Y : ii+pos.Y), ch;
    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();