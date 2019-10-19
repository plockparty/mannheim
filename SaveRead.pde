void saveQuads(ArrayList<int[]> quads){
  String[] quadString = new String[quads.size()];
  for(int i = 0; i < quads.size(); i++) {
     String current = "";  
    for(int q = 0; q < 8; q ++){
        current += quads.get(i)[q] + "\t";
      }
      quadString[i] = current;
  }
  saveStrings("quads.txt", quadString);
}

ArrayList<int[]> loadQuads() {
  String[] quads = loadStrings("quads.txt");
  if(quads == null){
    return new ArrayList();
  }
  ArrayList<int[]> qArray = new ArrayList<int[]>(); 
  for(int i = 0; i<quads.length; i++) {
    String[] coords = split(quads[i], '\t');
     int[] quad = new int[8];
      for(int q = 0; q < 8; q ++){
        quad[q] = int(coords[q]);
        System.out.println(quad[q]);

      }
    System.out.println(quad);

    qArray.add(quad);     
  }
  return qArray;
}
