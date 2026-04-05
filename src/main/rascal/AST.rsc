module AST

// ─── Programa y Módulo ────────────────────────────────────────────────────────

data Programa
  = programa(Modulo modulo)
  ;

data Modulo
  = modulo(str name, list[Importacion] imports, list[Declaracion] decls)
  ;

data Importacion
  = importacion(str modName)
  ;

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

// ─── Espacio ─────────────────────────────────────────────────────────────────

data DeclaracionEspacio
  = espacioSimple(str name)
  | espacioHerencia(str name, str parent)
  ;

// ─── Operador / Relación ──────────────────────────────────────────────────────

data FirmaOperador
  = firma(list[str] tipos)
  ;

data DeclaracionOperador
  = defOperador(str name, FirmaOperador firma)
  ;

data DeclaracionRelacion
  = defRelacion(str name, FirmaOperador firma)
  ;

// ─── Atributos ───────────────────────────────────────────────────────────────

data DeclaracionAtributos
  = declAtrs(Atributos attrs)
  ;

data Atributos
  = atributos(list[Atributo] items)
  ;

data Atributo
  = atribSimple(str name)
  | atribValorado(str name, str val)
  ;

// ─── Variables ───────────────────────────────────────────────────────────────

data DeclaracionVariables
  = defVar(list[Variable] vars)
  ;

data Variable
  = variable(str name, str domain)
  ;

// ─── Regla ───────────────────────────────────────────────────────────────────

data DeclaracionRegla
  = defrule(Aplicacion lhs, Aplicacion rhs)
  ;

// ─── Expresión ───────────────────────────────────────────────────────────────

data DeclaracionExpresion
  = defExpresion(Expresion expr, list[Atributos] attrs)
  ;

data Expresion
  = ident(str name)
  | paren(Expresion e)
  | aplic(Aplicacion a)
  | cuant(Cuantificador q)
  | neg(Expresion e)
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

data Cuantificador
  = forallIn(str var, str domain, Expresion body)
  | forallSimple(str var, Expresion body)
  | existsIn(str var, str domain, Expresion body)
  | existsSimple(str var, Expresion body)
  ;

// ─── Aplicación ──────────────────────────────────────────────────────────────

data Aplicacion
  = aplicacion(str op, list[Argumento] args)
  ;

data Argumento
  = argId(str name)
  | argAplic(Aplicacion inner)
  ;