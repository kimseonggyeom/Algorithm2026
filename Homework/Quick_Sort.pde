int len = 16, max = 100;
int[] list;

void setup() {
  list = new int[len];

  for (int i = 0; i < len; i++) {
    list[i] = (int) random(max);
  }
  
  printList();
  quickSort();
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

void quickSort() {
  quickSort(0, len - 1);
}

void quickSort(int low, int high) {
  if (low < high) {
    int pi = partition(low, high);
    quickSort(low, pi - 1);
    quickSort(pi + 1, high);
  }
}

int partition(int low, int high) {
  int pivot = list[high];
  int i = low - 1;
  for (int j = low; j < high; j++) {
    if (list[j] <= pivot) {
      i++;
      swap(list, i, j);
    }
  }
  swap(list, i + 1, high);
  return i + 1;
}

void swap(int[] arr, int i, int j) {

  int tmp = arr[j];

  arr[j] = arr[i];
  arr[i] = tmp;
}
