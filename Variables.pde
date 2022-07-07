PFont fonte_8bit;
PImage drapeau;
int level;
int[][] tab_general = new int[7][9];
int x_ball, y_ball, x_ball_init, y_ball_init;
int x_drap, y_drap;
boolean menu;
int indX_ball, indY_ball, indX_ball_init, indY_ball_init;
boolean up, down, left, right;
boolean no_move;
boolean init, win;
PImage menu_bandeau;
String texte_menu;
String texte_difficulty;
int difficulty;
boolean gameOver = false;

//Variables pour le timer
float time = 0;
float time_left;
float contrainte_temps;
String timer;
String timer_left;
String[] tab_timer = new String[12];
float time_total = 0;
float time_total_record = 500;
String timer_total;
String timer_total_record;
boolean record = false;
String texte_record;

//Test
PrintWriter output;
String[] record_general = new String[1];
