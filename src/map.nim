import std/terminal;
import base;
import debug;

var
    xResMap*, yResMap*, firstXPos*, lastXPos*, firstYPos*, lastYPos*: int
    padding*, border*: bool
    backgroundMapChar: screenChar = screenChar(
        character : ' ',
        backColor : bgBlack,
        foreColor : fgWhite                    
    );

# Call this function to create the map (2D area which you can and should draw on)
proc initializeMap*(xResInp: int, yResInp: int, xPosInp: int = 0, yPosInp: int = 0, backgroundChar: char = ' ', paddingInp: bool = false, borderInp: bool = false) =
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

        firstXPos = xPosInp;
        firstYPos = yPosInp;
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
proc putChar*(posX: int, posY: int, ch: char) =
#[
    posX - Horizontal position on map
    posY - Vertical position on map
    ch - Character to put
]#
    try:
        if posX+firstXPos > lastXPos or posY+firstYPos > lastYPos or posX+firstXPos < firstXPos or posY+firstYPos < firstYPos:
            printError "Given position on the map is out of it's boundaries";
            return;
        screen[posY+firstYPos][posX+firstXPos].character = ch;
        draw();
    
    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();

# Gets a character from the map
proc getChar*(posX: int, posY: int) : char =
#[
    posX - Horizontal position on map
    posY - Vertical position on map
]#
    try:
        if posX+firstXPos > lastXPos or posY+firstYPos > lastYPos:
            printError "Given position on the map is out of it's boundaries";
            return ' ';
        let returnVal = screen[posY+firstYPos][posX+firstXPos].character;
        return returnVal;

    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();

# Draws a character on the map
proc drawRectangle*(posX: int, posY: int, height: int, width: int, ch: char) =
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
                putChar i+posX, ii+posY, ch;
        draw();

    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();