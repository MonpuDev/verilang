module AST

// ─── Programa y Módulo ────────────────────────────────────────────────────────

data Programa = programa(Modulo modulo);

data Modulo = modulo(str name, list[Importacion] imports, list[Declaracion] decls);

data Importacion = importacion(str modName);

// ─── Declaración ─────────────────────────────────────────────────────────────

data Declaracion
  = declEspacio(DeclaracionEspacio s)
  | declOperador(DeclaracionOperador op)
  | declVariables(DeclaracionVariables v)
  | declRegla(DeclaracionRegla r)
  | declExpresion(DeclaracionExpresion e)
  | declRelacion(DeclaracionRelacion reln)
  | declAtributos(DeclaracionAtributos a)
  ;

data DeclaracionEspacio
  = espacioSimple(str name)
  | espacioHerencia(str name, str parent);

data FirmaOperador = firma(list[str] tipos);

data DeclaracionOperador
  = defOperadorConAtr(str name, FirmaOperador firma, Atributos attrs)
  | defOperador(str name, FirmaOperador firma);

data DeclaracionRelacion = defRelacion(str name, FirmaOperador firma);

data DeclaracionAtributos = declAtrs(Atributos attrs);

data Atributos = atributos(list[Atributo] items);

data Atributo
  = atribSimple(str name)
  | atribValorado(str name, str val)
  | atribVacio(str name);

data DeclaracionVariables = defVar(list[Variable] vars);

data Variable = variable(str name, str domain);

// La regla ahora usa Expresiones directas
data DeclaracionRegla = defrule(Expresion lhs, Expresion rhs);

data DeclaracionExpresion
  = defExpresionConAtr(Expresion expr, Atributos attrs)
  | defExpresion(Expresion expr);

// ─── Expresión ───────────────────────────────────────────────────────────────

data Expresion
  = ident(str name)
  | paren(Expresion e)
  | forallIn(str var, str domain, Expresion body)
  | forallSimple(str var, Expresion body)
  | existsIn(str var, str domain, Expresion body)
  | existsSimple(str var, Expresion body)
  | app(Expresion lhs, Expresion rhs) // <--- ¡La regla mágica que lo arregla todo!
  | exp(Expresion lhs, Expresion rhs)
  | mul(Expresion lhs, Expresion rhs)
  | div(Expresion lhs, Expresion rhs)
  | modul(Expresion lhs, Expresion rhs)
  | add(Expresion lhs, Expresion rhs)
  | sub(Expresion lhs, Expresion rhs)
  | lt(Expresion lhs, Expresion rhs)
  | gt(Expresion lhs, Expresion rhs)
  | le(Expresion lhs, Expresion rhs)
  | ge(Expresion lhs, Expresion rhs)
  | eq(Expresion lhs, Expresion rhs)
  | neq(Expresion lhs, Expresion rhs)
  | eqv(Expresion lhs, Expresion rhs)
  | inDom(Expresion lhs, Expresion rhs)
  | andOp(Expresion lhs, Expresion rhs)
  | orOp(Expresion lhs, Expresion rhs)
  | impl(Expresion lhs, Expresion rhs)
  | implFat(Expresion lhs, Expresion rhs)
  ;