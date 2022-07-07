void setup()
{
  size(451, 400);
  difficulty = 1; //Version facile du jeu
  menu = true;
  win = false;
  texte_menu = "Commencer";
  //Images et fonte
  fonte_8bit = createFont("joystix.ttf", 20); //Police de texte
  drapeau = loadImage("flag.png");
  menu_bandeau = loadImage("img_menu.png");
  //Définition des règles
  ellipseMode(CENTER);
  imageMode(CENTER);
  //Lance la partie
  level = 1;
  init();
}

void draw()
{
  frameRate(35);
  record_general = loadStrings("highscore.txt");
  if (win)
  {
    background(135, 206, 235);
    display_win();
  } else if (!gameOver)
    background(255);
  if (menu)
    display_menu();

  tab_display();
  ball_display();
  mouvement_balle();

  if (gameOver)
    display_gameOver();

  if (!right && !left && !up && !down)
    no_move = true;
  else
    no_move = false;

  level_up();
}

void init()
{
  init = true;
  up = false;
  down = false;
  left = false;
  right = false;
  textAlign(CENTER, CENTER);
  time = 0;

  gen_tab();
  if (win && time_total_record > time_total)
    time_total_record = time_total;
  if (level <= 12)
    println("Niveau actuel : " + level);
  else
    println("BRAVO");
}

void keyPressed()
{
  if (key == 'r' && !win && !gameOver)
  {
    indX_ball = indX_ball_init;
    indY_ball = indY_ball_init;
    x_ball = x_ball_init;
    y_ball = y_ball_init;
  }
  if (menu)
    menu = false;
  else if (no_move)
  {
    switch (keyCode) {
    case RIGHT :
      right = true;
      left = false;
      up = false;
      down = false;
      break;
    case LEFT :
      right = false;
      left = true;
      up = false;
      down = false;
      break;
    case DOWN :
      right = false;
      left = false;
      up = false;
      down = true;
      break;
    case UP :
      right = false;
      left = false;
      up = true;
      down = false;
      break;
    }
  }
  if (key == 'm' && !win && !gameOver && !menu)
    menu = true;
  if (init)
    init = false;
  if (win)
  {
    win = false;
    menu = true;
    texte_menu = "Commencer";
  }
  if (gameOver)
  {
    gameOver = false;
    menu = true;
  }
}


void mouseClicked()
{
  if (mouseX >= 0 && mouseX < width/2 - 75 && mouseY > 300 && mouseY < 395) //rectangle du bas
    difficulty -= 1;
  if (mouseX > width/2 + 75 && mouseX <= width && mouseY > 300 && mouseY < 395) //rectangle du haut
    difficulty +=1;
}


//
//Procédure qui va s'occuper de l'écran de fin de partie, c'est à dire la victoire
//et qui va aussi calculer quoi afficher.
//
void display_win()
{
  //A completer
  timer_total = nf(time_total, 2, 2);
  timer_total_record = nf(time_total_record, 2, 2);
  if (time_total <= time_total_record)
  {
    record = true;
  } else
    record = false;

  textAlign(LEFT, CENTER);
  textFont(fonte_8bit);
  stroke(0);
  fill(200);
  rect(0.6*width-10, 0.1*height, 158, 48);
  fill(255);
  rect(0.6*width-10, 0.1*height+48, 158, 255);
  fill(0);
  textSize(20);
  text("IceWalker", 65, 20);
  textSize(10);
  text("Bravo, vous avez gagné", 50, 40);
  text("Temps global : " + timer_total + " sec.", 20, 80);
  if (record)
  {
    texte_record = " maintenant ";
    text("Félicitation !", 55, 110);
    text("Vous avez un nouveau meilleur", 10, 140);
    text("temps global !", 10, 155);
  } else
  {
    texte_record = " ";
    text("Vous n'avez pas battu", 10, 120);
    text("votre record", 10, 135);
  }
  String record_gen_str = record_general[0];
  float record_gen = Float.parseFloat(record_gen_str);
  if (record_gen > time_total || record_gen > time_total_record)
    if (record)
    {
      output = createWriter("highscore.txt");
      output.print(time_total);
      output.flush();
      output.close();
    } else
    {
      output = createWriter("highscore.txt");
      output.print(time_total_record);
      output.flush();
      output.close();
    }

  String record_gen_nf = nf(record_gen, 3, 2);
  text("Meilleur temps toute session confondue : " + record_gen_nf + " sec", 30, 380);
  text("Votre meilleur temps global", 10, 180);
  text("lors de cette session", 10, 195);
  if (record)
    text("est" + texte_record + "de " + timer_total + " sec.", 10, 210);
  else
    text("est" + texte_record + "de " + timer_total_record + " sec.", 10, 210);

  text("Temps(sec) : ", 0.6*width+25, 0.15*height);
  for (int k = 0; k < tab_timer.length; k++)
  {
    textSize(8);
    if (k < 9)
      text("Niveau " + (k+1) + "   :   " + tab_timer[k], 0.6*width, k*20 + height/4);
    else
      text("Niveau " + (k+1) + "  :   " + tab_timer[k], 0.6*width, k*20 + height/4);
  }
}

void display_menu()
{
  textFont(fonte_8bit);
  //à completer, affichage du menu
  fill(0, 148, 169);
  strokeWeight(1);
  image(menu_bandeau, width/2, 395);
  image(drapeau, 425, 372, 30, 35);
  rect(-1, 300, 452, 45);

  switch (difficulty)
  {
  case 0 : 
    difficulty = 5;
    texte_difficulty = "Impossible";
    contrainte_temps = 4;
    break;
  case 1 : 
    texte_difficulty = "Facile";
    contrainte_temps = 40;
    break;
  case 2 : 
    texte_difficulty = "Moyen";
    contrainte_temps = 20;
    break;
  case 3 : 
    texte_difficulty = "Avancé";
    contrainte_temps = 12;
    break;
  case 4 : 
    texte_difficulty = "Maître";
    contrainte_temps = 7;
    break;
  case 5 : 
    texte_difficulty = "Impossible";
    contrainte_temps = 4;
    break;
  case 6 : 
    difficulty = 1;
    texte_difficulty = "Facile";
    contrainte_temps = 40;
    break;
  }
  fill(0);
  triangle(150, 322, 155, 317, 155, 327);
  triangle(305, 322, 300, 317, 300, 327);
  textSize(25);
  text("IceWalker", width/2, 50);
  textSize(15);
  text("Bonne chance fdp", width/2, 70);
  text(texte_menu, width/2, height/2);
  text(texte_difficulty, width/2, 0.8*height);
  level = 1;
  init();
}

void display_gameOver()
{
  background(255, 5);
  fill(0);
  text("PERDU", width/2, height/2);
}