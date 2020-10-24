%{
extern int yyerror(const char *msg);
extern int yylex(void);
%}

%union {
	char *string;
}

%token COMMAND ACTION IGNORE EXECUTE ITEM
%token <string> QSTRING

%%

item:    ITEM command action
    ;
command: /* empty */
       | COMMAND
       ;
action: ACTION IGNORE
      | ACTION EXECUTE QSTRING
      ;

%%
