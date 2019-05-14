#include "fib.h"
#include "homophone_puzzle.cpp"
#include "find_common_words.cpp"
#include "anagram_finder.cpp"
#include <iostream>
#include <cstring>
#include <stdexcept>
#include "catch_config.h"

using namespace std;

TEST_CASE("fib"){
    REQUIRE(memoized_fib(45)==1134903170);
}

TEST_CASE("homophones")
{
    vector<StringTriple> result1 = cartalk_puzzle(PronounceDict("cmudict.0.7a"), "words.txt");
    int found = 0;
    for (StringTriple& t : result1) {
        if(get<0>(t) == "scent"){
            found = 1;
            REQUIRE((get<1>(t) == "sent" || get<2>(t) == "sent"));
            REQUIRE((get<1>(t) == "cent" || get<2>(t) == "cent"));
            break;
        }
    }
    REQUIRE(found);
}

