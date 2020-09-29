%option nounput noinput
%{
#include <assert.h>
#include <search.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

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

struct word
{
	const char *text;
	enum word_type type;
};

int            word_cmp(const void *a, const void* b);
enum word_type word_lookup(const char *s);
bool           word_add(enum word_type t, const char *s);
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
	if (g_state == LOOKUP)
		printf("%s: %s\n",
			yytext, word_type_names[word_lookup(yytext)]);
	else
	{
		printf("Adding %s\n", word_type_names[g_state]);
		word_add(g_state, yytext);
	}
}

.		/* ignore */ ;
%%

int word_cmp(const void *a, const void* b)
{
	const struct word *u = a, *v = b;
	return strcmp(u->text, v->text);
}

enum word_type
word_lookup(const char *s)
{
	struct word w = { .text = s },
		*elt = tfind(&w, &g_words, word_cmp);
	printf("Root: %p, Elt: %p, Word: %s, Type: %s\n",
		g_words, (void*)elt, elt ? elt->text : "<>",
		elt ? word_type_names[elt->type] : "<>");
	return elt ? elt->type : LOOKUP;
}

bool word_add(enum word_type t, const char *s)
{
	assert(t);
	if (word_lookup(s))
	{
		printf("WARNING: word %s already defined\n", s);
		return false;
	}

	struct word *w = malloc(sizeof *w);
	if (!w) abort();
	*w = (struct word){ .text = strdup(s), .type = t };
	if (!w->text) abort();

	return tsearch(w, &g_words, word_cmp);
}

int main(void)
{
	yylex();
	return 0;
}