import base;
import debug;
import map;

var chars*: array[6, char] = [' ', ' ', ' ', ' ', ' ', ' '];

proc drawBorder*() =
    if not isMapInitialized:
        printError "Can't initialize border without a map";
        return;

    putCharOnScreen Position(X : firstXPos-1, Y : firstYPos-1), chars[2];
    putCharOnScreen Position(X : firstXPos-1, Y : lastYPos+1), chars[3];
    putCharOnScreen Position(X : lastXPos+1, Y : firstYPos-1), chars[4];
    putCharOnScreen Position(X : lastXPos+1, Y : lastYPos+1), chars[5];

    drawRectangleOnScreen Position(X : firstXPos-1, Y : firstYPos), 1, yResMap, chars[1];
    drawRectangleOnScreen Position(X : lastXPos+1, Y : firstYPos), 1, yResMap, chars[1];

    drawRectangleOnScreen Position(X : firstXPos, Y : firstYPos-1), xResMap, 1, chars[0];
    drawRectangleOnScreen Position(X : firstXPos, Y : lastYPos+1), xResMap, 1, chars[0];

# Sets border style to one of the presets
proc initializeBorder* (style: int) =
#[
    style - Id number of the preset styles of the border
]#

    if not isMapInitialized:
        printError "Can't initialize border without a map";
        return;

    case style
        of 1:
            chars[0] = '=';
            chars[1] = '|';
            chars[2] = 'O';
            chars[3] = 'O';
            chars[4] = 'O';
            chars[5] = 'O';

        of 2:
            chars[0] = '-';
            chars[1] = '|';
            chars[2] = 'O';
            chars[3] = 'O';
            chars[4] = 'O';
            chars[5] = 'O';
        
        of 3:
            chars[0] = '=';
            chars[1] = '|';
            chars[2] = '#';
            chars[3] = '#';
            chars[4] = '#';
            chars[5] = '#';

        of 4:
            chars[0] = '-';
            chars[1] = '|';
            chars[2] = '#';
            chars[3] = '#';
            chars[4] = '#';
            chars[5] = '#';

        of 5:
            chars[0] = '\xcd';
            chars[1] = '\xba';
            chars[2] = '\xc9';
            chars[3] = '\xbb';
            chars[4] = '\xc8';
            chars[5] = '\x88';

        else:
            printError "Given border style is invalid";
            return;
        
    drawBorder();

# Sets a custom border style
proc setCustomBorder*(symbols: array[6, char]) =
#[
    symbols - Array of the border's symbols
]#
    for i in 0..chars.len()-1:
        chars[i] = symbols[i]; 