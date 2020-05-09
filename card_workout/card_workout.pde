import java.util.*;

color background_color = color(255,153,204);
color background_color_dark = color(244,125,187);
color background_color_shadow = color(217,68,150);
color background_text_color = color(255,182,213);
color card_red = color(253, 10, 12);
float card_size_x = 60;
float card_size_y = 90;
float card_size_corner = 10;
float offset = 2;
float spacing = 20;
float spacing_x = card_size_x + spacing;
float spacing_y = card_size_y + spacing;
float border = 20;
float card_border = 3;
float text_size = 32;
float small_suit_size = 25;
float big_suit_size = 45;
PFont mono;
ArrayList<Card> deck;
ArrayList<Card> drawn_cards;
String[] card_names = {"A","2","3","4","5","6","7","8","9","10","J","Q","K"};
String[] suit_names = {"spade", "heart", "club", "diamond"};
PImage card_back;
ArrayList<PImage> suit_images;
boolean hover_card = false;

void setup() {
  mono = createFont("fonts/Roboto-Bold.ttf", text_size);
  size(1600, 900);
  textFont(mono);
  surface.setResizable(true);
  deck = new ArrayList<Card>();
  drawn_cards = new ArrayList<Card>();
  for(int suit = 1; suit <= 4; suit++){
    for(int number = 1; number <= 13; number++){
      deck.add(new Card(suit, number, false, card_size_x, card_size_y, card_size_corner)); 
    }
  }
  Collections.shuffle(deck);
  rectMode(CORNER);
  textAlign(CENTER, CENTER);
  noStroke();
  card_back = loadImage("resources/card_back_round_2.png");
  suit_images = new ArrayList<PImage>();
  for (int i = 0; i < 4; i++){
    suit_images.add(loadImage("resources/" +  suit_names[i] + ".png")); 
  }
  strokeWeight(10);
}

void draw() {
  update(mouseX, mouseY);
  background(background_color);
  draw_empty(); 
  draw_card_back(hover_card);
  draw_board();
  draw_recent();
}

void image_scale(PImage img, float pos_x, float pos_y, float sw){
  image(img, pos_x, pos_y, sw, img.height/float(img.width) * sw);
}

void draw_board(){
  for (Card temp_card : drawn_cards){
    temp_card.draw();  
  }
}

void draw_recent(){
  for (int i = 0; (i < drawn_cards.size()) && (i < 5); i++){  
    Card temp_card = drawn_cards.get(i);
    temp_card.draw_card(2.25*spacing_x*(i+1) + border, 6*border + 4 * spacing_y, 2*card_size_x, 2*card_size_y, 2*card_size_corner, 2);
  }
}

void mousePressed(){
  if (hover_card){
    drawCard();  
  }
}

void drawCard(){
  Card current_card = deck.remove(0);
  addCard(current_card);
  //println(current_card);
}

void addCard(Card current_card){
  current_card.update(spacing_x*(current_card.number-1) + border, spacing_y*(current_card.suit-1) + border);
  drawn_cards.add(0, current_card);
}

void update(int x, int y) {
  if ( overRect(border, 6*border + 4 * spacing_y, 2*card_size_x, 2*card_size_y) ) {
    hover_card = true;
  } else {
    hover_card = false;
  }
}

void draw_empty(){
  for(int suit = 1; suit <= 4; suit++){
    for(int number = 1; number <= 13; number++){
      fill(background_color_shadow);
      rect(spacing_x*(number-1) + border, spacing_y*(suit-1) + border, card_size_x, card_size_y, card_size_corner);
      fill(background_color_dark);
      rect(spacing_x*(number-1) + border + offset, spacing_y*(suit-1) + border + offset, card_size_x - offset, card_size_y - offset, card_size_corner);
      fill(background_text_color);
      text(card_names[number - 1], spacing_x*(number-1) + border + (card_size_x)/2, spacing_y*(suit-1) + border + (card_size_y)/2);
    }
  }
}

void draw_card_back(boolean hover){
  if (hover) {
    fill(200,200,200);
  } else {
    fill(255,255,255);
  }
  rect(border, 6*border + 4 * spacing_y, 2*card_size_x, 2*card_size_y, 2*card_size_corner);
  image(card_back, border + card_border, 6*border + 4 * spacing_y + card_border, 2*card_size_x - card_border *2, 2*card_size_y - card_border *2);
  
  textAlign(CENTER, CORNER);
  
  stroke(background_color_shadow);
  fill(background_color);
  rect(2.25*spacing_x*2 + border - card_size_x/4, 6*border + 4 * spacing_y - card_size_y/4, 2.5*card_size_x + 2*3*card_size_x + 2.25*spacing*4, 2.5*card_size_y, 2*card_size_corner);
  noStroke();
  fill(background_text_color);
  text("previous", 2.25*spacing_x*2 + border - card_size_x/4 + 1.25*card_size_x, 5.25*border + 4 * spacing_y - card_size_y/4);
  for(int i = 1; i <= 5; i++){
      if (i == 1){
          stroke(background_color_shadow);
          fill(background_color);
          rect(2.25*spacing_x*i + border - card_size_x/4, 6*border + 4 * spacing_y - card_size_y/4, 2.5*card_size_x, 2.5*card_size_y, 2*card_size_corner);
          noStroke();
          fill(background_text_color);
          text("current", 2.25*spacing_x*i + border - card_size_x/4 + 1.25*card_size_x, 5.25*border + 4 * spacing_y - card_size_y/4);
      }
      fill(background_color_shadow);
      rect(2.25*spacing_x*i + border, 6*border + 4 * spacing_y, 2*card_size_x, 2*card_size_y, 2*card_size_corner);
      fill(background_color_dark);
      rect(2.25*spacing_x*i + border + offset, 6*border + 4 * spacing_y + offset, 2*card_size_x - offset, 2*card_size_y - offset, 2*card_size_corner);
  }
  textAlign(CENTER, CENTER);
}

boolean overRect(float x, float y, float w, float h)  {
  if (mouseX >= x && mouseX <= x+w && 
      mouseY >= y && mouseY <= y+h) {
    return true;
  } else {
    return false;
  }
}
