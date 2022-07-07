
void gen_tab()
{
  if (level <= 12)
  {
    String tab[] = loadStrings("niveau"+level+".iwk");
    for (int i = 0; i < 7; i++)
      for (int j = 0; j < 9; j++)
      {
        tab_general[i][j] = tab[i].charAt(j) - '0';
      }
  } else
    win = true;
}

void tab_display()
{
  //Generation de l'arrière plan
  for (int i = 0; i < 7; i++)
    for (int j = 0; j < 9; j++)
    {
      switch (tab_general[i][j])
      {
      case 0 : 
        fill(23, 159, 215);
        break;
      case 1 : 
        fill(156, 158, 162);
        break;
      case 2 : 
        fill(23, 159, 215);
        if (menu || init)
        {
          indX_ball_init = j;
          indY_ball_init = i;
          indX_ball = indX_ball_init;
          indY_ball = indY_ball_init;
          x_ball_init = indX_ball*50+25;
          y_ball_init = indY_ball*50+25;
          x_ball = x_ball_init;
          y_ball = y_ball_init;
        }
        break;
      case 3 :
        fill(23, 159, 215);
        x_drap = j;
        y_drap = i;
        break;
      }
      if (!menu && !win)
      {
        stroke(0);
        strokeWeight(2);
        rect(j*50, i*50, 50, 50);
        image(drapeau, x_drap*50+25, y_drap*50+25, 25, 35);
      }
    }
  // FAIRE LE Timer à chaque niveau et stocker dans un tableau pour l'afficher à la fin.

  if (!menu && !gameOver && !win)
  {
    textSize(12);
    fill(0);
    text("Temps : "+timer, 0.20*width, 375);
    if (time_left > 5 || time_left == 0)
      fill(0);
    else
      fill(255, 0, 0);
    text("Temps restant : " + timer_left, 0.70*width, 375);
    time += 0.03;
    time_left = contrainte_temps - time;
    timer_left = nf(time_left, 2, 2);
    timer = nf(time, 2, 2);

    //C'est perdu si le joueur met + de "contrainte_temps" à finir un niveau
    if (time > contrainte_temps)
    {
      gameOver = true;
      texte_menu = "Recommencer";
    }
  }
}

void level_up()
{
  if (no_move && tab_general[indY_ball][indX_ball] == 3)
  {
    if (level == 1)
      time_total = 0;
    tab_timer[level-1] = timer;
    time_total += time;
    time = 0;
    time_left = 0;
    level++;
    println(record_general[0]);
    init();
  }
}