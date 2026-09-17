//int len = 16, max = 100;
//int[] list;

//void setup() {
//  list = new int[len];

//  for (int i = 0; i < len; i++) {
//    list[i] = (int) random(max);
//  }

//  printList();
//  mergeSort();
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

//void mergeSort() {
//  mergeSort(0, len - 1);
//}

//void mergeSort(int low, int high) {

//  if (low < high) {

//    int middle = low + (high - low) / 2;

//    mergeSort(low, middle);

//    mergeSort(middle + 1, high);

//    merge(low, middle, high);

//    println("mergeSort " + low + " " + high);
//  }
//}

//void merge(int left, int mid, int right) {

//  int n1 = mid - left + 1;
//  int n2 = right - mid;

//  int[] leftArr = new int[n1];
//  int[] rightArr = new int[n2];

//  arrayCopy(list, left, leftArr, 0, n1);

//  arrayCopy(list, mid + 1, rightArr, 0, n2);

//  int i = 0;
//  int j = 0;
//  int k = left;

//  while (i < n1 && j < n2) {

//    if (leftArr[i] <= rightArr[j]) {
//      list[k] = leftArr[i];
//      i++;
//    } 
//    else {
//      list[k] = rightArr[j];
//      j++;
//    }

//    k++;
//  }

//  while (i < n1) {
//    list[k] = leftArr[i];
//    i++;
//    k++;
//  }

//  while (j < n2) {
//    list[k] = rightArr[j];
//    j++;
//    k++;
//  }
//}
