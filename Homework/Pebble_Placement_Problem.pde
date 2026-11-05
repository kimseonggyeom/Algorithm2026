int n = 5; // 열(column)의 개수
int[][] w; // 각 열의 패턴별 가중치 w[열][패턴]
int[][] peb; // DP 테이블 peb[열][패턴]

void setup() {
  size(400, 200);
  noLoop();
  
  // 1부터 n, 1부터 4 인덱스를 그대로 쓰기 위해 공간을 1씩 더 크게 잡음
  w = new int[n + 1][5];
  peb = new int[n + 1][5];
  
  // 테스트용 랜덤 가중치 데이터 입력
  for (int i = 1; i <= n; i++) {
    w[i][1] = int(random(10, 50)); // 패턴 1
    w[i][2] = int(random(10, 50)); // 패턴 2
    w[i][3] = int(random(10, 50)); // 패턴 3
    w[i][4] = w[i][1] + w[i][3];   // 패턴 4 (1행 + 3행)
  }
  
  // DP 함수 실행
  int maxScore = pebbleSum(n);
  
  // 표 출력하기
  printTable();
  
  println("\n=============================================");
  println(" 🎉 조약돌 놓기 최종 최고 점수: " + maxScore);
  println("=============================================");
}

void draw() {
  background(230);
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("아래 콘솔(Console)창에서\n깔끔한 표를 확인해보세요!", width/2, height/2);
}

int pebbleSum(int n) {
  // Base case: 1번째 열 초기화
  for (int p = 1; p <= 4; p++) {
    peb[1][p] = w[1][p];
  }
  
  // DP 루프
  for (int i = 2; i <= n; i++) {
    for (int p = 1; p <= 4; p++) {
      int maxPrev = -1;
      
      if (p == 1)      maxPrev = max(peb[i-1][2], peb[i-1][3]);
      else if (p == 2) maxPrev = max(peb[i-1][1], max(peb[i-1][3], peb[i-1][4]));
      else if (p == 3) maxPrev = max(peb[i-1][1], peb[i-1][2]);
      else if (p == 4) maxPrev = peb[i-1][2];
      
      peb[i][p] = w[i][p] + maxPrev;
    }
  }
  
  // 최댓값 찾기
  int finalMax = peb[n][1];
  for (int p = 2; p <= 4; p++) {
    if (peb[n][p] > finalMax) finalMax = peb[n][p];
  }
  return finalMax;
}

// 가중치(w)와 DP 테이블(peb)을 표 형태로 출력하는 함수
void printTable() {
  println("\n=================[ 1. 가중치 테이블 (w) ]=================");
  printHeader();
  for (int p = 1; p <= 4; p++) {
    print(String.format("| 패턴 %d ", p));
    for (int i = 1; i <= n; i++) {
      print(String.format("|  %3d   ", w[i][p]));
    }
    println("|");
  }
  printFooter();

  println("\n=================[ 2. DP 테이블 (peb) ]=================");
  printHeader();
  for (int p = 1; p <= 4; p++) {
    print(String.format("| 패턴 %d ", p));
    for (int i = 1; i <= n; i++) {
      print(String.format("|  %3d   ", peb[i][p]));
    }
    println("|");
  }
  printFooter();
}

void printHeader() {
  print("|        ");
  for (int i = 1; i <= n; i++) {
    print(String.format("|  %d번열  ", i));
  }
  println("|");
  print("|--------");
  for (int i = 1; i <= n; i++) {
    print("|--------");
  }
  println("|");
}

void printFooter() {
  print("-----------------");
  for (int i = 1; i <= n; i++) {
    print("---------");
  }
  println();
}
