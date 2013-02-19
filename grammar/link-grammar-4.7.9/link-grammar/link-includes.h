/*************************************************************************/
/* Copyright (c) 2004                                                    */
/* Daniel Sleator, David Temperley, and John Lafferty                    */
/* All rights reserved                                                   */
/*                                                                       */
/* Use of the link grammar parsing system is subject to the terms of the */
/* license set forth in the LICENSE file included with this software,    */
/* and also available at http://www.link.cs.cmu.edu/link/license.html    */
/* This license allows free redistribution and use in source and binary  */
/* forms, with or without modification, subject to certain conditions.   */
/*                                                                       */
/*************************************************************************/
#ifndef _LINKINCLUDESH_
#define _LINKINCLUDESH_

#include <link-grammar/link-features.h>

LINK_BEGIN_DECLS

#if  __GNUC__ > 2
#define GNUC_DEPRECATED __attribute__((deprecated))
#else
#define GNUC_DEPRECATED
#endif

/**********************************************************************
 *
 * System initialization
 *
 ***********************************************************************/

typedef struct Dictionary_s * Dictionary;

link_public_api(const char *)
	linkgrammar_get_version(void);

link_public_api(const char *)
	linkgrammar_get_dict_version(Dictionary);

/**********************************************************************
 *
 * Functions to manipulate Dictionaries
 *
 ***********************************************************************/

link_public_api(Dictionary)
     dictionary_create_lang(const char * lang);
link_public_api(Dictionary)
     dictionary_create_default_lang(void);

link_public_api(int)
     dictionary_delete(Dictionary dict);
link_public_api(int)
     dictionary_get_max_cost(Dictionary dict);

link_public_api(void)
     dictionary_set_data_dir(const char * path);
link_public_api(char *)
     dictionary_get_data_dir(void);

/**********************************************************************
 *
 * Functions to manipulate Parse Options
 *
 ***********************************************************************/

typedef enum
{
	VDAL=1, /* Sort by Violations, Disjunct cost, And cost, Link cost */
	CORPUS, /* Sort by Corpus cost */
} Cost_Model_type;

typedef struct Parse_Options_s * Parse_Options;

link_public_api(Parse_Options)
     parse_options_create(void);
link_public_api(int)
     parse_options_delete(Parse_Options opts);
link_public_api(void)
     parse_options_set_verbosity(Parse_Options opts, int verbosity);
link_public_api(int)
     parse_options_get_verbosity(Parse_Options opts);
link_public_api(void)
     parse_options_set_linkage_limit(Parse_Options opts, int linkage_limit);
link_public_api(int)
     parse_options_get_linkage_limit(Parse_Options opts);
link_public_api(void)
     parse_options_set_disjunct_cost(Parse_Options opts, int disjunct_cost);
link_public_api(void)
     parse_options_set_disjunct_costf(Parse_Options opts, float disjunct_cost);
link_public_api(int)
     parse_options_get_disjunct_cost(Parse_Options opts);
link_public_api(float)
     parse_options_get_disjunct_costf(Parse_Options opts);
link_public_api(void)
     parse_options_set_min_null_count(Parse_Options opts, int null_count);
link_public_api(int)
     parse_options_get_min_null_count(Parse_Options opts);
link_public_api(void)
     parse_options_set_max_null_count(Parse_Options opts, int null_count);
link_public_api(int)
     parse_options_get_max_null_count(Parse_Options opts);
link_public_api(void)
     parse_options_set_null_block(Parse_Options opts, int null_block);
link_public_api(int)
     parse_options_get_null_block(Parse_Options opts);
link_public_api(void)
     parse_options_set_islands_ok(Parse_Options opts, int islands_ok);
link_public_api(int)
     parse_options_get_islands_ok(Parse_Options opts);
link_public_api(void)
     parse_options_set_spell_guess(Parse_Options opts, int spell_guess);
link_public_api(int)
     parse_options_get_spell_guess(Parse_Options opts);
link_public_api(void)
     parse_options_set_short_length(Parse_Options opts, int short_length);
link_public_api(int)
     parse_options_get_short_length(Parse_Options opts);
link_public_api(void)
     parse_options_set_max_memory(Parse_Options  opts, int mem);
link_public_api(int)
     parse_options_get_max_memory(Parse_Options opts);
link_public_api(void)
     parse_options_set_max_sentence_length(Parse_Options  opts, int len);
link_public_api(int)
     parse_options_get_max_sentence_length(Parse_Options opts);
link_public_api(void)
     parse_options_set_max_parse_time(Parse_Options  opts, int secs);
link_public_api(int)
     parse_options_get_max_parse_time(Parse_Options opts);
link_public_api(void)
     parse_options_set_cost_model_type(Parse_Options opts, Cost_Model_type cm);
link_public_api(Cost_Model_type)
     parse_options_get_cost_model_type(Parse_Options opts);
link_public_api(void)
     parse_options_set_use_fat_links(Parse_Options opts, int use_fat_links);
link_public_api(int)
     parse_options_get_use_fat_links(Parse_Options opts);
link_public_api(void)
     parse_options_set_use_sat_parser(Parse_Options opts, int use_sat_solver);
link_public_api(int)
     parse_options_get_use_sat_parser(Parse_Options opts);
link_public_api(void)
     parse_options_set_use_viterbi(Parse_Options opts, int use_viterbi);
link_public_api(int)
     parse_options_get_use_viterbi(Parse_Options opts);
link_public_api(int)
     parse_options_timer_expired(Parse_Options opts);
link_public_api(int)
     parse_options_memory_exhausted(Parse_Options opts);
link_public_api(int)
     parse_options_resources_exhausted(Parse_Options opts);
link_public_api(void)
     parse_options_set_screen_width(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_screen_width(Parse_Options opts);
link_public_api(void)
     parse_options_set_allow_null(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_allow_null(Parse_Options opts);
link_public_api(void)
     parse_options_set_use_cluster_disjuncts(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_use_cluster_disjuncts(Parse_Options opts);
link_public_api(void)
     parse_options_set_display_walls(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_display_walls(Parse_Options opts);
link_public_api(void)
     parse_options_set_all_short_connectors(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_all_short_connectors(Parse_Options opts);
link_public_api(void)
     parse_options_reset_resources(Parse_Options opts);


/**********************************************************************
 *
 * The following Parse_Options functions do not directly affect the
 * operation of the parser, but they can be useful for organizing the
 * search, or displaying the results.  They were included as switches for
 * convenience in implementing the "standard" version of the link parser
 * using the API.
 *
 ***********************************************************************/

typedef enum
{
	NO_DISPLAY = 0,        /** Display is disabled */
	MULTILINE = 1,         /** multi-line, indented display */
	BRACKET_TREE = 2,      /** single-line, bracketed tree */
	SINGLE_LINE = 3,       /** single line, round parenthesis */
   MAX_STYLES = 3         /* this must always be last, largest */
} ConstituentDisplayStyle;


link_public_api(void)
     parse_options_set_batch_mode(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_batch_mode(Parse_Options opts);
link_public_api(void)
     parse_options_set_panic_mode(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_panic_mode(Parse_Options opts);
link_public_api(void)
     parse_options_set_display_on(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_display_on(Parse_Options opts);
link_public_api(void)
     parse_options_set_display_postscript(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_display_postscript(Parse_Options opts);
link_public_api(void)
     parse_options_set_display_constituents(Parse_Options opts, ConstituentDisplayStyle val);
link_public_api(ConstituentDisplayStyle)
     parse_options_get_display_constituents(Parse_Options opts);
link_public_api(void)
     parse_options_set_display_bad(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_display_bad(Parse_Options opts);
link_public_api(void)
     parse_options_set_display_disjuncts(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_display_disjuncts(Parse_Options opts);
link_public_api(void)
     parse_options_set_display_links(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_display_links(Parse_Options opts);
link_public_api(void)
     parse_options_set_display_senses(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_display_senses(Parse_Options opts);
link_public_api(void)
     parse_options_set_display_union(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_display_union(Parse_Options opts);
link_public_api(void)
     parse_options_set_echo_on(Parse_Options opts, int val);
link_public_api(int)
     parse_options_get_echo_on(Parse_Options opts);

/**********************************************************************
 *
 * Functions to manipulate Sentences
 *
 ***********************************************************************/

typedef struct Sentence_s * Sentence;

link_public_api(Sentence)
     sentence_create(const char *input_string, Dictionary dict);
link_public_api(void)
     sentence_delete(Sentence sent);
link_public_api(int)
     sentence_split(Sentence sent, Parse_Options opts);
link_public_api(int)
     sentence_parse(Sentence sent, Parse_Options opts);
link_public_api(int)
     sentence_length(Sentence sent);
link_public_api(const char *)
     sentence_get_word(Sentence sent, int wordnum);
link_public_api(int)
     sentence_null_count(Sentence sent);
link_public_api(int)
     sentence_num_linkages_found(Sentence sent);
link_public_api(int)
     sentence_num_valid_linkages(Sentence sent);
link_public_api(int)
     sentence_num_linkages_post_processed(Sentence sent);
link_public_api(int)
     sentence_num_thin_linkages(Sentence sent);
link_public_api(int)
     sentence_num_violations(Sentence sent, int i);
link_public_api(int)
     sentence_and_cost(Sentence sent, int i);
link_public_api(int)
     sentence_disjunct_cost(Sentence sent, int i);
link_public_api(int)
     sentence_link_cost(Sentence sent, int i);

link_public_api(int)
     sentence_contains_conjunction(Sentence sent);

/**********************************************************************
 *
 * Functions that create and manipulate Linkages.
 * When a Linkage is requested, the user is given a
 * copy of all of the necessary information, and is responsible
 * for freeing up the storage when he/she is finished, using
 * the routines provided below.
 *
 ***********************************************************************/

typedef struct Linkage_s * Linkage;

link_public_api(Linkage)
     linkage_create(int index, Sentence sent, Parse_Options opts);
link_public_api(int) 
     linkage_get_current_sublinkage(const Linkage linkage); 
link_public_api(int)
     linkage_set_current_sublinkage(Linkage linkage, int index);
link_public_api(void)
     linkage_delete(Linkage linkage);
link_public_api(Sentence)
     linkage_get_sentence(const Linkage linkage);
link_public_api(int)
     linkage_get_num_sublinkages(const Linkage linkage);
link_public_api(int)
     linkage_get_num_words(const Linkage linkage);
link_public_api(int)
     linkage_get_num_links(const Linkage linkage);
link_public_api(int)
     linkage_get_link_lword(const Linkage linkage, int index);
link_public_api(int)
     linkage_get_link_rword(const Linkage linkage, int index);
link_public_api(int)
     linkage_get_link_length(const Linkage linkage, int index);
link_public_api(const char *)
     linkage_get_link_label(const Linkage linkage, int index);
link_public_api(const char *)
     linkage_get_link_llabel(const Linkage linkage, int index);
link_public_api(const char *)
     linkage_get_link_rlabel(const Linkage linkage, int index);
link_public_api(int)
     linkage_get_link_num_domains(const Linkage linkage, int index);
link_public_api(const char **)
     linkage_get_link_domain_names(const Linkage linkage, int index);
link_public_api(const char **)
     linkage_get_words(const Linkage linkage);
link_public_api(const char *)
     linkage_get_disjunct_str(const Linkage linkage, int w);
link_public_api(double)
     linkage_get_disjunct_cost(const Linkage linkage, int w);
link_public_api(double)
     linkage_get_disjunct_corpus_score(const Linkage linkage, int w);
link_public_api(const char *)
     linkage_get_word(const Linkage linkage, int w);
link_public_api(char *)
     linkage_print_disjuncts(const Linkage linkage);
link_public_api(void)
     linkage_free_disjuncts(char *str);
link_public_api(char *)
     linkage_print_links_and_domains(const Linkage linkage);
link_public_api(void)
     linkage_free_links_and_domains(char *str);
link_public_api(char *)
     linkage_print_senses(Linkage linkage);
link_public_api(void)
     linkage_free_senses(char *str);
link_public_api(char *)
     linkage_print_constituent_tree(Linkage linkage, ConstituentDisplayStyle mode);
link_public_api(void)
     linkage_free_constituent_tree_str(char *str);
link_public_api(char *)
     linkage_print_postscript(Linkage linkage, int mode);
link_public_api(void)
     linkage_free_postscript(char * str);
link_public_api(char *)
     linkage_print_diagram(const Linkage linkage);
link_public_api(void)
     linkage_free_diagram(char * str);
link_public_api(int)
     linkage_compute_union(Linkage linkage);
link_public_api(int)
     linkage_is_fat(const Linkage linkage);
link_public_api(int)
     linkage_unused_word_cost(const Linkage linkage);
link_public_api(int)
     linkage_disjunct_cost(const Linkage linkage);
link_public_api(int)
     linkage_and_cost(const Linkage linkage);
link_public_api(int)
     linkage_link_cost(const Linkage linkage);
link_public_api(double)
     linkage_corpus_cost(const Linkage linkage);
link_public_api(int)
     linkage_is_canonical(const Linkage linkage);
link_public_api(int)
     linkage_is_improper(const Linkage linkage);
link_public_api(int)
     linkage_has_inconsistent_domains(const Linkage linkage);
link_public_api(const char *)
     linkage_get_violation_name(const Linkage linkage);


/**********************************************************************
 *
 * Functions that allow special-purpose post-processing of linkages
 *
 ***********************************************************************/

typedef struct Postprocessor_s PostProcessor;

link_public_api(PostProcessor *)
     post_process_open(const char *path);
link_public_api(void)
     post_process_close(PostProcessor *);
link_public_api(void)
     linkage_post_process(Linkage, PostProcessor *);

/**********************************************************************
 *
 * Constituent node
 *
 ***********************************************************************/

typedef struct CNode_s CNode;

link_public_api(CNode *)
     linkage_constituent_tree(Linkage linkage);
link_public_api(void)
     linkage_free_constituent_tree(CNode * n);
link_public_api(const char *)
     linkage_constituent_node_get_label(const CNode *n);
link_public_api(CNode *)
     linkage_constituent_node_get_child(const CNode *n);
link_public_api(CNode *)
     linkage_constituent_node_get_next(const CNode *n);
link_public_api(int)
     linkage_constituent_node_get_start(const CNode *n);
link_public_api(int)
     linkage_constituent_node_get_end(const CNode *n);

/**********************************************************************
 *
 * Internal functions -- do not use these in new code!
 * These are not intended for general public use, but are required to 
 * work around certain Micorsoft Windows linking oddities
 * (specifically, to be callable from the JNI bindings library.)
 *
 ***********************************************************************/

link_public_api(void)
     parse_options_print_total_time(Parse_Options opts);

#if     __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ > 4)
#define GNUC_PRINTF( format_idx, arg_idx )    \
  __attribute__((__format__ (__printf__, format_idx, arg_idx)))
#else
#define GNUC_PRINTF( format_idx, arg_idx )
#endif

link_public_api(void)
     prt_error(const char *fmt, ...) GNUC_PRINTF(1,2);

/*******************************************************
 *
 * Obsolete functions -- do not use these in new code!
 * XXX TBD: These will all go away in Version 5.0.
 *
 ********************************************************/

/* Fails to include the regex file name, which is needed in any
 * practical application.  Thus, this call is deprecated.
 * XXX TBD: this will go away in Version 5.0. */
link_public_api(Dictionary)
     dictionary_create(const char * dict_name,
                       const char * pp_name,
                       const char * cons_name,
                       const char * affix_name);

/* Both are deprecated, exported only for backwards-compat w/Java API. */
link_public_api(int)
     dictionary_is_past_tense_form(Dictionary dict, const char * str);
link_public_api(int)
     dictionary_is_entity(Dictionary dict, const char * str);

/* Identical to sentence_get_word()
 * XXX TBD: make this go away in Version 5.0. */
link_public_api(const char *)
     sentence_get_nth_word(Sentence sent, int i) GNUC_DEPRECATED;

/* Who uses this function, anyway? How did this get exported?
 * XXX TBD: make this go away in Version 5.0. */
link_public_api(int)
     sentence_nth_word_has_disjunction(Sentence sent, int i); // GNUC_DEPRECATED;

/* This is not intended for general use; its specific to the internals
 * of the command-line client.  It was exported by accident.
 * XXX TBD: make this go away in Version 5.0. */
link_public_api(int)
     issue_special_command(const char * line, Parse_Options opts, Dictionary dict);

/* These are obsolete, and do nothing.
 * XXX TBD: make these go away in Version 5.0. */
link_public_api(void)
     lperror_clear(void) GNUC_DEPRECATED;
extern link_public_api(int)
     lperrno;
extern link_public_api(char)
     lperrmsg[];

LINK_END_DECLS

#endif
