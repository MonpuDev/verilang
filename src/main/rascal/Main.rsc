module Main

import Syntax;
import AST;
import ParseTree;
import util::LanguageServer;
import util::Reflective;
import IO;

// ─── 1. Funciones de Parseo (Texto -> Árbol de Sintaxis) ─────────────────────

public Syntax::Programa parseVeriLang(loc file) {
    return parse(#Syntax::Programa, file);
}

public Syntax::Programa parseVeriLangString(str src, loc origin) {
    return parse(#Syntax::Programa, src, origin);
}

// ─── 2. Funciones de AST (Árbol de Sintaxis -> Árbol Abstracto) ──────────────

public AST::Programa getAST(loc file) {
    Tree pt = parseVeriLang(file);
    return implode(#AST::Programa, pt);
}

// ─── 3. Integración con el IDE de VS Code (Resaltado de Sintaxis) ────────────

// Definimos los servicios (Quitamos el "parser = ")
set[LanguageService] veriLangContributions() = {
    parsing(Tree (str input, loc origin) {
        return parseVeriLangString(input, origin);
    })
};

// Registramos el lenguaje
public void setupIDE() {
    registerLanguage(
        language(
            pathConfig(srcs=[|project://VeriLang/src/main/rascal|]),
            "VeriLang",             // Nombre del lenguaje
            {"vrl"},                // <-- ¡CORRECCIÓN! Ahora es un SET de extensiones
            "Main",                 // Módulo donde están las contribuciones
            "veriLangContributions" // Función que devuelve los servicios
        )
    );
    
    println("¡Lenguaje VeriLang registrado exitosamente en VS Code!");
    println("Abre (o cierra y vuelve a abrir) tu archivo .vrl para ver el resaltado de sintaxis.");
}