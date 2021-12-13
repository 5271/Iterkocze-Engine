import base;
import debug;
import map;
import std/terminal;

initializeScreen 19, 11, '.';
initializeMap 8, 8, Position(X : 2, Y : 2), ' ', true;
drawRectangle(Position(X : 2, Y : 2), 2, 4, '#');

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