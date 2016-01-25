##About
Tic Tac Toe application

Run directly from the command line:
```
~/path/to/tictactoe/app.rb
```
Run tests with:
```
cd ~/path/to/tictactoe
rspec spec
```

Winner dectection is performed by pushing the x and y coordinates of each move to a separate array on the Player object. Each incoming player move is checked against the contents of that array. The method counts the elements in the array that match the incoming move. For a board with three rows, the method will check if there are 3 elements in the array that match; if this returns true, the game is over. The diagonal win scenario is calculated in a similar fashion. If the x coordinate matches the y coordinate of the move, an element is passed into an array of the Player object. After each move, the method will check the length of that array and if it matches the row count of the grid, the game is over.

