module Main

import Syntax;
import AST;
import Generator;
import ParseTree;
import util::LanguageServer;
import util::Reflective;
import IO;


//=================================================================
//FUNCIÓN DE PARSEO
//=================================================================
public Syntax::Programa parseVeriLang(loc file) {
    return parse(#Syntax::Programa, file);
}

public Syntax::Programa parseVeriLangString(str src, loc origin) {
    return parse(#Syntax::Programa, src, origin);
}


//=================================================================
//FUNCIÓN DE 'AST'
//=================================================================
public AST::Programa getAST(loc file) {
    Tree pt = parseVeriLang(file);
    return implode(#AST::Programa, pt);
}


//=================================================================
//RESALTADO DE SINTAXIS
//=================================================================
set[LanguageService] veriLangContributions() = {
    parsing(Tree (str input, loc origin) {
        return parseVeriLangString(input, origin);
    })
};


//=================================================================
//REGISTRAR EL LENGUAJE
//=================================================================
public void setupIDE() {
    registerLanguage(
        language(
            pathConfig(srcs=[|project://VeriLang/src/main/rascal|]),
            "VeriLang",
            {"vrl"},
            "Main",
            "veriLangContributions"
        )
    );
    
    println("¡Lenguaje VeriLang registrado exitosamente en VS Code!");
    println("Abre (o cierra y vuelve a abrir) tu archivo .vrl para ver el resaltado de sintaxis.");
}


//=================================================================
//GENERACIÓN DE CÓDIGO
//=================================================================
public void compileVeriLang(loc inputFile, str outputFileName) {
    AST::Programa p = getAST(inputFile);
    // Le indicamos que genere el txt en la carpeta "output"
    generateTxt(p, |cwd:///output/|, outputFileName);
}