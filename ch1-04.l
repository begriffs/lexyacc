%option nounput noinput
%{
#include <assert.h>
#include <search.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#include "symbol_table.h"

#define WORDTYPES              \
	X(LOOKUP=0, "unknown")     \
	X(VERB,     "verb")        \
	X(ADJ,      "adjective")   \
	X(ADV,      "adverb")      \
	X(NOUN,     "noun")        \
	X(PREP,     "preposition") \
	X(PRON,     "pronoun")     \
	X(CONJ,     "conjugation")

enum word_type
{
#define X(tag, name) tag,
	WORDTYPES
#undef X
} g_state = LOOKUP;

const char *word_type_names[] = {
#define X(tag, name) name,
	WORDTYPES
#undef X
};

void *g_words = NULL;
%}

%%
\n		{ g_state = LOOKUP; }

^verb   { g_state = VERB; }
^adj    { g_state = ADJ; }
^adv    { g_state = ADV; }
^noun   { g_state = NOUN; }
^prep   { g_state = PREP; }
^pron   { g_state = PRON; }
^conj   { g_state = CONJ; }

[a-zA-Z]+ {
	struct st_symbol *s;
	if (g_state == LOOKUP)
	{
		s = st_find(&g_words, yytext);
		printf("%s: %s\n",
			yytext, word_type_names[s ? s->type : LOOKUP]);
	}
	else
	{
		printf("Recording %s\n", word_type_names[g_state]);
		s = st_search(&g_words, yytext);
		s->type = g_state;
	}
}

.		/* ignore */ ;
%%

int main(void)
{
	yylex();
	st_free(&g_words);
	return 0;
}
