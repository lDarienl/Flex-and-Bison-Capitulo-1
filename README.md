# 📘 Flex and Bison – Capítulo 1

**Lenguajes de Programación**

Repositorio con los ejemplos desarrollados del **Capítulo 1 del libro *Flex & Bison***, incluyendo explicaciones detalladas y solución de los ejercicios propuestos.

---

# 📌 Requisitos

Sistema probado en **Ubuntu (AWS EC2)**.

Instalación:

```bash
sudo apt update
sudo apt install -y flex bison build-essential
```

Verificar instalación:

```bash
flex --version
bison --version
gcc --version
```

---

# 🛠 Cómo Compilar y Ejecutar

## 🔹 Solo Flex (.l)

```bash
flex archivo.l
gcc -o programa lex.yy.c -lfl
./programa
```

---

## 🔹 Flex + Bison (.l + .y)

```bash
bison -d archivo.y
flex archivo.l
gcc -o calc archivo.tab.c lex.yy.c -lfl
./calc
```

---

# 📂 Estructura del Proyecto

```
fbejemplo1.l
fbejemplo2.l
fbejemplo3.l
fbejemplo4.l
fbejemplo5.y
fbejemplo5.l
fbejercicio2.y
fbejercicio2.l
fbejercicio3.y
fbejercicio3.l
images/
```

---

# 📖 Ejemplo 1 – Contador de Palabras

📄 Código: `fbejemplo1.l`
🖼 Imagen: `images/ejemplo1.png`

Un archivo de Flex (`.l`) se divide en **tres secciones**, separadas por `%%`.

## 1️⃣ Definiciones (`%{ ... %}`)

Código C que se copia directamente al archivo generado (`lex.yy.c`).

Se declaran variables:

* `chars` → caracteres
* `words` → palabras
* `lines` → líneas

---

## 2️⃣ Reglas (`%% ... %%`)

Formato:

```
patrón (regex) → acción (C)
```

* `[a-zA-Z]+` → reconoce palabras y suma su longitud usando `strlen(yytext)`
* `\n` → cuenta líneas
* `.` → cuenta cualquier otro carácter

`yytext` contiene el texto reconocido.

---

## 3️⃣ Código final

Se define `main()` que llama a `yylex()` y luego imprime los resultados.

---

# 📖 Ejemplo 2 – Traductor Simple

📄 Código: `fbejemplo2.l`
🖼 Imagen: `images/ejemplo2.png`

Programa que traduce palabras específicas:

```c
"dog" → perro
"cat" → gato
```

Regla final:

```c
. { printf("%s", yytext); }
```

Funciona como **catch-all**, preservando el resto del texto.

---

# 📖 Ejemplo 3 – Tokens de Calculadora

📄 Código: `fbejemplo3.l`
🖼 Imagen: `images/ejemplo3.png`

Reconoce:

* Operadores (`+ - * / |`)
* Números `[0-9]+`
* Saltos de línea
* Espacios

Imprime el tipo de token detectado.

Este ejemplo demuestra cómo Flex puede actuar como un **analizador léxico real**.

---

# 📖 Ejemplo 4 – Scanner que Retorna Tokens

📄 Código: `fbejemplo4.l`
🖼 Imagen: `images/ejemplo4.png`

Aquí el scanner deja de imprimir texto y comienza a **retornar tokens numéricos**.

Se define:

```c
enum yytokentype { NUMBER = 258, ... };
int yylval;
```

Cuando se detecta un número:

```c
yylval = atoi(yytext);
return NUMBER;
```

`yylval` almacena el valor asociado al token.

Este ejemplo prepara el scanner para trabajar con un parser.

---

# 📖 Ejemplo 5 y 6 – Calculadora con Bison + Flex

📄 Parser: `fbejemplo5.y`
📄 Scanner: `fbejemplo5.l`
🖼 Imagen: `images/ejemplo5.png`

---

## 🔹 Ejemplo 5 – Parser (Bison)

Define la gramática:

* `exp` → suma/resta
* `factor` → multiplicación/división
* `term` → número o valor absoluto

Uso de:

* `$$` → valor de la regla
* `$1, $2, $3` → valores de símbolos

Ejemplo:

```c
exp ADD factor { $$ = $1 + $3; }
```

Se ejecuta con:

```c
yyparse();
```

---

## 🔹 Ejemplo 6 – Scanner adaptado para Bison

Incluye:

```c
#include "fbejemplo5.tab.h"
```

Ahora el scanner devuelve tokens definidos en el parser.

```c
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
```

`yyparse()` controla el flujo y llama a `yylex()`.

---

# 🧪 Ejercicios

---

## 1️⃣ Comentarios

La calculadora original no acepta comentarios.

Solución en el scanner:

```c
"//".* { /* ignore comment */ }
```

Es más sencillo resolverlo en el **scanner** que en el parser.

---

## 2️⃣ Calculadora Hexadecimal

Se agregó reconocimiento de números hexadecimales:

```c
"0x"[0-9a-fA-F]+ { yylval = (int)strtol(yytext, NULL, 16); return NUMBER; }
```

Y se modificó la impresión:

```c
printf("= %d (0x%X)\n", $2, (unsigned)$2);
```

Ahora acepta decimal y hexadecimal.

---

## 3️⃣ Operadores AND / OR

El símbolo `|` ya se usaba como valor absoluto, lo que genera ambigüedad.

Solución:

* Usar `abs(exp)` como función
* Mantener `|` como OR binario (`BOR`)

Esto evita conflictos en la gramática.

---

## 4️⃣ Scanner Manual vs Flex

Aunque pueden producir resultados similares, Flex aplica:

* Longest match
* Prioridad por orden de reglas

No siempre serán idénticos en casos límite.

---

## 5️⃣ ¿Lenguajes donde Flex no es ideal?

Lenguajes con:

* Indentación significativa (como Python)
* Dependencia fuerte de contexto léxico

Flex funciona mejor cuando el léxico puede describirse con expresiones regulares.

---

## 6️⃣ Word Count en C vs Flex

La versión en C puede ser ligeramente más rápida si está optimizada.

Sin embargo:

* Flex es más fácil de mantener
* Las reglas son más declarativas
* Es menos propenso a errores manuales

---

# 🎯 Conclusión

En este capítulo se aprendió:

* Separación entre análisis léxico y sintáctico
* Cómo Flex genera scanners a partir de expresiones regulares
* Cómo Bison implementa gramáticas y evaluación
* Cómo conectar ambos para construir una calculadora funcional

