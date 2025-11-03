import java_cup.runtime.*;

%%
%class Scanner
%cup
%line
%column
%unicode

%{
    private Symbol symbol(int type){
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value){
        return new Symbol(type, yyline, yycolumn, value);
    }
%}
/*  \t -> Es como mete un tab
    \f -> Es un salto de pagina
    \r -> retorno de carro (no se q es)
    \n -> salto de linea de toda la vida
*/
FinDeRenglon = \r|\n|\r\n
Espacio = [FinDeRenglon]+ | [\t\f]
