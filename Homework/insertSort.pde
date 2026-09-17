//int len = 16, max = 100;
//int[] list;

//void setup() {
//  list = new int[len];

//  for (int i = 0; i < len; i++) {
//    list[i] = (int) random(max);
//  }

//  printList();
//  insertSort();
//  printList();
//}

//void draw() {
//}

//void printList() {
//  for (int i = 0; i < len; i++) {
//    print(nf(list[i], 3) + " ");
//  }
//  println();
//}

//void insertSort() {
//  int i, j, temp;
//  for (i = 1; i < len; i++) {
//    temp = list[i];
//    for (j = i - 1; j >= 0 && temp < list[j]; j--) {
//      list[j + 1] = list[j];
//    }
//    list[j + 1] = temp;
//  }
//}
