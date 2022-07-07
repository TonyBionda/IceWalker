void ball_display()
{
  if (!menu && !gameOver && !win)
  {
    noStroke();
    fill(225, 169, 26);
    ellipse(x_ball, y_ball, 30, 30);
  }
}

void mouvement_balle()
{
  if (right && indX_ball < 8)
    if (tab_general[indY_ball][indX_ball+1] != 1)
    {
      indX_ball += 1;
      x_ball = indX_ball*50+25;
    } else
      right = false;
  else
    right = false;

  if (left && indX_ball > 0)
    if (tab_general[indY_ball][indX_ball-1] != 1)
    {
      indX_ball -= 1;
      x_ball = indX_ball*50+25;
    } else
      left = false;
  else
    left = false;

  if (down && indY_ball < 6)
    if (tab_general[indY_ball+1][indX_ball] != 1)
    {
      indY_ball += 1;
      y_ball = indY_ball*50+25;
    } else
      down = false;
  else
    down = false;

  if (up && indY_ball > 0)
    if (tab_general[indY_ball-1][indX_ball] != 1)
    {
      indY_ball -= 1;
      y_ball = indY_ball*50+25;
    } else
      up = false;
  else
    up = false;
}
