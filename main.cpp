#include <iostream>
#include <cstring>
#include <stdexcept>
#include <string>
#include <iomanip>
#include <fstream>
#include <algorithm>
#include <stdexcept>

#include "pronounce_dict.h"
#include "cartalk_puzzle.h"
#include "anagram_dict.h"
#include "common_words.h"
#include "catch_config.h"
#include "fib.h"

#define contains(a, b) count(a.begin(), a.end(), b)

using namespace std;

TEST_CASE("fib") {
    REQUIRE(memoized_fib(45) == 1134903170);
}

TEST_CASE("homophones") {
    vector<StringTriple> result = cartalk_puzzle(PronounceDict("given_txts/cmudict.0.7a"), "given_txts/words.txt");
    int found = 0;
    for (StringTriple &t : result) {
        if (get<0>(t) == "scent") {
            found = 1;
            REQUIRE((get<1>(t) == "sent" || get<2>(t) == "sent"));
            REQUIRE((get<1>(t) == "cent" || get<2>(t) == "cent"));
            break;
        }
    }
    REQUIRE(found == 1);
}

TEST_CASE("find_common_words") {
    SECTION("small texts") {
        CommonWords cw({"given_txts/small1.txt", "given_txts/small2.txt"});
        vector<string> words = cw.get_common_words(3);
        REQUIRE(contains(words, "dog"));
        REQUIRE(contains(words, "pig"));
    }
    SECTION("PrideAndPrejudice.txt Beowulf.txt SherlockHolmes.txt") {
        CommonWords cw({"given_txts/PrideAndPrejudice.txt", "given_txts/Beowulf.txt", "given_txts/SherlockHolmes.txt"});
        vector<string> words = cw.get_common_words(500);
        REQUIRE(contains(words, "and"));
        REQUIRE(contains(words, "in"));
        REQUIRE(contains(words, "of"));
        REQUIRE(contains(words, "the"));
        REQUIRE(contains(words, "to"));
    }
}

TEST_CASE("anagrams") {
    AnagramDict dict("given_txts/words.txt");
    vector<string> anagrams = dict.get_anagrams("dog");
    REQUIRE(contains(anagrams, "god"));
}