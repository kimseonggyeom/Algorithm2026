int [] list = new int [1000];
int i, j, index, tmp, max;

for(i = 0; i < list.length; i++) {
  list[i] = (int)random(1000);
}

println(list.length);

for(i = 0; i < list.length; i++) {
  print(list[i], " ");
}
println();

for(i = 0; i < list.length - 1; i++) {
  max = -1;
  index = -1;
  for(j = 0; j <= list.length - i - 1; j++) {
    if(max < list[j]) {
      max = list[j];
      index = j;
    }
  }
  tmp = list[index];
  list[index] = list[list.length - 1 - i];
  list[list.length - 1 - i] = tmp;
}

for(i = 0; i < list.length; i++) {
  print(list[i], " ");
}
