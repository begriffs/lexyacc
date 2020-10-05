%option nounput noinput

%{
#include "symbol_table.h"
#include <stdio.h>

#include "ch1-05.tab.h"

#define LOOKUP 0

int   g_state = LOOKUP;
void *g_words = NULL;
%}

%%

\n		{ g_state = LOOKUP; }
\.\n	{ g_state = LOOKUP; return 0; }

^verb   { g_state = VERB; }
^adj    { g_state = ADJECTIVE; }
^adv    { g_state = ADVERB; }
^noun   { g_state = NOUN; }
^prep   { g_state = PREPOSITION; }
^pron   { g_state = PRONOUN; }
^conj   { g_state = CONJUNCTION; }

[a-zA-Z]+ {
	if (g_state == LOOKUP)
	{
		int type = st_lookup(&g_words, yytext);
		if (type == ST_UNKNOWN)
			printf("%s unknown\n", yytext);
		else
			return type;
	}
	else
		st_add(&g_words, yytext, g_state);
}

.		/* ignore */ ;

%%
