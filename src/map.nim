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

proc initializeMap*(xResInp: int, yResInp: int, xPosInp: int = 0, yPosInp: int = 0, backgroundChar: char = ' ', paddingInp: bool = false, borderInp: bool = false) =
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

proc putChar*(posX: int, posY: int, ch: char) =
    screen[posY+firstYPos][posX+firstXPos].character = ch;
    draw();

proc drawRectangle*(posX: int, posY: int, height: int, width: int, ch: char) =
    try:
        for i in 0..height-1:
            for ii in 0..width-1:
                putChar i+posX, ii+posY, ch;
        draw();
    except:
        printError repr(getCurrentException()) & "|" & getCurrentExceptionMsg();