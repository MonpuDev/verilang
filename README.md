## Guía de Uso y Pruebas

Para ejecutar las siguientes pruebas, es necesario abrir una terminal interactiva de Rascal.

### 1. Parseo y Obtención del AST (Probando los ejemplos)
Puedes probar los archivos completos que se encuentran en la carpeta `instance/` para verificar que la gramática no tiene ambigüedades y que el AST se construye correctamente.

En la terminal de Rascal, ejecuta:

```rascal
// Importar el módulo principal
import Main;

// 1. Para ver el Árbol de Parseo (Parse Tree) crudo:
parseVeriLang(|cwd:///instance/ejemplo1.vrl|); // probar también con: ejemplo2.vrl, ejemplo3.vrl, ejemplo4.vrl

// 2. Para ver el Árbol de Sintaxis Abstracta (AST) limpio y estructurado:
getAST(|cwd:///instance/ejemplo1.vrl|); // probar también con: ejemplo2.vrl, ejemplo3.vrl, ejemplo4.vrl
```

### EJEMPLO (PARSER):

<img width="940" height="600" alt="image" src="https://github.com/user-attachments/assets/0ef5f8c1-8770-4cc5-bf53-3076c7027ca1" />

### EJEMPLO (AST):

<img width="940" height="600" alt="image" src="https://github.com/user-attachments/assets/27db4b68-3c2d-4aea-96b7-975ae6135dd6" />

---

### 2. Generación de Código (Output)
Para probar el paso final del compilador y generar un archivo de texto plano a partir de un ejemplo hacer lo siguiente en una terminal interactiva de Rascal:

```rascal
import Main;
import AST;
import Generator;

// Obtenemos el AST del archivo de entrada
Programa miAST = getAST(|cwd:///instance/ejemplo1.vrl|);

// Generamos el archivo .txt en la carpeta output/
generateTxt(miAST, |cwd:///output/|, "resultado_ejemplo1.txt");
```

### EJEMPLO:

<img width="940" height="600" alt="image" src="https://github.com/user-attachments/assets/ed45d77b-584b-4624-a158-bbcb84c35c01" />

<img width="940" height="600" alt="image" src="https://github.com/user-attachments/assets/ce39bb94-f544-42ed-8095-15f524ac647e" />

<img width="940" height="600" alt="image" src="https://github.com/user-attachments/assets/09f06b04-83db-4ede-9223-82f2066932f7" />

---

### 3. Pruebas Rápidas desde la Terminal
Para verificar si un fragmento cumple con las reglas gramaticales, usar la función __"#parse"__ nativa de Rascal junto con el __"No-Terminal"__ específico a evaluar.
Todo esto realizarlo dentro de una terminal interactiva de Rascal:

```rascal
import Syntax;
import ParseTree;

// Prueba 1: Verificar una declaración de variables
parse(#Declaracion, "defvar x : Derived, y : Derived, z : Derived end");

// Prueba 2: Verificar una expresión matemática/lógica
parse(#Expresion, "(x + y) \<= z");

// Prueba 3: Verificar la creación de un espacio
parse(#DeclaracionEspacio, "defspace MiEspacio \< Padre end");
```

### EJEMPLO:

<img width="940" height="600" alt="image" src="https://github.com/user-attachments/assets/fc6bb409-fbd8-455e-89cc-77b0d85ca31c" />





