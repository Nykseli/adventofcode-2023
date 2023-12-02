#!/usr/bin/env dub
/+ dub.sdl:
    name "colortest"
    dependency "color" version="~>0.0.3"
+/
import std.stdio : writefln;
import std.file : readText;
import std.string : strip, splitLines, startsWith;
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

int numInLine2(string line) {
    int idx = 0;
    int first = -1;
    int last = -1;

    for (; idx < line.length; idx++) {
        if (line[idx].isNumber()) {
            if (first == -1) {
                first = to!int(line[idx]) - 48;
            } else {
                last = to!int(line[idx]) - 48;
            }
        }

        string sub = line[idx..$];
        int num = 0;
        if (sub.startsWith("one")) {
            num = 1;
        } else if (sub.startsWith("two")) {
            num = 2;
        } else if (sub.startsWith("three")) {
            num = 3;
        } else if (sub.startsWith("four")) {
            num = 4;
        } else if (sub.startsWith("five")) {
            num = 5;
        } else if (sub.startsWith("six")) {
            num = 6;
        } else if (sub.startsWith("seven")) {
            num = 7;
        } else if (sub.startsWith("eight")) {
            num = 8;
        } else if (sub.startsWith("nine")) {
            num = 9;
        } else {
            continue;
        }

        if (first == -1) {
            first = num;
        } else {
            last = num;
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

void part2() {
    // string[] lines = readLines("../example2.txt");
    string[] lines = readLines("../input.txt");
    int total = 0;

    foreach(string line; lines) {
        int lineVal = numInLine2(line);
        total += lineVal;
    }

    writefln("Part 2: %d", total);
}

void main()
{
    part1();
    part2();
}
