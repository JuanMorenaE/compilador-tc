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

FinDeRenglon = \r|\n|\r\n

Espacio = \t | \f | [ ]

EspacioGeneral = ({FinDeRenglon})+ | ({Espacio})+

Torneo = \"Mundial[ ][0-9]{4}\"

Equipo =
    "Japón" |
    "Qatar" |
    "Alemania" |
    "Uruguay" |
    "México" |
    "Argentina" |
    "Portugal" |
    "Senegal" |
    "Cabo Frio" |
    "Brasil" |
    "España" |
    "Canadá" |
    "Corea" |
    "Inglaterra" |
    "Francia" |
    "Chile" |
    "Camerún" |
    "Italia" |
    "Países Bajos" |
    "Estados Unidos" |
    "Colombia" |
    "Nigeria" |
    "Australia" |
    "Suiza" |
    "Polonia";

Hora = [0-1][0-9]:[0-5][0-9] | 2[0-3]:[0-5][0-9]

Numero = [0-9][0-9]*

Resultado = {Numero} | [0]

Fecha = [0-9][0-9][0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]

Nombre = [A-Z][a-z]*

Email = [A-Za-z0-9._%+-]+@[A-Za-z]+\.[A-Za-z]+

%%

"Campeonato" { 
    //System.out.println("TOKEN CAMPEONATO: " + yytext()); 
    return symbol(sym.CAMPEONATO); 
}
"Fixture" { 
    //System.out.println("TOKEN FIXTURE: " + yytext()); 
    return symbol(sym.FIXTURE); 
}
"SERIE" { 
    //System.out.println("TOKEN SERIE: " + yytext()); 
    return symbol(sym.SERIE); 
}
"Equipos" [ ]* ":" { 
    //System.out.println("TOKEN PRE_EQUIPOS: " + yytext()); 
    return symbol(sym.PRE_EQUIPOS); 
}
"\[" { 
    //System.out.println("TOKEN CORCHETE_IZQ: " + yytext()); 
    return symbol(sym.CORCHETE_IZQ); 
}
"\]" { 
    //System.out.println("TOKEN CORCHETE_DER: " + yytext()); 
    return symbol(sym.CORCHETE_DER); 
}
\, { 
    //System.out.println("TOKEN COMA: " + yytext()); 
    return symbol(sym.COMA); 
}
"Partido Nro" [ ]* ":" { 
    //System.out.println("TOKEN NRO_PARTIDO: " + yytext()); 
    return symbol(sym.NRO_PARTIDO); 
}
\- { 
    //System.out.println("TOKEN GUION: " + yytext()); 
    return symbol(sym.GUION); 
}
"*-*-*-*-*-*-*-*-*-*-" { 
    //System.out.println("TOKEN SEPARADOR: " + yytext()); 
    return symbol(sym.SEPARADOR); 
}
"Participante:" { 
    //System.out.println("TOKEN PRE_PARTICIPANTE: " + yytext()); 
    return symbol(sym.PRE_PARTICIPANTE); 
}
"Pronósticos Partidos:" { 
    //System.out.println("TOKEN PRONOSTICOS: " + yytext()); 
    return symbol(sym.PRONOSTICOS); 
}
\: { 
    //System.out.println("TOKEN DOSPUNTOS: " + yytext()); 
    return symbol(sym.DOSPUNTOS); 
}
"(X)" { 
    //System.out.println("TOKEN MARCA: " + yytext()); 
    return symbol(sym.MARCA); 
}

"Juego:" {
    //System.out.println("TOKEN JUEGO: " + yytext()); 
    return symbol(sym.JUEGO); 
}

/* ----- Ignorar espacios y saltos ----- */
{FinDeRenglon} {}
{Espacio} {}
{EspacioGeneral} {}
[\r\n\t ]+ {}

/* ----- Tokens con valor ----- */
{Torneo} {
    //System.out.println("TOKEN TORNEO: " + yytext());
    return symbol(sym.TORNEO, yytext());
}
\"([^\"\r\n]*)\" {
    //System.out.println("TOKEN QSTRING: " + yytext());
    return symbol(sym.QSTRING, yytext());
}
{Equipo} {
    //System.out.println("TOKEN EQUIPO: " + yytext());
    return symbol(sym.EQUIPO, yytext());
}
{Hora} {
    //System.out.println("TOKEN HORA: " + yytext());
    return symbol(sym.HORA, yytext());
}
{Numero} {
    Integer numero = Integer.parseInt(yytext());
    //System.out.println("TOKEN NUMERO: " + numero);
    return symbol(sym.NUMERO, numero);
}
{Resultado} {
    //System.out.println("TOKEN RESULTADO: " + yytext());
    return symbol(sym.RESULTADO, yytext());
}
{Fecha} {
    //System.out.println("TOKEN FECHA: " + yytext());
    return symbol(sym.FECHA, yytext());
}
{Nombre} {
    //System.out.println("TOKEN NOMBRE: " + yytext());
    return symbol(sym.NOMBRE, yytext());
}
{Email} {
    //System.out.println("TOKEN EMAIL: " + yytext());
    return symbol(sym.EMAIL, yytext());
}

/* ----- Cualquier otro caracter ilegal ----- */
. {
    System.err.println("CARACTER ILEGAL: '" + yytext() + 
        "' en línea " + (yyline + 1) + ", columna " + (yycolumn + 1));
}