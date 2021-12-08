import base;
import debug;
import map;
import std/terminal;

initializeScreen 19, 19, '.';
initializeMap 16, 16, 2, 2, ' ';
drawRectangle 2, 2, 4, 3, '@';
type 
    position = object
        x: int
        y: int;

var pos: position = position(x : 0, y : 0);

while true:
    var previousChar: char = getChar(pos.x, pos.y);
    putChar pos.x, pos.y, '@';
    var inp = getch();
    putChar pos.x, pos.y, previousChar;
    if inp == 'w':
        pos.y -= 1;
    if inp == 's':
        pos.y += 1;
    if inp == 'a':
        pos.x -= 1;
    if inp == 'd':
        pos.x += 1;
    if inp == 'q':
        break;