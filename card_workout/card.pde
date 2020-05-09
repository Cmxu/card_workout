class Card { 
  int suit, number;
  float x, y;
  float size_x, size_y;
  boolean joker;
  float size_corner;
  Card (int s, int n, boolean j, float sx, float sy, float sc) {  
    suit = s;
    number = n;
    joker = j;
    size_x = sx;
    size_y = sy;
    size_corner = sc;
  } 
  
  void update(float xpos, float ypos){  
    x = xpos;
    y = ypos;
  }
  
  void draw(){
    draw_card(x, y, size_x, size_y, size_corner, 1);
  }
  
  void draw_card(float pos_x, float pos_y, float sx, float sy, float sc, float ts){
    fill(100);
    rect(pos_x, pos_y, sx, sy, sc);
    fill(255);
    rect(pos_x, pos_y, sx - offset, sy - offset, sc);
    if (suit % 2 == 1){
      fill(0);
    } else {
      fill(card_red);
    }
    textAlign(CORNER, CORNER);
    textSize(text_size * ts);
    if (number == 10){
      text(1, pos_x, pos_y + text_size * ts);
      text(0, pos_x + textWidth("1")/1.5, pos_y + text_size * ts);
    } else {
      text(card_names[number - 1], pos_x, pos_y + text_size * ts);
    }
    textSize(text_size);
    textAlign(CENTER, CENTER);
    image_scale(suit_images.get(suit - 1), pos_x + 1.25*small_suit_size * ts, pos_y + 8 * ts, small_suit_size * ts);
    image_scale(suit_images.get(suit - 1), pos_x + (card_size_x - big_suit_size)/2 * ts, pos_y + 38 * ts, big_suit_size * ts);
  }
  
  String toString(){
    return card_names[number - 1] + " " + suit_names[suit -1];
  }
} 
