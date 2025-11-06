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

Torneo = "Mundial" | "Copa America"

Grupo = [A-Z]

Equipo = "Japón" | "Qatar" | "Alemania" | "Uruguay" | "México" | "Argentina" | "Portugal" | "Senegal" | "Cabo Frio" | "Francia"

Estadio = "Estadio Monumental" | "Azteca Stadium" | "Antelcito Arena" |  "Estadio Porahi"

Hora = [0-1][0-9]:[0-5][0-9] | 2[0-3]:[0-5][0-9]

Numero = [1-9][0-9]*

Resultado = {Numero} | [0]

Fecha = [0-9][0-9][0-9][0-9]\/[0-9][0-9]\/[0-9][0-9]

Nombre = [A-Z][a-z]*

Apellido = [A-Z][a-z]*

Email = [A-Za-z0-9._%+-]+@[A-Za-z]+\.[A-Za-z]+

%%

"Campeonato"            {return symbol(sym.CAMPEONATO);}
"Fixture"               {return symbol(sym.FIXTURE);}
"SERIE"                 {return symbol(sym.SERIE);}
"Grupo" [ ]+            {return symbol(sym.PRE_GRUPO);}
"Equipos" [ ]* ":"      {return symbol(sym.PRE_EQUIPOS);}
"\["                    {return symbol(sym.CORCHETE_IZQ);}
"\]"                    {return symbol(sym.CORCHETE_DER);}
\,                      {return symbol(sym.COMA);}
"Partido Nro" [ ]* ":"  {return symbol(sym.NRO_PARTIDO);}
\-                      {return symbol(sym.GUION);}
"*-*-*-*-*-*-*-*-*-*-"  {return symbol(sym.SEPARADOR);}
"Participante:"         {return symbol(sym.PRE_PARTICIPANTE);}
"Pronósticos Partidos:" {return symbol(sym.PRONOSTICOS);}
\:                      {return symbol(sym.DOSPUNTOS);}
"(X)"                   {return symbol(sym.MARCA);}

{FinDeRenglon}          {}
{Espacio}               {}
{EspacioGeneral}        {}
[\r\n\t ]+              {}

\"([^\"\r\n]*)\"        {return symbol(sym.QSTRING, yytext()); }
{Torneo}                {return symbol(sym.TORNEO, yytext());}
{Grupo}                 {return symbol(sym.LETRA_GRUPO, yytext());}
{Equipo}                {return symbol(sym.EQUIPO, yytext());}
{Estadio}               {return symbol(sym.ESTADIO, yytext());}
{Hora}                  {return symbol(sym.HORA, yytext());}
{Numero}                {return symbol(sym.NUMERO, yytext());}
{Resultado}             {return symbol(sym.RESULTADO, yytext());}
{Fecha}                 {return symbol(sym.FECHA, yytext());}
{Nombre}                {return symbol(sym.NOMBRE, yytext());}
{Apellido}              {return symbol(sym.APELLIDO, yytext());}
{Email}                 {return symbol(sym.EMAIL, yytext());}

.                       {System.err.println("Caracter ilegal '" + yytext() + "' en la línea " + (yyline+1) + ", col " + (yycolumn+1));}