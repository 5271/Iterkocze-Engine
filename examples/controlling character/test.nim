import base;
import debug;
import map;
import std/terminal;

initializeScreen 19, 19, '.';
initializeMap 16, 16, Position(X : 2, Y : 2), ' ';

var pos: Position = Position(X : 0, Y : 0);

while true:
    var previousChar: char = getChar(pos);
    putChar pos, '@';
    var inp = getch();
    putChar pos, previousChar;
    if inp == 'w':
        pos.Y -= 1;
    if inp == 's':
        pos.Y += 1;
    if inp == 'a':
        pos.X -= 1;
    if inp == 'd':
        pos.X += 1;
    if inp == 'q':
        break;