%{

/* ! C content (headers, declarations, variables and functions as well) */

#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
void showError(char *msg) {
    fprintf(stderr, "%s\n", msg);
    exit(1);
}

%}

/* ! Regular Expressions */

numbers [0-9]+
words [a-zA-Z]+
operators [+-/\*]

%%

/* ! Token Specifications */

numbers  { printf("Found a number: %s\n", yytext); }
words  { printf("Found a word: %s\n", yytext); }
operators { printf("Found an operator: %s\n", yytext); }
";" { printf("Found a semicolon\n") }
\n  { /* ignore new lines */ }
.  { /* ignore any other character */ }

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror(argv[1]);
            exit(1);
        }
    } else {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        exit(1);
    }
    yylex();
    fclose(yyin);
    return 0;
}

int yywrap(void) {
    return 1;
}
