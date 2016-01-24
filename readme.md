##About
Tic Tac Toe application

Run directly from the command line:
```
cd ~/path/to/tictactoe
ruby app.rb
```
To run tests, comment out line 12 in app.rb.

Winner dectection is performed by pushing the x and y coordinates of each move to a separate array on the Player object. Each incoming player move is checked against the contents of that array. If the board has three rows, the method will count the elements in the array that match the incoming move. For a game a game with a 3x3 grid, the method will check if there are 3 elements in the array that match. If so, the game is over. The diagonal win scenario is calculated in a similar fashion. If the x coordinate of the move matches the y coordinate of the move, an element is passed into an array of the Player object. Each subsequent move will check the length of the array and if it matches the row count of the grid, the game is over.

