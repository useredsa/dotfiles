/*TODO By order of importance
 * Copy bspc's parser and divide each Shortcut (its docstring, keys and command)
 * into multiple shortcuts when there are {...} blocks. (Removing _)
 * 
 * Running the commands after selecting with rofi or similar.
 */
#include <algorithm>
#include <iostream>
#include <vector>

const int MAX_KEYS_LENGTH = 50;

struct Shortcut {
    std::string docstring;
    std::string keys;
    std::string command;
};

std::vector<Shortcut> scs;

int main() {
    std::string line;
    Shortcut sc;
    while(std::getline(std::cin, line)) {
        if (line.empty()) continue;
        if (line[0] == '#') {
            int docstart = 0;
            while (line[docstart] == '#' or line[docstart] == ' ') {
                ++docstart;
            }
            sc.docstring = line.substr(docstart, line.size()-1);
        } else if (line[0] == '\t') {
            sc.command += line.substr(1, line.size()-1);
            sc.command += '\n';
        } else {
            sc.keys = line;
            sc.command.clear();
            scs.emplace_back(sc);
        }
    }

    int formatlen = 0;
    for (Shortcut& sc : scs) {
        if (sc.keys.size() > MAX_KEYS_LENGTH) {
            sc.keys.resize(MAX_KEYS_LENGTH);
            sc.keys += "…";
        }
        formatlen = std::max(formatlen, (int) sc.keys.size());
    }
    for (Shortcut& sc : scs) {
        sc.keys.resize(formatlen, ' ');
    }

    for (const Shortcut& sc : scs) {
        std::cout << "<small>";
        std::cout << sc.keys << '\t' << sc.docstring;
        std::cout << "</small>\n";
    }
}
