import java_cup.runtime.*;

%%
%class Lexer
%unicode
%cup
%line
%column

%{
        private Symbol symbol(int type) {
                return new Symbol(type, yyline, yycolumn);
        }

        private Symbol symbol(int type, Object value) {
            return new Symbol(type, yyline, yycolumn, value);
        }
%}

/* Data Type Regular Expressions */
Comment	= #.*\n|\/#([^#]|#[^\/]|\n)*#\/
Identifier = [a-zA-Z](_|[a-zA-Z]|[0-9])*
Char = [^']
Boolean = T|F
Integer = [1-9][0-9]*|0
Rational = {Integer}\/[1-9][0-9]*|{Integer}_{Integer}\/[1-9][0-9]*
Float = {Integer}\.[0-9][0-9]*
Whitespace = \r|\n|\r\n|" "|"\t"
String = [^\"]*

%%
<YYINITIAL> {
  	/* Key Words */
        "main"          { return symbol(sym.MAIN);      }
        "char"		{ return symbol(sym.TCHAR);     }
        "bool" 		{ return symbol(sym.TBOOL);     }
        "int"           { return symbol(sym.TINT);      }
        "rat"           { return symbol(sym.TRAT);      }
        "float"         { return symbol(sym.TFLOAT);    }
        "dict"          { return symbol(sym.DICT);      }
        "seq"           { return symbol(sym.SEQ);       }
        "tdef"          { return symbol(sym.TDEF);      }
        "alias"         { return symbol(sym.ALIAS);     }
        "fdef"          { return symbol(sym.FDEF);      }
        "if"            { return symbol(sym.IF);        }
        "then"          { return symbol(sym.THEN);      }
        "else"          { return symbol(sym.ELSE);      }
        "fi"            { return symbol(sym.FI);        }
        "loop"          { return symbol(sym.LOOP);      }
        "pool"          { return symbol(sym.POOL);      }
        "break"         { return symbol(sym.BREAK);     }
        "return"        { return symbol(sym.RETURN);    }
        "read"          { return symbol(sym.READ);      }
        "print"         { return symbol(sym.PRINT);     }
        "len"           { return symbol(sym.LEN);       }
        "top"           { return symbol(sym.TOP);       }

  	/* Separators */
        "!"             { return symbol(sym.NOT);       }
        "&&"            { return symbol(sym.AND);       }
        "||"            { return symbol(sym.OR);        }
        "=>"            { return symbol(sym.IMPLY);     }
        "+"             { return symbol(sym.ADD);       }
        "-"             { return symbol(sym.SUB);       }
        "*"             { return symbol(sym.MULT);      }
        "/"             { return symbol(sym.DIV);       }
        "^"             { return symbol(sym.POWER);     }
        "in"            { return symbol(sym.IN);        }
        ":"             { return symbol(sym.COL);       }
        "::"            { return symbol(sym.DCOL);      }
        "<"             { return symbol(sym.LESSTHN);   }
        "<="            { return symbol(sym.LESSEQ);    }
        ">"             { return symbol(sym.MORETHN);   }
        ">="            { return symbol(sym.MOREEQ);    }
        "="             { return symbol(sym.EQ);        }
        "!="            { return symbol(sym.NOTEQ);     }
        ":="            { return symbol(sym.ASSIGN);    }
        "(" 		{ return symbol(sym.LPAR);	  }
        ")" 		{ return symbol(sym.RPAR);	  }
        "{" 		{ return symbol(sym.LCURL);	  }
        "}" 		{ return symbol(sym.RCURL);     }
        "[" 	      { return symbol(sym.LSQR);	  }
        "]" 	      { return symbol(sym.RSQR);	  }
        "." 		{ return symbol(sym.DOT);	  }
        ";" 		{ return symbol(sym.SEMICOL);	  }
        "?" 		{ return symbol(sym.EVAL);	  }
        "," 		{ return symbol(sym.COMMA);	  }

  	/* Data Types */
        {Comment}        { /*return nothing*/ 																	 }
        {Rational}       { return symbol(sym.RAT, yytext());                     }
        {Float}          { return symbol(sym.FLOAT, Float.parseFloat(yytext())); }
        {Integer}        { return symbol(sym.INT, Integer.parseInt(yytext()));   }
        {Boolean}        { return symbol(sym.BOOL, yytext());                    }
        "'"{Char}"'"     { return symbol(sym.CHAR, yytext());                    }
        "\""{String}"\"" { return symbol(sym.CHAR, yytext());                    }
        {Identifier}     { return symbol(sym.IDENT, yytext());                   }
        {Whitespace}     { /* do nothing */                                      }
}