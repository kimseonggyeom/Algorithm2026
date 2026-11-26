import java.util.ArrayList;
import java.util.Collections;

int numNodes = 12;
ArrayList<Node> baseNodes = new ArrayList<Node>();

// Kruskal용 변수
ArrayList<Edge> allEdges = new ArrayList<Edge>();
ArrayList<Edge> kruskalMST = new ArrayList<Edge>();
int[] parent;
int kEdgeIdx = 0;
boolean kFinished = false;
float kTotalCost = 0;

// Prim용 변수
ArrayList<Edge> primMST = new ArrayList<Edge>();
boolean[] pVisited;
boolean pFinished = false;
float pTotalCost = 0;

void setup() {
  size(1200, 600);
  frameRate(2); // 진행 속도 (숫자를 높이면 빨라짐)
  initGraph();
}

void draw() {
  background(245);
  
  // 중앙 구분선
  stroke(180);
  strokeWeight(2);
  line(width / 2, 0, width / 2, height);
  
  // 왼쪽: Kruskal / 오른쪽: Prim 그리기
  drawKruskal(0);
  drawPrim(width / 2);
  
  // 알고리즘 한 단계씩 진행
  stepKruskal();
  stepPrim();
}

void drawKruskal(float offsetX) {
  pushMatrix();
  translate(offsetX, 0);
  
  // 후보 간선 (연한 회색)
  for (Edge e : allEdges) {
    stroke(215);
    strokeWeight(1);
    line(e.u.x, e.u.y, e.v.x, e.v.y);
  }
  
  // 현재 검사 중인 간선 (주황색)
  if (!kFinished && kEdgeIdx < allEdges.size()) {
    Edge curr = allEdges.get(kEdgeIdx);
    stroke(255, 165, 0);
    strokeWeight(4);
    line(curr.u.x, curr.u.y, curr.v.x, curr.v.y);
  }
  
  // 확정된 MST 간선 (파란색)
  for (Edge e : kruskalMST) {
    stroke(30, 144, 255);
    strokeWeight(4);
    line(e.u.x, e.u.y, e.v.x, e.v.y);
  }
  
  // 노드 그리기
  for (Node n : baseNodes) {
    fill(255);
    stroke(50);
    strokeWeight(2);
    ellipse(n.x, n.y, 26, 26);
    
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(n.id, n.x, n.y);
  }
  
  // 상단 정보 텍스트
  fill(0);
  textAlign(LEFT, TOP);
  textSize(18);
  text("Kruskal's Algorithm (Edge-based)", 20, 20);
  textSize(14);
  text("Edges: " + kruskalMST.size() + " / " + (numNodes - 1) + "  |  Cost: " + nf(kTotalCost, 0, 1), 20, 48);
  if (kFinished) {
    fill(30, 144, 255);
    text("Status: Completed! (Click to Reset)", 20, 70);
  }
  
  popMatrix();
}

void drawPrim(float offsetX) {
  pushMatrix();
  translate(offsetX, 0);
  
  // 후보 간선 (연한 회색)
  for (Edge e : allEdges) {
    stroke(215);
    strokeWeight(1);
    line(e.u.x, e.u.y, e.v.x, e.v.y);
  }
  
  // 확정된 MST 간선 (초록색)
  for (Edge e : primMST) {
    stroke(46, 204, 113);
    strokeWeight(4);
    line(e.u.x, e.u.y, e.v.x, e.v.y);
  }
  
  // 노드 그리기
  for (Node n : baseNodes) {
    if (pVisited[n.id]) fill(46, 204, 113);
    else fill(255);
    
    stroke(50);
    strokeWeight(2);
    ellipse(n.x, n.y, 26, 26);
    
    fill(pVisited[n.id] ? 255 : 0);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(n.id, n.x, n.y);
  }
  
  // 상단 정보 텍스트
  fill(0);
  textAlign(LEFT, TOP);
  textSize(18);
  text("Prim's Algorithm (Vertex-based)", 20, 20);
  textSize(14);
  text("Edges: " + primMST.size() + " / " + (numNodes - 1) + "  |  Cost: " + nf(pTotalCost, 0, 1), 20, 48);
  if (pFinished) {
    fill(39, 174, 96);
    text("Status: Completed! (Click to Reset)", 20, 70);
  }
  
  popMatrix();
}

void stepKruskal() {
  if (kFinished) return;
  
  if (kEdgeIdx < allEdges.size() && kruskalMST.size() < numNodes - 1) {
    Edge e = allEdges.get(kEdgeIdx);
    int rootU = find(e.u.id);
    int rootV = find(e.v.id);
    
    if (rootU != rootV) {
      union(rootU, rootV);
      kruskalMST.add(e);
      kTotalCost += e.weight;
    }
    kEdgeIdx++;
  } else {
    kFinished = true;
  }
}

void stepPrim() {
  if (pFinished) return;
  
  float minDist = Float.MAX_VALUE;
  Node bestU = null;
  Node bestV = null;
  
  for (int i = 0; i < numNodes; i++) {
    if (pVisited[i]) {
      for (int j = 0; j < numNodes; j++) {
        if (!pVisited[j]) {
          float d = dist(baseNodes.get(i).x, baseNodes.get(i).y, baseNodes.get(j).x, baseNodes.get(j).y);
          if (d < minDist) {
            minDist = d;
            bestU = baseNodes.get(i);
            bestV = baseNodes.get(j);
          }
        }
      }
    }
  }
  
  if (bestU != null && bestV != null) {
    pVisited[bestV.id] = true;
    primMST.add(new Edge(bestU, bestV, minDist));
    pTotalCost += minDist;
  } else {
    pFinished = true;
  }
}

void initGraph() {
  baseNodes.clear();
  allEdges.clear();
  kruskalMST.clear();
  primMST.clear();
  
  kEdgeIdx = 0;
  kFinished = false;
  kTotalCost = 0;
  
  pFinished = false;
  pTotalCost = 0;
  pVisited = new boolean[numNodes];
  
  // 노드 위치 랜덤 생성
  for (int i = 0; i < numNodes; i++) {
    baseNodes.add(new Node(i, random(60, width / 2 - 60), random(110, height - 60)));
  }
  
  // 모든 간선 생성 및 거리순 정렬
  for (int i = 0; i < numNodes; i++) {
    for (int j = i + 1; j < numNodes; j++) {
      float d = dist(baseNodes.get(i).x, baseNodes.get(i).y, baseNodes.get(j).x, baseNodes.get(j).y);
      allEdges.add(new Edge(baseNodes.get(i), baseNodes.get(j), d));
    }
  }
  Collections.sort(allEdges);
  
  // Union-Find 초기화
  parent = new int[numNodes];
  for (int i = 0; i < numNodes; i++) parent[i] = i;
  
  // Prim 알고리즘 시작점(0번 노드) 방문 처리
  pVisited[0] = true;
}

int find(int i) {
  if (parent[i] == i) return i;
  return parent[i] = find(parent[i]);
}

void union(int i, int j) {
  parent[i] = j;
}

void mousePressed() {
  initGraph();
}

class Node {
  int id;
  float x, y;
  Node(int id, float x, float y) {
    this.id = id;
    this.x = x;
    this.y = y;
  }
}

class Edge implements Comparable<Edge> {
  Node u, v;
  float weight;
  Edge(Node u, Node v, float w) {
    this.u = u;
    this.v = v;
    this.weight = w;
  }
  int compareTo(Edge other) {
    return Float.compare(this.weight, other.weight);
  }
}
