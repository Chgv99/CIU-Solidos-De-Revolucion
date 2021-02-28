
////TODO
/*  [FIXED] In UNJOINED mode the last triangles don't connect
    Sometimes, in unjoined mode, the first vertex does not join with center
    [ADDED] Add zoom in and out with [+] [-]
    [ADDED] Multiple 3dshapes.
    Change text info
    Change text style and size
    Color palettes
    [FIXED] When returning to main menu it may remember old vertices.
*/

// A list of objects
ArrayList<Polygon> polygons;

//// --BOOLEAN--
//States
boolean main_menu, help, create_vertex, end_shape, first_vertex, rotate;
//Inputs
boolean space, click, left_drag, right_drag, join;

////--PSHAPES
float shape3d_x, shape3d_y, shape3d_z;
PShape shape, shape1, shape2, shape3, shape4, shape5, shape6, shape7, shape3d;
int last_x, last_y;
ArrayList vertices = new ArrayList<Vertex>();
ArrayList shapes = new ArrayList<PShape>();
ArrayList shapes_3d = new ArrayList<ShapePositioned>();

////--VALUES
int translate_x, translate_y, translate_z, zoom_factor;
int shape_selected;

//Strings
final char DELIMITER = '\n'; // delimiter for words
final String HELP_TEXT = 
"A 3D shape is created by first drawing its surface. Only then you'll be able to visualize it."+DELIMITER+
"Here are some of the most important tools explained:"+DELIMITER+
""+DELIMITER+
"Drawing mode:"+DELIMITER+
"[X] Changes join mode. Red mode will create an extra vertex in the axis upon first vertex "+DELIMITER+
"creation and an extra vertex upon drawing [SPACE]. Green mode will not create such vertices, "+DELIMITER+
"in return it will join the first and last drawn vertices upon drawing [SPACE]."+DELIMITER+
"[R] Erases the current drawing completely."+DELIMITER+
""+DELIMITER+
"3D mode:"+DELIMITER+
"[Left Mouse Drag] Moves the selected shape in the x and y axis."+DELIMITER+
"[Right Mouse Drag] Rotates the selected shape in the x and y axis."+DELIMITER+
"[R] Deletes the selected 3D shape."+DELIMITER+
"[  ] Goes back to the drawing screen where you can add another 3d shape."+DELIMITER+
"[H] to exit";

class Vertex{
  int x, y;
  Vertex(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

class ShapePositioned{
  PShape shape3d;
  float x, y;
  
  ShapePositioned(PShape shape3d, float x, float y) {
    this.x = x;
    this.y = y;
    this.shape3d = shape3d;
  }
  
  void move(float x, float y){
    this.x += x;
    this.y += y;
  }
  
  PShape getShape(){
    return shape3d;
  }
}

void setup(){
  size(1000, 500, P3D);
  surface.setResizable(false);
  
  main_menu = true;
  rotate = false;
  end_shape = false;
  first_vertex = true;
  help = false;
  join = true;
  
  translate_x = width/2;
  translate_y = height/2;
  translate_z = 0;
  zoom_factor = 2;
  
  shape3d_x = 0;
  shape3d_y = 0;
  shape3d_z = 0;
}

void draw() {
  if (help) {
    printHelp();
  } else {
    if (main_menu){
      printMainMenu();
    } else {
      printProgram();
    }
  }
  key();
}

void key() {
  if (keyPressed) {
    if (key != CODED) {
      //Zoom
      if (rotate) {
        if (key == '+'){
          println("P");
          //shape3d_z += zoom_factor;
          translate_z += zoom_factor;
          //translate(translate_x, translate_y, translate_z++);
        }
        if (key == '-'){
          println("P");
          //shape3d_z -= zoom_factor;
          translate_z -= zoom_factor;
          //translate(translate_x, translate_y, translate_z++);
        }
      }
    }
  }
}

void printHelp() {
  background(0);
  fill(255, 0, 0);
  textSize(30);
  textAlign(CENTER);
  text("Help", width/2, height/2 - 185);
  textSize(15);
  fill(255, 255, 255);
  text(HELP_TEXT, width/2, height/2 - 150);
}

void printMainMenu(){
  background(0);
  fill(255, 0, 0);
  textSize(32);
  textAlign(CENTER);
  text("Solid Drawer", width/2, height/2 - 100);
  textSize(20);
  fill(255, 255, 255);
  text("[SPACE] to start drawing", width/2, height/2);
  text("[H] to show help", width/2, height/2 + 40);
}

void printPoints(){
  if (!vertices.isEmpty()){
    for (Object o : vertices){
      //if (o != vertices.get(0)) {
        Vertex v = (Vertex) o;
        circle(v.x, v.y, 5);
      //}
    }
  }
}

void showTextInHUD(String str1, float x, float y) {
  // A small 2D HUD for text at
  // free pos.
  // This func may only be called a the very end of draw() afaik.
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  if (str1!=null)
    text(str1, x, y);
  hint(ENABLE_DEPTH_TEST);
}

void printProgram(){
  background(0);
  translate(translate_x, translate_y, translate_z);
  stroke(255, 0, 0);
  textSize(16);
  
  if (end_shape) {
    if (rotate) {
      //showTextInHUD("[Left Mouse Drag] Move shape    [Right Mouse Drag] Rotate shape    [R] Reset shape    [+][-] Zoom    [ESC] Main menu",
      //              width/2, 
      //              height - 20);
      text("[Left Mouse Drag] Move shape    [Right Mouse Drag] Rotate shape    [R] Reset shape    [+][-] Zoom    [ESC] Main menu", 
            0, 
            (height/2) - 20, 
            -translate_z);
      if (left_drag){
        //translate_x += mouseX - pmouseX;
        //translate_y += mouseY - pmouseY;
        ((ShapePositioned)shapes_3d.get(shape_selected)).move(mouseX - pmouseX, mouseY - pmouseY);
        //shape3d_x += mouseX - pmouseX;
        //shape3d_y += mouseY - pmouseY;
      }
      if (right_drag){
        //rotateY(map(mouseX - width/2, 0, width, 0, 4*PI));
        //rotateX(-map(mouseY - height/2, 0, height, 0, 4*PI));
        ((ShapePositioned)shapes_3d.get(shape_selected)).getShape().rotateY(radians(mouseX - pmouseX));
        ((ShapePositioned)shapes_3d.get(shape_selected)).getShape().rotateX(-radians(mouseY - pmouseY));
      }
      stroke(255,0,0);
      //shape(shape);
      
      if (!shapes_3d.isEmpty()){
        for (Object o : shapes_3d){
          ShapePositioned shape_p = (ShapePositioned) o;
          if (shapes_3d.indexOf(o) == shape_selected) shape_p.shape3d.setStroke(color(0,0,255));
          shape(shape_p.shape3d, shape_p.x, shape_p.y/*, shape3d_z*/);
          shape_p.shape3d.setStroke(color(255,0,0));
        }
      }
    } else {
      line(0, 0 - height/2, 0, height - height/2);
      text("[R] Reset shape    [SPACE] Confirm shape", 0, height-20 - height/2, -translate_z);
      shape(shape);
    }
    //translate(0, 0);
    
    //popMatrix();
  } else {
    if (join) stroke(255,0,0);
    else stroke(0,255,0);
    line(0, 0 - height/2, 0, height - height/2);
    //Dibujar vértices
    printPoints();
    if (create_vertex) {
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
    
    if (join) text("[Z] Undo vertex    [X] Unjoin center    [R] Reset shape    [SPACE] Draw shape    [ESC] Main menu", 0, height-20  - height/2);
    else text("[Z] Undo vertex    [X] Join center    [R] Reset shape    [SPACE] Draw shape    [ESC] Main menu", 0, height-20  - height/2);
  }
}

void keyPressed() {
  //Vaciar ESC
  if (key == ESC){
    key = 0;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT){
      print(shape_selected);
      if (shape_selected > 0) shape_selected--;
    }
    if (keyCode == RIGHT){
      print(shape_selected);
      if (shape_selected < shapes_3d.size() - 1) shape_selected++;
    }
  } else {
    if (keyCode == ' ') {
      
      if (main_menu) {
        main_menu = false;
        shape = startShape();
        println("shape created: " + shape);
      }
      else {
        if (!end_shape && !vertices.isEmpty()){
          println("holas");
          makeShape();
          end_shape = true;
        } else if (end_shape && rotate) {
          /*if (rotate) {
              //return to shape drawer (add shape)
              rotate = false;
          }*/
          //De vuelta a la pantalla de dib
          end_shape = false;
          rotate = false;
          softReset();
          shape = startShape();
        } else if (end_shape) {
          makeRevolutionShape();
          rotate = true;
        }
        
      }
      println("main_menu: " + main_menu);
      println("end_shape: " + end_shape);
      println("rotate: " + rotate);
    }
    
    if (keyCode == 'H'){
      help = !help;
    }
    
    if (!main_menu && !help) {
      if (key == ESC){
        reset();
        main_menu = true;
        end_shape = false;
        rotate = false;
      }
      if (keyCode == 'R'){
        if (end_shape && rotate) {
          shapes_3d.remove(shape_selected);
          if (shape_selected > 0) shape_selected--;
          else if (shapes_3d.size() <= 0) {
            main_menu = false;
            end_shape = false;
            rotate = false;
            reset();
          }
        } else {
          reset();
        }
        
      }
      if (keyCode == 'Z'){
        if (!vertices.isEmpty()) {
          vertices.remove(vertices.size() - 1);
          if (vertices.size() > 0) {
            Vertex last = (Vertex) vertices.get(vertices.size() - 1);
            last_x = last.x;
            last_y = last.y;
          } else {
            Vertex last = null;
            last_x = 0;
            last_y = 0;
          }
        }
      }
      if (keyCode == 'X'){
        if (!rotate) {
          join = !join;
        }
      }
    } else {
    }
    
  }
}

void softReset(){
  translate_z = 0;
  shapes = new ArrayList<PShape>();
  shape3d = null;
  shape = startShape();
  vertices = new ArrayList<Vertex>();
}

void reset(){
  translate_z = 0;
  shapes = new ArrayList<PShape>();
  shapes_3d = new ArrayList<ShapePositioned>();
  shape3d = null;
  shape = startShape();
  vertices = new ArrayList<Vertex>();
}

void makeRevolutionShape(){
  shape1 = null;
  shape2 = null;
  shape3 = null;
  shape4 = null;
  shape5 = null;
  shape6 = null;
  shape7 = null;
  shape1 = startShape();
  shape2 = startShape();
  shape3 = startShape();
  shape4 = startShape();
  shape5 = startShape();
  shape6 = startShape();
  shape7 = startShape();
  rotateShape(shape1, PI/4);
  rotateShape(shape2, PI/2);
  rotateShape(shape3, PI * 3/4);
  rotateShape(shape4, PI);
  rotateShape(shape5, PI + PI/4);
  rotateShape(shape6, PI + PI/2);
  rotateShape(shape7, PI + PI * 3/4);
  
  //Ending shapes and adding them to list
  shapes.add(shape);
  shape1.endShape(CLOSE);
  shapes.add(shape1);
  shape2.endShape(CLOSE);
  shapes.add(shape2);
  shape3.endShape(CLOSE);
  shapes.add(shape3);
  shape4.endShape(CLOSE);
  shapes.add(shape4);
  shape5.endShape(CLOSE);
  shapes.add(shape5);
  shape6.endShape(CLOSE);
  shapes.add(shape6);
  shape7.endShape(CLOSE);
  shapes.add(shape7);
  
  shape3d = createShape();
  shape3d.beginShape(TRIANGLE_STRIP);
  //shape3d.noFill();
  shape3d.fill(255);
  shape3d.stroke(255,0,0);
  shape3d.strokeWeight(2);
  
  int j = 0;
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
    /*PVector v = shape.getVertex(0);
    if (v != null) shape3d.vertex(v.x, v.y, v.z);*/
    previous = shape;
    j++;
  }
  
  //Ultimo fragmento
  shape = first;
  for (int i = 0; i < shape.getVertexCount(); i++) {
    PVector previous_v = previous.getVertex(i);
    if (previous_v != null) shape3d.vertex(previous_v.x, previous_v.y, previous_v.z);
    PVector v = shape.getVertex(i);
    if (v != null) shape3d.vertex(v.x, v.y, v.z);
  }
  PVector first_v;
  first_v = first.getVertex(0);
  shape3d.vertex(first_v.x, first_v.y, first_v.z);
  first_v = second.getVertex(0);
  shape3d.vertex(first_v.x, first_v.y, first_v.z);
  
  /*PVector v = shape7.getVertex(shape.getVertexCount() - 1);
  if (v != null) shape3d.vertex(v.x, v.y, v.z);*/
  
  shape3d.endShape(CLOSE);
  shapes_3d.add(new ShapePositioned(shape3d, shape3d_x, shape3d_y));
  shape_selected = shapes_3d.size() - 1;
  print(shape3d);
}

void rotateShape(PShape shape, float rads) {  
  for (Object o : vertices) {
    Vertex v = (Vertex) o;
    float x2 = v.x * cos(rads) - 0 * sin(rads);
    float z2 = v.x * sin(rads) + 0 * cos(rads);
    shape.vertex(x2, v.y, z2);
    //println("x1: " + v.x + " y1: " + v.y);
    //println("x2: " + x2 + " y2: " + y2);
  }
}

void makeShape() {
  if (last_x > 0 && join) vertices.add(new Vertex(0, last_y));
  if (!vertices.isEmpty()){
    for (Object o : vertices) {
      
      Vertex v = (Vertex) o;
      shape.vertex(v.x,v.y);
    }
  }
  println("vertices created");
  shape.endShape(CLOSE);
  //pushMatrix();
}

PShape startShape() {
  first_vertex = true;
  PShape sh = createShape();
  sh.beginShape();
  sh.noFill();
  sh.stroke(255);
  sh.strokeWeight(2);
  return sh;
}

void mouseReleased(){
  left_drag = false;
  right_drag = false;
  if (!main_menu && !rotate && !help) {
    create_vertex = true;
    //print("click" + (mouseX - width/2) + ", " + mouseY + "\n");
  }
  /*if (mouseX > width/2){
    
  }*/
}

void mouseDragged(){
  if (mousePressed && (mouseButton == LEFT)){
    left_drag = true;
    //translate(mouseX, mouseY, 0);
  }
  if (mousePressed && (mouseButton == RIGHT)){
    right_drag = true;
    //translate(mouseX, mouseY, 0);
  }
}

/*void mouseWheel(MouseEvent event) {
  wheel_events = event.getCount();
}*/
