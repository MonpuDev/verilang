module Generator

import AST;
import IO;
import String;
import List;

// ─── Función Principal de Generación ──────────────────────────────────────────
public void generateTxt(Programa p, loc outputDir, str fileName) {
    str content = pp(p);
    
    // Si la carpeta no existe, Rascal la crea automáticamente al escribir el archivo
    loc outputFile = outputDir + fileName;
    writeFile(outputFile, content);
    
    println("==================================================");
    println(" ¡Generación Exitosa! (Code Generation: Competent)");
    println(" Archivo guardado en: <outputFile>");
    println("==================================================");
}

// ─── Pretty Printers (Reglas de traducción) ───────────────────────────────────

str pp(programa(Modulo m)) = pp(m);

str pp(modulo(str name, list[Importacion] imports, list[Declaracion] decls)) {
    // Intercalamos saltos de línea y tabulaciones para que quede bonito
    str imps = intercalate("\n", [ "  <pp(i)>" | i <- imports ]);
    str decs = intercalate("\n\n", [ "  <pp(d)>" | d <- decls ]);
    
    str res = "defmodule <name>\n";
    if (imps != "") res += imps + "\n\n";
    if (decs != "") res += decs + "\n";
    res += "end\n";
    
    return res;
}

str pp(importacion(str modName)) = "using <modName>";

// Wrapper de Declaraciones
str pp(declEspacio(DeclaracionEspacio s)) = pp(s);
str pp(declOperador(DeclaracionOperador op)) = pp(op);
str pp(declVariables(DeclaracionVariables v)) = pp(v);
str pp(declRegla(DeclaracionRegla r)) = pp(r);
str pp(declExpresion(DeclaracionExpresion e)) = pp(e);
str pp(declRelacion(DeclaracionRelacion reln)) = pp(reln);
str pp(declAtributos(DeclaracionAtributos a)) = pp(a);

// Espacios
str pp(espacioSimple(str name)) = "defspace <name> end";
str pp(espacioHerencia(str name, str parent)) = "defspace <name> \< <parent> end";

// Firmas, Operadores y Relaciones
str pp(firma(list[str] tipos)) = intercalate(" -\> ", tipos);

str pp(defOperadorConAtr(str name, FirmaOperador f, Atributos attrs)) = "defoperator <name> : <pp(f)> <pp(attrs)> end";
str pp(defOperador(str name, FirmaOperador f)) = "defoperator <name> : <pp(f)> end";

str pp(defRelacion(str name, FirmaOperador f)) = "defrelation <name> : <pp(f)> end";

// Atributos
str pp(declAtrs(Atributos attrs)) = pp(attrs);
str pp(atributos(list[Atributo] items)) = "[ " + intercalate(" ", [pp(i) | i <- items]) + " ]";

str pp(atribSimple(str name)) = name;
str pp(atribValorado(str name, str val)) = "<name> : <val>";
str pp(atribVacio(str name)) = "<name> : ∅";

// Variables
str pp(defVar(list[Variable] vars)) = "defvar " + intercalate(", ", [pp(v) | v <- vars]) + " end";
str pp(variable(str name, str domain)) = "<name> : <domain>";

// Reglas y Expresiones Principales
str pp(defrule(Expresion lhs, Expresion rhs)) = "defrule ( <pp(lhs)> ) -\> ( <pp(rhs)> ) end";

str pp(defExpresionConAtr(Expresion expr, Atributos attrs)) = "defexpression \n    <pp(expr)> \n  <pp(attrs)> end";
str pp(defExpresion(Expresion expr)) = "defexpression \n    <pp(expr)> \n  end";

// Expresiones y Operadores
str pp(ident(str name)) = name;
str pp(paren(Expresion e)) = "( <pp(e)> )";

str pp(forallIn(str var, str domain, Expresion body)) = "forall <var> in <domain> . <pp(body)>";
str pp(forallSimple(str var, Expresion body)) = "forall <var> . <pp(body)>";
str pp(existsIn(str var, str domain, Expresion body)) = "exists <var> in <domain> . <pp(body)>";
str pp(existsSimple(str var, Expresion body)) = "exists <var> . <pp(body)>";

str pp(app(Expresion lhs, Expresion rhs)) = "<pp(lhs)> <pp(rhs)>";
str pp(exp(Expresion lhs, Expresion rhs)) = "<pp(lhs)> ** <pp(rhs)>";
str pp(mul(Expresion lhs, Expresion rhs)) = "<pp(lhs)> * <pp(rhs)>";
str pp(div(Expresion lhs, Expresion rhs)) = "<pp(lhs)> / <pp(rhs)>";
str pp(modul(Expresion lhs, Expresion rhs)) = "<pp(lhs)> % <pp(rhs)>";
str pp(add(Expresion lhs, Expresion rhs)) = "<pp(lhs)> + <pp(rhs)>";
str pp(sub(Expresion lhs, Expresion rhs)) = "<pp(lhs)> - <pp(rhs)>";

// Lógica y Comparadores
str pp(lt(Expresion lhs, Expresion rhs)) = "<pp(lhs)> \< <pp(rhs)>";
str pp(gt(Expresion lhs, Expresion rhs)) = "<pp(lhs)> \> <pp(rhs)>";
str pp(le(Expresion lhs, Expresion rhs)) = "<pp(lhs)> \<= <pp(rhs)>";
str pp(ge(Expresion lhs, Expresion rhs)) = "<pp(lhs)> \>= <pp(rhs)>";
str pp(eq(Expresion lhs, Expresion rhs)) = "<pp(lhs)> = <pp(rhs)>";
str pp(neq(Expresion lhs, Expresion rhs)) = "<pp(lhs)> \<\> <pp(rhs)>";
str pp(eqv(Expresion lhs, Expresion rhs)) = "<pp(lhs)> ≡ <pp(rhs)>";
str pp(inDom(Expresion lhs, Expresion rhs)) = "<pp(lhs)> in <pp(rhs)>";
str pp(andOp(Expresion lhs, Expresion rhs)) = "<pp(lhs)> and <pp(rhs)>";
str pp(orOp(Expresion lhs, Expresion rhs)) = "<pp(lhs)> or <pp(rhs)>";
str pp(impl(Expresion lhs, Expresion rhs)) = "<pp(lhs)> -\> <pp(rhs)>";
str pp(implFat(Expresion lhs, Expresion rhs)) = "<pp(lhs)> =\> <pp(rhs)>";