import std/terminal;
import base;
import debug;

var
    xResMap*, yResMap*, firstXPos*, lastXPos*, firstYPos*, lastYPos*: int
    padding*, border*: bool
    backgroundMapChar: ScreenChar = ScreenChar(
        character : ' ',
        backColor : bgBlack,
        foreColor : fgWhite                    
    );

# Call this function to create the map (2D area which you can and should draw on)
proc initializeMap*(xResInp: int, yResInp: int, pos: Position, backgroundChar: char = ' ', paddingInp: bool = false, borderInp: bool = false) =
#[
    xResInp - Width of the map
    yResInp - Height of the map
    xPosInp - Horizontal position of the map on screen
    yPosInp - Vertical position of the map on screen
    backgroundChar - Symbol that fills the background of the map
    paddingInp - Space between every symbol on the map (currently not working)
    borderInp - Border around the map (also not working)
]#

    try:
        xResMap = xResInp;
        yResMap = yResInp;
        
        backgroundMapChar.character = backgroundChar;

        padding = paddingInp;
        border = borderInp;

        firstXPos = pos.X;
        firstYPos = pos.Y;
        lastXPos = xResInp + firstXPos - 1;
        lastYPos = yResInp + firstYPos - 1;

        for i in 0..xResMap-1:
            for ii in 0..xResMap-1:
                screen[i+firstYPos][ii+firstXPos] = backgroundMapChar;
        
        if border:
            firstXPos += 1;
            lastXPos += 1;

            firstYPos += 1;
            lastYPos += 1;

    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();

# Puts a character on the map
proc putChar*(pos: Position, ch: char) =
#[
    posX - Horizontal position on map
    posY - Vertical position on map
    ch - Character to put
]#
    try:
        if pos.X+firstXPos > lastXPos or pos.Y+firstYPos > lastYPos or pos.X+firstXPos < firstXPos or pos.Y+firstYPos < firstYPos:
            printError "Given position on the map is out of it's boundaries";
            return;
        screen[pos.Y+firstYPos][pos.X+firstXPos].character = ch;
        draw();
    
    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();

# Gets a character from the map
proc getChar*(pos: Position) : char =
#[
    posX - Horizontal position on map
    posY - Vertical position on map
]#
    try:
        if pos.X+firstXPos > lastXPos or pos.Y+firstYPos > lastYPos:
            printError "Given position on the map is out of it's boundaries";
            return ' ';
        let returnVal = screen[pos.Y+firstYPos][pos.X+firstXPos].character;
        return returnVal;

    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();

# Draws a character on the map
proc drawRectangle*(pos: Position, height: int, width: int, ch: char) =
#[
    posX - Horizontl position of start of the rectangle on map
    posY - Vertical position of start of the rectangle on map
    (Start of the rectangle is top left corner)
    height - Height of the rectangle
    width - Width of the rectangle
    ch - Character that fills the rectangle
]#
    try:
        for i in 0..height-1:
            for ii in 0..width-1:
                putChar Position(X : i+pos.X,Y : ii+pos.Y), ch;
        draw();

    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();