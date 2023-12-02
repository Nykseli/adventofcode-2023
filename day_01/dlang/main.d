#!/usr/bin/env dub
/+ dub.sdl:
    name "colortest"
    dependency "color" version="~>0.0.3"
+/
import std.stdio : writefln;
import std.file : readText;
import std.string : strip, splitLines;
import std.uni : isNumber;
import std.conv : to;

string[] readLines(string path) {
    string text = readText(path);
    return text.strip().splitLines();
}

int numInLine(string line) {
    int count = 0;
    int first = 0;
    int last = -1;

    foreach(dchar c; line) {
        if (c.isNumber()) {
            if (count == 0) {
                first = to!int(c) - 48;
            } else {
                last = to!int(c) - 48;
            }

            count++;
        }
    }

    if (last != -1) {
        return (first * 10) + last;
    } else {
        return (first * 10) + first;
    }
}

void part1() {
    // string[] lines = readLines("../example1.txt");
    string[] lines = readLines("../input.txt");
    int total = 0;

    foreach(string line; lines) {
        int lineVal = numInLine(line);
        total += lineVal;
    }

    writefln("Part 1: %d", total);
}

void main()
{
    part1();
}
