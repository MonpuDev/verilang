module Syntax

extend lang::std::Layout;


//=================================================================
//PALABRAS RESERVADAS
//=================================================================
keyword Reserved =
  "defmodule" | "using"       | "defspace"      | "defoperator"  |
  "defvar"    | "defrule"     | "defexpression" | "defrelation"  |
  "end"       | "forall"      | "exists"        | "in"           |
  "and"       | "or";


//=================================================================
//IDENTIFICADOR
//=================================================================
lexical Id = ([a-zA-Z][a-zA-Z0-9\-]* !>> [a-zA-Z0-9\-]) \ Reserved;


//=================================================================
//PALABRA DE INICIO
//=================================================================
start syntax Programa = programa: Modulo modulo;


//=================================================================
//MODULO
//=================================================================
syntax Modulo = modulo: "defmodule" Id name Importacion* imports Declaracion* decls "end";

syntax Importacion = importacion: "using" Id modName;


//=================================================================
//DECLARACIONES
//=================================================================
syntax Declaracion
  = declEspacio: DeclaracionEspacio s
  | declOperador: DeclaracionOperador op
  | declVariables: DeclaracionVariables v
  | declRegla: DeclaracionRegla r
  | declExpresion: DeclaracionExpresion e
  | declRelacion: DeclaracionRelacion rel
  | declAtributos: DeclaracionAtributos a;

syntax DeclaracionEspacio
  = espacioSimple: "defspace" Id name "end"
  | espacioHerencia: "defspace" Id name "\<" Id parent "end";

syntax DeclaracionOperador
  = defOperadorConAtr: "defoperator" Id name ":" FirmaOperador firma Atributos attrs "end"
  | defOperador: "defoperator" Id name ":" FirmaOperador firma "end";

syntax FirmaOperador = firma: {Id "-\>"}+ tipos;

syntax DeclaracionRelacion = defRelacion: "defrelation" Id name ":" FirmaOperador firma "end";

syntax DeclaracionAtributos = declAtrs: Atributos attrs;

syntax Atributos = atributos: "[" Atributo+ items "]";

syntax Atributo
  = atribSimple: Id name
  | atribValorado: Id name ":" Id value
  | atribVacio: Id name ":" "∅";

syntax DeclaracionVariables = defVar: "defvar" {Variable ","}+ vars "end";

syntax Variable = variable: Id name ":" Id domain;

syntax DeclaracionRegla = defrule: "defrule" "(" Expresion lhs ")" "-\>" "(" Expresion rhs ")" "end";

syntax DeclaracionExpresion
  = defExpresionConAtr: "defexpression" Expresion expr Atributos attrs "end"
  | defExpresion: "defexpression" Expresion expr "end";


//=================================================================
//EXPRESIÓN
//=================================================================
syntax Expresion
  = ident:  Id name
  | paren:  "(" Expresion e ")"
  > left app: Expresion lhs Expresion rhs
  > right exp: Expresion lhs "**" Expresion rhs
  > left (
      mul: Expresion lhs "*" Expresion rhs
    | div: Expresion lhs "/" Expresion rhs
    | modul: Expresion lhs "%" Expresion rhs
  )
  > left (
      add: Expresion lhs "+" Expresion rhs
    | sub: Expresion lhs "-" Expresion rhs
  )
  > non-assoc (
      lt: Expresion lhs "\<" Expresion rhs
    | gt: Expresion lhs "\>" Expresion rhs
    | le: Expresion lhs "\<=" Expresion rhs
    | ge: Expresion lhs "\>=" Expresion rhs
    | eq: Expresion lhs "=" Expresion rhs
    | neq: Expresion lhs "\<\>" Expresion rhs
    | eqv: Expresion lhs "≡" Expresion rhs
    | inDom: Expresion lhs "in" Expresion rhs
  )
  > left andOp: Expresion lhs "and" Expresion rhs
  > left orOp: Expresion lhs "or" Expresion rhs
  > right (
      impl: Expresion lhs "-\>" Expresion rhs
    | implFat: Expresion lhs "=\>" Expresion rhs
  )
  > right (
      forallIn: "forall" Id var "in" Id domain "." Expresion body
    | forallSimple: "forall" Id var "." Expresion body
    | existsIn: "exists" Id var "in" Id domain "." Expresion body
    | existsSimple: "exists" Id var "." Expresion body
  );