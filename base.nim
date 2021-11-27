import std/terminal;
import osproc;

const
    mapResX: int = 2048
    mapResY: int = 2048;

type
    mapChar = object
        character: char
        backColor: BackgroundColor
        foreColor: ForegroundColor;

var
    map: array[mapResX, array[mapResY, mapChar]]
    firstPosX, firstPosY, lastPosX, lastPosY: int
    padding: bool = false;

# Call this function to create the map
proc initializeMap(xResInp: int, yResInp: int, paddingBool: bool = false) =
#[ xResInp - Horizontal resolution of the map
   yResInp - Vertical resolution of the map
   paddingBool - If true, draw spaces betwen each character to make it look more squaery ]#

    firstPosX = 0;
    firstPosY = 0;
    lastPosX = xResInp-1;
    lastPosY = yResInp-1;

    var blankMapChar : mapChar = mapChar(character : ' ',
                                         backColor : bgBlack,
                                         foreColor : fgWhite);
    
    for i in 0..mapResX-1:
        for ii in 0..mapResY-1:
            map[i][ii] = blankMapChar;
    
    if paddingBool:
        padding = true;

# Draws all the content in the map
proc draw() =
    discard execCmd "clear";
    if not padding:
        for i in 0..lastPosX:
            for ii in 0..lastPosY:
                stdout.write map[i][ii].character;
            stdout.write '\n';
    else:
        for i in 0..lastPosX:
            for ii in 0..lastPosY:
                let str: string = map[i][ii].character & " ";
                stdout.write str;
            stdout.write '\n';

# Puts a character on the map in the specified coordiantes
proc putCharAtMap(posX: int, posY: int, ch: char) =
    map[posY+firstPosY][posX+firstPosX].character = ch; 
    draw();

# Draws a rectangle
proc drawRectangle(posX: int, posY: int, height: int, width: int, ch: char) =
    for i in 0..height-1:
        for ii in 0..width-1:
            putCharAtMap i+posX, ii+posY, ch;
    draw();
