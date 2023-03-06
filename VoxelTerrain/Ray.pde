
void ray(float x, float y, float angle) {
  stroke(80, 255, 80);
  PVector traversed = rayTraversal(x, y, angle);
  line(x, y, traversed.x, traversed.y);
  fill(0, 255, 0);
  ellipse(traversed.x, traversed.y, 6, 6);
}

PVector rayTraversal(float x, float y, float angle) {
  QuadTree q = tree.getAt(x, y);

  if (q == null || q.value != 0) {
    return new PVector(x, y);
  }


  float disy = 9999, disx = 9999;
  if (angle <= 0) {
    disy = (q.y - y) / sin(angle);
  } else {
    disy = (q.y + q.h - y) / sin(angle);
  }

  if (angle < - PI / 2 || angle > PI / 2) {
    disx = (q.x - x) / cos(angle);
  } else {
    disx = (q.x + q.w - x) / cos(angle);
  }

  float dis;
  //if (Float.isInfinite(-disy))dis = disx;
  //else if (Float.isInfinite(-disx))dis = disy;
  //else dis = min(abs(disy), abs(disx));
  dis = min(abs(disy), abs(disx));
  dis += 0.01;
  float cx = x + cos(angle) * dis;
  // println("x: " + x + " / cx: " + cx + " / disx: " + disx + " / dis: " + dis);
  float cy = y + sin(angle) * dis;
  if (q == tree) {
    return new PVector(cx, cy);
  }

  return rayTraversal(cx, cy, angle);
}
