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

/* -----Tokens----- */

%%

FinDeRenglon = \r|\n|\r\n

Espacio = [FinDeRenglon]+ | [\t\f]

Torneo = "Mundial" | "Copa America"

Equipo = "Japón" | "Qatar" | "Alemania" | "Uruguay" | "México" | "Argentina" | "Portugal" | "Senegal" | "Cabo Frío" | "Francia"

Estadio = "Estadio Monumental" | "Azteca Stadium" | "Antelcito Arena" |  "Estadio Porahi" |

Hora = [0-1][0-9]:[0-5][0-9] | 2[0-4]:[0-5][0-9]

Numero = [1-9][0-9]*

Resultado = Numero

Fecha = [0-9]{4}/[0-9]{2}/[0-9]{2}

Email = [A-Za-z0-9._%+-]+@[A-Za-z]+\.[A-Za-z]+

<YYINITIAL> {

}