#!/usr/bin/env python
# coding: utf-8

# ___
# 
# <a href='https://www.udemy.com/user/joseportilla/'><img src='../Pierian_Data_Logo.png'/></a>
# ___
# <center><em>Content Copyright by Pierian Data</em></center>

# # Milestone Project 1: Walkthrough Steps Workbook
# 
# Below is a set of steps for you to follow to try to create the Tic Tac Toe Milestone Project game!

# #### Some suggested tools before you get started:
# To take input from a user:
# 
#     player1 = input("Please pick a marker 'X' or 'O'")
#     
# Note that input() takes in a string. If you need an integer value, use
# 
#     position = int(input('Please enter a number'))
#     
# <br>To clear the screen between moves:
# 
#     from IPython.display import clear_output
#     clear_output()
#     
# Note that clear_output() will only work in jupyter. To clear the screen in other IDEs, consider:
# 
#     print('\n'*100)
#     
# This scrolls the previous board up out of view. Now on to the program!

# **Step 1: Write a function that can print out a board. Set up your board as a list, where each index 1-9 corresponds with a number on a number pad, so you get a 3 by 3 board representation.**

# In[50]:


from IPython.display import clear_output

def display_board(board):
    
    clear_output()
    
    print(board[7]+" ¦ "+board[8]+" ¦ "+board[9])
    print("---------")
    print(board[4]+" ¦ "+board[5]+" ¦ "+board[6])
    print("---------")
    print(board[1]+" ¦ "+board[2]+" ¦ "+board[3])
     

    
    pass


# **TEST Step 1:** run your function on a test version of the board list, and make adjustments as necessary

# In[51]:


test_board = ['#','X','O','X','O','X','O','X','O','X']
display_board(test_board)


# In[203]:


test_board = ['#','X','O','X','O','X','O','X','O','X']


# In[22]:


test_board[:3]


# **Step 2: Write a function that can take in a player input and assign their marker as 'X' or 'O'. Think about using *while* loops to continually ask until you get a correct answer.**

# In[209]:


def player_input():
    marker = "wrong"
    while marker not in ["X","O"] :
        
        
        marker = input("You are Player 1.\nWould you like to play as X or O?\n")
        
        if marker not in ["X","O"]:
            clear_output()
            print("I'm afraid that is not a valid marker. Please choose either X or O.")
            
    return marker   


# **TEST Step 2:** run the function to make sure it returns the desired output

# In[107]:


player_input()


# **Step 3: Write a function that takes in the board list object, a marker ('X' or 'O'), and a desired position (number 1-9) and assigns it to the board.**

# In[86]:


def place_marker(board, marker, position):
    
    board[position] = marker


# **TEST Step 3:** run the place marker function using test parameters and display the modified board

# In[89]:


place_marker(test_board,'£',8)
display_board(test_board)


# **Step 4: Write a function that takes in a board and a mark (X or O) and then checks to see if that mark has won. **

# In[93]:


def win_check(board, mark):
    if board[1] == board[2] == board[3] == mark:
        return True
    elif board[4] == board[5] == board[6] == mark:
        return True
    elif board[7] == board[8] == board[9] == mark:
        return True
    elif board[1] == board[4] == board[7] == mark:
        return True
    elif board[2] == board[5] == board[8] == mark:
        return True
    elif board[3] == board[6] == board[9] == mark:
        return True
    elif board[7] == board[5] == board[3] == mark:
        return True
    elif board[1] == board[5] == board[9] == mark:
        return True
    else:
        return False


# **TEST Step 4:** run the win_check function against our test_board - it should return True

# In[161]:


win_check(test_board,'X')


# **Step 5: Write a function that uses the random module to randomly decide which player goes first. You may want to lookup random.randint() Return a string of which player went first.**

# In[159]:


import random

def choose_first():
    playnum = random.randint(1,2)
    print(f"Player {playnum} will go first.")
    return playnum
    


# In[160]:


choose_first()


# **Step 6: Write a function that returns a boolean indicating whether a space on the board is freely available.**

# In[126]:


def space_check(empty_board, position):
    return board[position] == "X" or "O"


# In[127]:


space_check(test_board, 3)


# **Step 7: Write a function that checks if the board is full and returns a boolean value. True if full, False otherwise.**

# In[204]:


def full_board_check(board):
    total = 0
    for char in board:
        if char in ("X", "O"):
            total += 1
    return total==9
    
        
        


# In[205]:


full_board_check(test_board)


# **Step 8: Write a function that asks for a player's next position (as a number 1-9) and then uses the function from step 6 to check if it's a free position. If it is, then return the position for later use.**

# In[177]:


def player_choice(board):
    pos = True
    while pos:
        next_pos = int(input("Please choose a cell(1-9) to put your mark in. The position of each cell corresponds to the NUMPAD on your keyboard."))
        if next_pos in range(1,10):
            pos = False
            if (space_check(board, next_pos)):
                return next_pos
            else:
                pass
        else:
            pass
        
    


# In[178]:


player_choice(test_board)


# In[172]:



next_pos = int(input("Please choose a cell(1-9) to put your mark in. The position of each cell corresponds to the NUMPAD on your keyboard."))
if next_pos in range(1,10):
    pos = True
    if (space_check(board, next_pos)):
        pass
    else:
        return next_pos
else:
     pass


# In[173]:


next_pos = int(input("Please choose a cell(1-9) to put your mark in. The position of each cell corresponds to the NUMPAD on your keyboard."))


# In[174]:


next_pos


# **Step 9: Write a function that asks the player if they want to play again and returns a boolean True if they do want to play again.**

# In[147]:


def replay():
    again = True
    while again:
        gameon = input("Would you like to play again?\n Yes or No?")
    
        if gameon in ("Yes", "yes", "Y", "y"):
            return True
            again = False
        elif gameon in ("No", "no", "N", "n"):
            return False
            again = False
        else:
            again = True


# In[148]:


replay()


# **Step 10: Here comes the hard part! Use while loops and the functions you've made to run the game!**

# In[ ]:


while True:
    # Set the game up here
    print("Welcome to Tic Tac Toe!")
    empty_board = ['#','','','','','','','','','']
    p1_marker = player_input()
    p2_marker = "placeholder marker"
    
    if p1_marker == "X":
        p2_marker = "O"
    else:
        p2_marker = "X"
        
    if choose_first()==2:
        temp = p1_marker
        p1_marker = p2_marker
        p2_marker = temp
        
    if input("Are you ready to play?") in ("no","NO"):
        break
    else:
        pass
    
   
        
    
    
    game_on = True


    while game_on:
        #Player 1 Turn  
        display_board(empty_board)
        position = player_choice(empty_board)
        place_marker(empty_board, p1_marker, position)
        if win_check(empty_board, p1_marker) == True:
            print("Congratulations you WIN!")
            if replay() == True:
                game_on = True
                break
            else:
                game_on = False
                break
        else:
            pass
        
        if full_board_check(empty_board):
            print("It's a TIE!")
            if replay() == True:
                game_on = True
                break
            else:
                game_on = False
                break
        else:
            pass
        
        # Player2's turn
        display_board(empty_board)
        position = player_choice(empty_board)
        place_marker(empty_board, p2_marker, position)
        if win_check(empty_board, p2_marker) == True:
            print("Congratulations you WIN!")
            if replay() == True:
                game_on = True
                pass
            else:
                game_on = False
                break
        else:
            pass
        
        
        if full_board_check(empty_board):
            print("It's a TIE!")
            if replay() == True:
                game_on = True
                pass
            else:
                game_on = False
                break
        else:
            pass
    break
        
            
       

  


# In[ ]:





# ## Good Job!
