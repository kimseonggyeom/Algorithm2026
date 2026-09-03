int[] list = new int[1000];
print(list.length);
int[]sort = new int[0];
for(int i=0; i<list.length; i++) {
  list[i] = (int)random(1000);
  sort = append(sort, list[i]);
  for (int k=0; k<sort.length -1; k++) {
    for (int j=0; j <sort.length -1 -k; j++) {
      if (sort[j] > sort[j+1]) {
        int temp = sort[j+1];
        sort[j] = sort[j+1];
        sort[j+1] = temp;
      }
    }
  }
}
printArray(sort);

line(0,0, 100, 100);
