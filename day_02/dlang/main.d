#!/usr/bin/env dub
/+ dub.sdl:
    name "main"
+/
import std.stdio : writefln;
import std.array : split;
import std.file : readText;
import std.string : strip, splitLines, startsWith;
import std.uni : isNumber;
import std.conv : to, parse;

string[] readLines(string path) {
    string text = readText(path);
    return text.strip().splitLines();
}

int[string][][] parseGames(string[] lines) {
    int[string][][] games;

    foreach (string line; lines) {
        string[] sets = line.split(": ")[1].split("; ");
        int[string][] game;

        foreach (string set; sets) {
            int[string] pairs;
            foreach (string pair; set.split(", ")){
                string[] valKey = pair.split();
                pairs[to!string(valKey[1])] = to!int(valKey[0]);
            }
            game ~= pairs;
        }
        games ~= game;
    }

    return games;
}

bool playGame(int[string][] game, int red, int green, int blue) {
    foreach (int[string] pair; game) {
        int pred = pair.get("red", 0);
        int pblue = pair.get("blue", 0);
        int pgreen = pair.get("green", 0);
        if (pred > red) {
            return false;
        } else if (pblue > blue) {
            return false;
        } else if (pgreen > green) {
            return false;
        }
    }

    return true;
}

int minGame(int[string][] game) {
    int minRed = 1;
    int minBlue = 1;
    int minGreen = 1;

    foreach (int[string] pair; game) {
        int pred = pair.get("red", 0);
        int pblue = pair.get("blue", 0);
        int pgreen = pair.get("green", 0);
        if (pred > minRed) {
            minRed = pred;
        }
        if (pblue > minBlue) {
            minBlue = pblue;
        }
        if (pgreen > minGreen) {
            minGreen = pgreen;
        }
    }

    return minRed * minBlue * minGreen;
}

void part1() {
    // string[] lines = readLines("../example1.txt");
    string[] lines = readLines("../input.txt");

    int[string][][] games = parseGames(lines);
    int total = 0;
    int game_num = 1;
    foreach (int[string][] game; games) {
        if (playGame(game, 12, 13, 14)) {
            total += game_num;
        }

        game_num++;
    }

    writefln("Part 1: %s", total);
}

void part2() {
    // string[] lines = readLines("../example1.txt");
    string[] lines = readLines("../input.txt");
    int[string][][] games = parseGames(lines);
    int total = 0;

    foreach (int[string][] game; games) {
        total += minGame(game);
    }

    writefln("Part 2: %s", total);
}

void main() {
    part1();
    part2();
}
