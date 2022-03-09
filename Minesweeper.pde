//display losing & winning message
import de.bezier.guido.*;
private final static int NUM_ROWS = 10;
private final static int NUM_COLS = 10;
private final static int NUM_MINES = 4;
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
   
    for (int i = 0; i < NUM_ROWS.2); i++) {
    setMines();
    }
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
            return true;
  /*  for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
            if(!mines.contains(buttons[r][c]))
                if(!buttons[r][c].isClicked())
                    return false;
    return true;   
    */
}
/*public void displayLosingMessage()
{
    for(int i = 0; i < mines.size(); i++)
        mines.get(i).mousePressed();
    fill(255);
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c].setLabel("");
            
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

        for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
        {
            
            
        }
    buttons[4][1].setLabel("Y");
    buttons[4][2].setLabel("O");
    buttons[4][3].setLabel("U");
    buttons[4][4].setLabel("W ");
    buttons[4][5].setLabel("O");
    buttons[4][6].setLabel("N");
    buttons[4][7].setLabel("!");


}
*/

public void displayLosingMessage()
{
    for (int i = 0; i < mines.size(); i++) {
      if (!mines.get(i).flagged)
        mines.get(i).clicked = true;
    }
    //your code here
    String[][] lose = { {"Y", "O", "U"}, {"L", "O", "S", "E"} };
    for (int i = 0; i < lose.length; i++) {
      for (int j = 0; j < lose[i].length; j++) {
        buttons[i][j].clicked = false;
        buttons[i][j].flagged = false;
        buttons[i][j].myLabel = m[i][j];
      }
    }
}
public void displayWinningMessage()
{
    //your code here
  String[][] win = { {"Y", "O", "U"}, {"W", "I", "N"} };
  for (int i = 0; i < win.length; i++) {
    for (int j = 0; j < win[i].length; j++) {
      buttons[i][j].clicked = false;
      buttons[i][j].flagged = false;
      buttons[i][j].myLabel = win[i][j];
    }
  }
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
    
     public boolean isClicked () {
    return clicked;
    }

    // called by manager
    public void mousePressed ()
    {
             clicked = true;
        if(mouseButton == RIGHT)
        {
            if(flagged == false)
                flagged = true;
            else
            {
                clicked = false;
                flagged = false;
            }
        }
        else if(!mines.contains(buttons[myRow][myCol]) && countMines(myRow, myCol) > 0)
        {
            setLabel(""+countMines(myRow, myCol));
//displayLosingMessage();
        }
    
        else
        {
            if(isValid(myRow-1, myCol) && !buttons[myRow-1][myCol].isClicked())
                buttons[myRow-1][myCol].mousePressed();
            if(isValid(myRow, myCol-1) && !buttons[myRow][myCol-1].isClicked())
                buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow, myCol+1) && !buttons[myRow][myCol+1].isClicked())
                buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow+1, myCol) && !buttons[myRow+1][myCol].isClicked())
                buttons[myRow+1][myCol].mousePressed();
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
