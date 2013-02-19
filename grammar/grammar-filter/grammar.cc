//
// File: grammar/grammar.cc
//
// $Id$
//
// This program is a light-weight application of Link Grammar, written to be
// used by the Emacs Grammar minor mode (grammar.el).
//
// grammar.cc is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
// 
// This file is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
// more details.
// 
// A copy of the GNU General Public License can be made from
// <http://www.gnu.org/licenses/>.
//

#include <locale.h>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>

#include "link-includes.h"

int
parseSentence(std::string & sentence,
              Dictionary & dict,
              Parse_Options & opts)
{
    Sentence      sent;
    Linkage       linkage;
    int           num_linkages;

    // First parse with cost 0 or 1 and no null links.
    parse_options_set_disjunct_cost(opts, 2);
    parse_options_set_min_null_count(opts, 0);
    parse_options_set_max_null_count(opts, 0);
    parse_options_set_islands_ok(opts, 0);
    parse_options_set_panic_mode(opts, true);
    parse_options_reset_resources(opts);
    // parse_options_set_short_length(opts, 10);

    const char * sentText = sentence.c_str();

    sent = sentence_create(sentText, dict);
    sentence_split(sent, opts);
    num_linkages = sentence_parse(sent, opts);

    bool res = (num_linkages >= 1);

    if (parse_options_timer_expired(opts)) {
        std::cout << "timeout" << std::endl << std::endl;
    }
    else if (!res) {
        // Now proces with NULL links. to find out what went wrong.
        parse_options_set_min_null_count(opts, 1);
        parse_options_set_max_null_count(opts, sentence_length(sent));
        parse_options_set_islands_ok(opts, 1);
        parse_options_reset_resources(opts);
        num_linkages = sentence_parse(sent, opts);

        Linkage linkage = linkage_create(0, sent, opts);
        if (linkage != NULL) {
            const char * pos = sentText;
            for (int i = 1; i < sentence_length(sent); i++) {
                while (*pos == ' ' || *pos == '\t') {
                    pos++;
                }
                std::string word = sentence_get_word(sent, i);
		if (!sentence_nth_word_has_disjunction(sent, i) &&
                    word != "RIGHT-WALL" && word != "LEFT-WALL") {
                    std::cout << word << " " << pos - sentText << " ";
                }
                pos += word.size();
            }
        }
        std::cout << std::endl << std::endl;
        linkage_delete(linkage);
    }
    else {
        std::cout << "ok" << std::endl << std::endl;
    }
    return 0;
}


int
main()
{
    Dictionary    dict;
    Parse_Options opts;
    Sentence      sent;
    Linkage       linkage;

    setlocale(LC_ALL, "");
    opts = parse_options_create();
    dictionary_set_data_dir(getenv("HOME"));

    dict = dictionary_create_lang("en");
    if (!dict) {
        std::cout << "Fatal error: Unable to open the dictionary!" << std::endl;
        return 1;
    }

    // Set max parse time to be 1 second.
    parse_options_set_max_parse_time(opts, 1);

    std::string sentence;
    while (true) {
        std::getline(std::cin, sentence);
        if (sentence == "quit") {
            break;
        }
	else if(sentence == "") continue;
        else {
            parseSentence(sentence, dict, opts);
        }
    }

    dictionary_delete(dict);
    parse_options_delete(opts);
    return 0;
}
