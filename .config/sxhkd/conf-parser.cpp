/*TODO By order of importance
 * Copy bspc's parser and divide each Shortcut (its docstring, chain and command)
 * into multiple shortcuts when there are {...} blocks. (Removing _)
 * 
 * Running the commands after selecting with rofi or similar.
 */
#include <algorithm>
#include <iostream>
#include <vector>

// Extracted from sxhkd/src/parse.h

const char START_COMMENT  =  '#';
const char MAGIC_INHIBIT  =  '\\';
const char PARTIAL_LINE   =  '\\';
const std::string GRP_SEP =  ":";
const std::string LNK_SEP =  ";" + GRP_SEP;
const std::string SYM_SEP =  "+ ";
const char SEQ_BEGIN      =  '{';
const char SEQ_END        =  '}';
const std::string SEQ_SEP =  ",";
const char SEQ_NONE       =  '_';

const int MAX_CHAIN_LENGTH = 256;
const int MAX_DOCSTRING_LENGTH = 256;

struct Shortcut {
    std::string docstring;
    std::string chain;
    std::string command;
};

std::vector<Shortcut> scs;

static inline void ltrim(std::string &s) {
    s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](unsigned char ch) {
        return !std::isspace(ch);
    }));
}

// trim from end (in place)
static inline void rtrim(std::string &s) {
    s.erase(std::find_if(s.rbegin(), s.rend(), [](unsigned char ch) {
        return !std::isspace(ch);
    }).base(), s.end());
}

// Trim spaces from string begin and end in place
static inline void trim(std::string &s) {
    ltrim(s);
    rtrim(s);
}

int main() {
    std::string line;
    Shortcut sc;
    while(std::getline(std::cin, line)) {
        if (line.empty()) continue;
        char first = line[0];
        trim(line);
        bool partial = line.back() == PARTIAL_LINE;
        if (partial) {
            line.erase(line.end()-1);
        }

        if (first == START_COMMENT) {
            line.erase(line.begin());
            trim(line);
            sc.docstring += line;
        } else if (std::isgraph(first)) {
            sc.chain += line;
        } else {
            sc.command += line;

            if (!partial && sc.chain.size() > 0 && sc.command.size() > 0) {
                // process_hotkey(sc);
                scs.push_back(sc);
                sc.docstring.clear();
                sc.chain.clear();
                sc.command.clear();
            }
        }
    }

    int chainFormatLen = 0, docsFormatLen = 0;
    for (Shortcut& sc : scs) {
        if (sc.docstring.size() > MAX_CHAIN_LENGTH) {
            sc.docstring.resize(MAX_CHAIN_LENGTH);
            sc.docstring += "…";
        }
        docsFormatLen = std::max(docsFormatLen, (int) sc.docstring.size());
        if (sc.chain.size() > MAX_CHAIN_LENGTH) {
            sc.chain.resize(MAX_CHAIN_LENGTH);
            sc.chain += "…";
        }
        chainFormatLen = std::max(chainFormatLen, (int) sc.chain.size());
    }
    for (Shortcut& sc : scs) {
        sc.docstring.resize(docsFormatLen, ' ');
        sc.chain.resize(chainFormatLen, ' ');
    }

    for (const Shortcut& sc : scs) {
        std::cout << "<small>";
        std::cout << sc.chain << '\t' << sc.docstring << '\t' << sc.command;
        std::cout << "</small>\n";
    }
}
