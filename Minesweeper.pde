import de.bezier.guido.*;
private final static int NUM_ROWS = 5;
private final static int NUM_COLS = 5;
private final static int NUM_MINES = 2;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
   
    // make the manager
    Interactive.make( this );
   
    //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < NUM_ROWS; r ++)
  for ( int c = 0; c < NUM_COLS; c++)
    buttons[r][c] = new MSButton(r,c);
   
    setMines();
}
public void setMines()
{
    //your code
    while(mines.size() < NUM_MINES)
    {
      int r = (int)(Math.random()* NUM_ROWS);
      int c = (int)(Math.random()* NUM_COLS);  
      if (mines.contains(buttons[r][c]) == false)  // checks if button at random row & col is in mines
      {
    mines.add(buttons[r][c]);
   // System.out.println(r + "," + c);
     }
    }
}
public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
     for(int i = 0; i < mines.size(); i++)
        if(!mines.get(i).isFlagged())
            return false;
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
            if(!mines.contains(buttons[r][c]))
                if(!buttons[r][c].isClicked())
                    return false;
    return true;   
}
public void displayLosingMessage()
{
    //your code here
 /*   for (int r = 0; r < NUM_ROWS; r++){
  for (int c = 0; c < NUM_COLS; c++){
     if( !buttons[r][c].clicked && mines.contains(buttons[r][c])){
     buttons[r][c].flagged = false;
      buttons[r][c].clicked = true;
      buttons[0][0].setLabel("Y");
       buttons[0][1].setLabel("O");
        buttons[0][2].setLabel("U");
         buttons[0][3].setLabel(" ");
          buttons[0][4].setLabel("L");
           buttons[0][5].setLabel("O");
            buttons[0][6].setLabel("S");
             buttons[0][7].setLabel("T");
              buttons[0][7].setLabel(":(");
     }
  }
      }
} */
    for(int i = 0; i < bombs.size(); i++)
        bombs.get(i).mousePressed();
    fill(255);
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c].setLabel("");
            buttons[r][c].setColr(0, 0, 0);
        }
    buttons[4][1].setLabel("Y");
    buttons[4][2].setLabel("O");
    buttons[4][3].setLabel("U");
    buttons[4][5].setLabel("L");
    buttons[4][6].setLabel("O");
    buttons[4][7].setLabel("S");
    buttons[4][8].setLabel("E");
}
public void displayWinningMessage()
{
/*
      buttons[0][0].setLabel("Y");
       buttons[0][1].setLabel("O");
        buttons[0][2].setLabel("U");
         buttons[0][3].setLabel(" ");
          buttons[0][4].setLabel("W");
           buttons[0][5].setLabel("O");
            buttons[0][6].setLabel("N");
             buttons[0][7].setLabel(":D");
            */
        for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c].setLabel("");
            buttons[r][c].setColr(255, 255, 0);
        }
    buttons[4][1].setLabel("C");
    buttons[4][2].setLabel("O");
    buttons[4][3].setLabel("N");
    buttons[4][4].setLabel("G");
    buttons[4][5].setLabel("R");
    buttons[4][6].setLabel("A");
    buttons[4][7].setLabel("T");
    buttons[4][8].setLabel("S");

}
public boolean isValid(int r, int c)
{
    //your code here
    if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    return true;
    else
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    for (int r = row-1; r<=row + 1; r++)
    for (int c = col-1; c<=col + 1; c++)
    if (isValid(r,c) && mines.contains(buttons[r][c]) == true) // checks if it is valid & if it is a mine
    numMines ++;
    if (mines.contains(buttons[row][col]) == true)
    numMines --;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
   
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col;
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed ()
    {
        /* clicked = true;
        //your code here
        if (mouseButton == RIGHT )
        flagged = !flagged;
        if (flagged == false)
        clicked = false;
        else if (mines.contains(this))
        displayLosingMessage();
        else if (countMines(myRow,myCol) > 0)
        setLabel(countMines(myRow, myCol));
        else
    for (int r = myRow-1; r<=myRow + 1; r++)
    for (int c = myCol-1; c<=myCol + 1; c++)
        if(isValid(r,c-1) && !buttons[r][c-1].clicked)
       */ buttons[r][c].mousePressed();
       
             clicked = true;
        //your code here
        if(mouseButton == RIGHT)
        {
            if(marked == false)
                marked = true;
            else
            {
                clicked = false;
                marked = false;
            }
        }
        else if(!bombs.contains(buttons[r][c]) && countBombs(r, c) > 0)
        {
            setLabel(""+countBombs(r, c));
        }
        else
        {
            if(isValid(r-1, c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();
            if(isValid(r, c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();
            if(isValid(r, c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();
            if(isValid(r+1, c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();
               }
       
    }
   
    public void draw ()
    {    
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) )
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
