int len = 16;
int max = 100;
int[] list;

void setup() {
  list = new int[len];

  for (int i = 0; i < len; i++) {
    list[i] = (int)random(max);
  }

  printList();
  heapSort();
  printList();
}

void draw() {
}

void printList() {
  for (int i = 0; i < len; i++) {
    print(nf(list[i], 3) + " ");
  }
  println();
}

void heapSort() {
  buildHeap();

  for (int i = len - 1; i > 0; i--) {
    swap(0, i);
    heapify(0, i);
  }
}

void buildHeap() {
  for (int i = len / 2 - 1; i >= 0; i--) {
    heapify(i, len);
  }
}

void heapify(int i, int n) {
  int left = 2 * i + 1;
  int right = 2 * i + 2;
  int largest = i;

  if (left < n && list[left] > list[largest]) {
    largest = left;
  }

  if (right < n && list[right] > list[largest]) {
    largest = right;
  }

  if (largest != i) {
    swap(i, largest);
    heapify(largest, n);
  }
}

void swap(int i, int j) {
  int temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}
