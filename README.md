# AR-Bomb-Squad

**AR Bomb Squad** is an iOS game implemented using Augmented Reality that will feature upto 10+ stages where the user will have to find and disarm bombs spread across the surroundings. 
Disarming all the bombs successfully within the given time limit would take the user onto the next stage. 
Each user would have a login profile that uses parse as the backend to store user profile details along with progress, etc. 


## Functional stories
- Implement an initial screen that will consist of several options - login, quick start, settings, high scores and about. 
- Login takes the user to a login screen that will use parse as the back end to store each users details - id, highscores, etc
- Quick start would take the user directly to the first stage to give him/her an idea of the feel of the game
- Settings is where the user can change game settings such as music, difficulty, brightness, etc. 
- high scores will list the top 5 scores in the game amongst all users worldwide that play the game
- Implement screen to display the different stages and level
- User apple's ARKit to model bomb elements in the surroundings that the user can see when he starts the game and it switches to the camera
- Form different disarm devices that user can use to disarm the bomb once he approaches a certain proximity
- Create a timer countdown that gives the user a set time to finish each stage
- Increase difficulty level by placing obsticals to hide the bomb and giving a shorter time to find and disarm the bomb. Will also modify disarming devices and create multiple devices for disarming different types of bombs.

## Tables and columns needed in parse

Two Tables 
1. Global table
2. User local table

Columns
1.1 - Username, High Scores
1.2 - Username, User High Scores



