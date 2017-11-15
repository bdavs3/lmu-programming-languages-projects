#include <iostream>
#include <string>
#include <map>
#include <algorithm>
#include <list>
#include <functional>
#include <set>

using namespace std;

string fullText = "";
char wordEndings[] = {' ', '.', ',', '?', ';', '!', '\'', '"'};
string currentWord = "";
map<string, int> words = { };

int main() {
    for (string line; std::getline(std::cin, line);) {
        fullText += line + " ";
    }
    for(char& c : fullText) {
        if (find(begin(wordEndings), end(wordEndings), c) != end(wordEndings)) {
            if (currentWord != "") {
                transform(currentWord.begin(), currentWord.end(), currentWord.begin(), ::tolower);

                if (words.count(currentWord) == 0) {
                    words.insert(pair<string,int>(currentWord, 1));
                } else {
                    ++words[currentWord];
                }
                currentWord = "";
            }
        } else {
            currentWord += c;
        }
    }
    
    typedef function<bool(pair<string, int>, pair<string, int>)> Comparator;

	Comparator comparisonFunction =
			[](pair<string, int> elem1, pair<string, int> elem2) {
				return elem1.second <= elem2.second;
			};

	set<pair<string, int>, Comparator> setOfWords(
			words.begin(), words.end(), comparisonFunction);

    for (auto it = begin(setOfWords); it != end(setOfWords); ++it) {
        cout << it->first << " " << it->second << " \n";
    }
}
