
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

void setup() {
  String[] cameras = Capture.list();
  for(int i = 0;i<cameras.length;i++)
  {
    println(cameras[i]);
  }
  size(640, 480);
  video = new Capture(this, cameras[1]);
  opencv = new OpenCV(this, cameras[1]);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 
  

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    point(faces[i].x - faces[i].y, faces[i].width - faces[i].height);
  }
}

void captureEvent(Capture c) {
  c.read();
}


//Facial detection code yoinked from https://github.com/atduskgreg/opencv-processing/blob/master/examples/LiveCamTest/LiveCamTest.pde
