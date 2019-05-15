//Globals
final float PHI = 0.618033989;
int rows, cols;
final int[] barNums = {4, 7, 11, 18, 29, 47};
int barNumsIdx = 0;


void setup() {
  size(1080, 1080);
  background(255);

  // rows = 4;
  rows = 7;
  // rows = 11;
  // rows = 18;
  // rows = 29;
  // rows = 47;
  // rows = 76;
  // rows = 123;

  // cols = 4;
  cols = 7;
  // cols = 11;
  // cols = 18;
  // cols = 29;
  // cols = 47;
  // cols = 76;
  // cols = 123;

  render();
}


void draw() {
}


void render() {
  background(255);
  color barClr = color(95, 191, 245);
  color bkbarClr = color(241, 115, 0);
  color gridClr = color(241, 115, 0, 76);

  float cellW, cellH;
  cellW = width/cols; 
  cellH = height/rows;

  float bx, by, bw, bh;

  int barNumsIdx=int(random(barNums.length));
  // int barNumsIdx=0;

  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      barNumsIdx = barNumsIdx>barNums.length-1 ? 0 : barNumsIdx;

      pushMatrix();
      translate(j*cellW, i*cellH);
      noStroke(); 
      blendMode(MULTIPLY);
      color cellBkg = random(1)>0.5?color(95, 191, 245, 47):color(241, 115, 0, 47);
      fill(cellBkg);
      rect(7, 7, cellW-7, cellH-7, 76);

      int barCount = barNums[barNumsIdx++];
      bw = (.8*cellW)/barCount;

      for (int k=0; k<barCount; k++) {
        bh = random(cellH*PHI) ;
        by = (cellH/2)-(bh/2);
        bx = (k * bw) + (cellW*.125);
        fill(bkbarClr);
        rect(bx, by, bw*PHI, bh, 4);
        bh = random(cellW*PHI);
        by = (cellH/2)-(bh/2);
        fill(barClr);
        rect(bx, by, bw*PHI, bh, 4);
      }

      popMatrix();
    }
  }

  // draw the grid
  blendMode(MULTIPLY);  
  stroke(gridClr);
  strokeWeight(.47);
  float gridXNum = 29*cols;
  float gridXSpace = width/gridXNum;
  for (int i =0; i<gridXNum; i++) {
    float lx = map(i, 1, gridXNum, gridXSpace, width-gridXSpace);
    line(lx, 0, lx, height);
  }
  stroke(barClr, 76);
  strokeWeight(.47);
  float gridYNum = 11*cols;
  float gridYSpace = width/gridYNum;
  for (int j =1; j<gridYNum; j++) {
    float ly = map(j, 1, gridYNum, gridYSpace, height-gridXSpace);
    line(0, ly, width, ly);
  }
}


void keyPressed() {
  if (key == 's') {
    saveImage();
  } else {
    println("hello");
    render();
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
  print("saved: "+timestamp);
}