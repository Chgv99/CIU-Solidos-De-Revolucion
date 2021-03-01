# Solid Drawer
Solid Drawer es un software 3D de dibujado de [sólidos de revolución](https://es.wikipedia.org/wiki/S%C3%B3lido_de_revoluci%C3%B3n) desarrollado en [Processing 3](https://processing.org/) para la asignatura Creando Interfaces de Usuario.

Para ejecutar el programa, descomprime el .zip y ejecuta SolidDrawer.pde dentro de SolidDrawer.

*Christian García Viguera. [Universidad de Las Palmas de Gran Canaria.](https://www2.ulpgc.es/)*

<p align="center">
  <img width="800" height="400" src="https://i.imgur.com/L7OjaKl.png">
</p>

# Índice
* [Instrucciones de uso](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Instrucciones-de-uso)
  * [Construir un sólido de revolución](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Construir-un-sólido-de-revolución)
  * [Manipulación del sólido y otros controles](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Manipulación-del-sólido-y-otros-controles)
  * [Añadir más sólidos a la escena](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Añadir-más-sólidos-a-la-escena)
  * [Manipulación de múltiples sólidos](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Manipulación-de-múltiples-sólidos)
* [Funcionamiento](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Funcionamiento)
* [Errores conocidos](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Errores)
* [Referencias](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Referencias)
---

# Instrucciones de uso
* [Construir un sólido de revolución](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Construir-un-sólido-de-revolución)
* [Manipulación del sólido y otros controles](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Manipulación-del-sólido-y-otros-controles)
* [Añadir más sólidos a la escena](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Añadir-más-sólidos-a-la-escena)
* [Manipulación de múltiples sólidos](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Manipulación-de-múltiples-sólidos)

El programa se ejecuta mostrando el menú principal. Desde aquí se puede acceder a varias pantalla, como la de ayuda, la de información o la pantalla para comenzar a dibujar.
                
La pantalla de ayuda ofrece un listado con las funciones más importantes y menos intuitivas, explicándolas para que el usuario sepa manejarlas... Se trata de un resumen de la información aquí contenida. La pantalla de información muestra mi información de contacto.

## Construir un sólido de revolución:
Para comenzar a dibujar el sólido, se debe acceder a la pantalla de dibujado ("Draw") desde el menú principal.

En esta pantalla da comienzo el proceso de dibujado. El usuario no tiene más que hacer click en la zona derecha de la pantalla para ir creando los vértices de la superficie de revolución.

Una vez creada la forma de la superficie podemos confirmar la creación del sólido con la barra espaciadora o volver atrás con R y dibujarla de nuevo. Al confirmar la creación, pasamos directamente a la pantalla de visualización en 3 dimensiones, donde podremos manipular nuestra figura.

El programa ofrece la opción de "acoplar" el eje de rotación a la figura que se está dibujando. Esta opción, X, unirá el primer y el último vértice con el eje central, si está activada durante su creación.

Nótese en los siguientes ejemplos como con el modo "acoplar" desactivado (verde) se obtiene una figura hueca. Mientras que con él activado (rojo) se obtiene una figura "maciza".

## Manipulación del sólido y otros controles:

Tras crear el sólido de revolución, uno es capaz de rotarlo con click derecho y moverlo en los ejes "X" e "Y" con click izquierdo, es decir, de izquierda a derecha y de arriba a abajo.

Actualmente, no es posible alejarlo o acercarlo a la cámara en el eje "Z", pero sí que es posible hacerlo con la cámara (podemos acercarla con + y alejarla con -). Esta distinción entre el movimiento de la cámara y el sólido es importante para más adelante, a la hora de manipular múltiples objetos, pues no es posible moverlos en "Z" individualmente.

También es posible eliminar la figura pulsando R, lo que devolvería al usuario a la pantalla de dibujado. Por otro lado, uno es capaz de añadir más figuras a la escena, volviendo a pulsar la barra espaciadora.

## Añadir más sólidos a la escena:

Como se menciona anteriormente, es posible tener más de una figura tridimensional en pantalla. Esto es posible pulsando la barra espaciadora en el visualizador en 3 dimensiones. El procedimiento de construcción es el mismo que el de la primera figura.

<p align="center">
  <img width="800" height="400" src="https://i.imgur.com/PbWgaSR.png">
</p>

## Manipulación de múltiples sólidos:

Una vez se tenga varios sólidos creados, se puede iterar sobre ellos pulsando la flecha izquierda y la flecha derecha del teclado, pudiendo seleccionar cualquiera de ellas para su manipulación. La figura seleccionada podrá ser manipulada como se ha explicado anteriormente.

Se podrán eliminar los sólidos uno a uno, seleccionando el que se quiera eliminar y pulsando R. Cuando se elimine el último sólido se volverá a la pantalla de dibujado. También es posible volver al menú principal, acción tras la cual se borrarán todos los sólidos.

<p align="center">
  <img width="800" height="400" src="https://i.imgur.com/4AjNTGA.gif">
</p>

# Funcionamiento

Al entrar en la pantalla de dibujo, se crea una PShape usando createShape() y se le da estilo. Tras ello, cada vez que el usuario hace click, un vértice es creado al instante y es añadido a un ArrayList donde se añadirán los siguientes vértices.

```processing
void mouseReleased(){
    left_drag = false;
    right_drag = false;
    if (!main_menu && !rotate && !help) {
        create_vertex = true;
    }
}
```

```processing
void printProgram(){
    background(0);
    translate(translate_x, translate_y, translate_z);
    textAlign(LEFT);
    if (end_shape) {
        //...
    } else {
        //...
        if (create_vertex) {
            if (vertices.size() == 0) first_vertex = true;
            if (mouseX- width/2 < 0) vertices.add(new Vertex(0, mouseY  - height/2));//shape.vertex(width/2, mouseY);
            else {
                if (first_vertex && join){
                vertices.add(new Vertex(0, mouseY - height/2));
                }
                vertices.add(new Vertex(mouseX - width/2, mouseY - height/2));
            }
            create_vertex = false;
            first_vertex = false;
            last_x = mouseX - width/2;
            last_y = mouseY - height/2;
        }
        //...
    }
}
```

Cuando el usuario está satisfecho con los vértices y pulsa barra espaciadora, se añaden todos los vértices del ArrayList a la figura creada al principio y se imprime por pantalla.

```processing
void makeShape() {
if (last_x > 0 && join) vertices.add(new Vertex(0, last_y));
    if (!join && vertices.size() == 2) vertices.add(vertices.get(vertices.size() - 1));
    if (!vertices.isEmpty()){
        for (Object o : vertices) {
        Vertex v = (Vertex) o;
        shape.vertex(v.x,v.y);
        }
    }
    shape.endShape(CLOSE);
}
```

Si el usuario sigue satisfecho con la figura y vuelve a pulsar barra espaciadora, se crean 7 figuras más, y a cada una de ellas se le introducen los vértices del ArrayList pero rotados PI/4 radianes con respecto de la figura anterior. Es decir, tendríamos nuestra figura 2D original, luego una copia exacta rotada PI/4 radianes, otra más rotada otros PI/4 radianes, etc...

Tras rotar todas las figuras, las cuales también se encuentran almacenadas en un ArrayList, se crea una figura más. Ésta será nuesta figura tridimensional final, y para formarla se recorrerán todas las figuras creadas anteriormente (la original también), y se añadirán todos esos vértices a la nueva figura.

Por supuesto, se han de añadir en un orden concreto, dado que estamos usando la función beginShape(TRIANGLE_STRIP) para formar los triángulos de las caras. Las figuras se recorren de 2 en 2, añadiendo el primer vértice de la primera y el primer vértice de la segunda. Luego el segundo de la primera y el segundo de la segunda. Así sucesivamente hasta acabar con los vértices de esas dos figuras.

A continuación, se coge la segunda figura usada anteriormente (a partir de ahora será la "primera") y la siguiente en el ArrayList. Se repite el proceso hasta terminar con las figuras.

```processing
PShape previous = (PShape) shapes.get(0);
PShape first = (PShape) shapes.get(0);
PShape second = (PShape) shapes.get(1);
shapes.remove(0);

//Comienza desde la segunda shape
for (Object o : shapes){
    PShape shape = (PShape) o;
    for (int i = 0; i < shape.getVertexCount(); i++) {
    PVector previous_v = previous.getVertex(i);
    if (previous_v != null) shape3d.vertex(previous_v.x, previous_v.y, previous_v.z);
    PVector v = shape.getVertex(i);
    if (v != null) shape3d.vertex(v.x, v.y, v.z);
    }
    previous = shape;
```

Si dejamos el código en este punto, la figura se queda abierta, a modo de "tarta sin un trozo". El siguiente fragmento de código arregla parte del problema.

```processing
//Ultimo fragmento
shape = first;
for (int i = 0; i < shape.getVertexCount(); i++) {
    PVector previous_v = previous.getVertex(i);
    if (previous_v != null) shape3d.vertex(previous_v.x, previous_v.y, previous_v.z);
    PVector v = shape.getVertex(i);
    if (v != null) shape3d.vertex(v.x, v.y, v.z);
}
PVector first_v;
```

En este otro punto, si el dibujo se realiza de manera que la unión entre los últimos vértices quede por fuera, la figura se queda sin la cara correspondiente a los últimos vértices. Este problema fue arreglado volviendo a añadir a la figura el primer vértice de las dos primeras figuras bidimensionales.

```processing
first_v = first.getVertex(0);
shape3d.vertex(first_v.x, first_v.y, first_v.z);
first_v = second.getVertex(0);
shape3d.vertex(first_v.x, first_v.y, first_v.z);
```

# Errores

* [Rotación](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Rotacion)
* [Renderizado de texto](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#Texto)
* [Eje Z](https://github.com/Chgv99/CIU-Solidos-De-Revolucion#EjeZ)

## Rotación

El eje de rotación de las figuras en el visualizador tridimensional depende de la distancia al centro de la pantalla a la que se dibuje. Resulta algo incómodo.

## Renderizado de texto

El texto no es independiente de las figuras. Si se aleja la cámara o se acerca, se debe compensar en la coordenada Z del texto. De lo contrario, se alejaría y acercaría junto con las figuras.

Además, si la figura es muy grande o está muy cerca de la cámara, traspasa el texto e impide que se pueda leer.

## Eje Z

No es posible mover las figuras en el eje Z. Esto resulta en que al tener varias figuras en pantalla, están todas alineadas, y las composiciones posibles son más limitadas.

# Referencias
* [Processing 3](https://processing.org/)
* [Processing 3 Reference](https://processing.org/reference/)
