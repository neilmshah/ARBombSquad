# AR-Bomb-Squad
## Team: Neil Shah, Akshat Goel, Julie Bao

**AR Bomb Squad** is an iOS game implemented using Augmented Reality that will feature upto 10+ stages where the user will have to find and disarm bombs spread across the surroundings. 
Disarming all the bombs successfully within the given time limit would take the user onto the next stage. 
Each user would have a login profile that uses parse as the backend to store user profile details along with progress, etc. 


## Functional stories
- [X] Implement an initial screen that will consist of several options - login, quick start, settings, high scores and about. 
- [x] Implement login that takes the user to a login screen that will use parse as the back end to store each users details - id, highscores, etc
- [X] Implement screen to display the different stages and level of the game.
- [X] User apple's ARKit to model bomb elements in the surroundings that the user can see when he starts the game and it switches    to the camera
- [x] Create a timer countdown that gives the user a set time to finish each stage
- [x] Create 3D models for defuse laser and bombs.
- [x] Create sceneKit scene for the target.
- [X]Create game flow when stage is sucess and stage is failed.
- [x] Apply physics to shots and bombs distance.
- [x] Implement a design so that it'll be modular in a way, it'll be easier to add another stage and models for the same.
- [x] Optimise it for tablets and iphone of all screens.
- [x] Initialize the AR scene config and align current position of camera to orientation and camera.
- [x] Set coordinates for the different objects.
- [] Add sound effects to the fire moment.
- [] Add animation when bomb is diffused using xcode 3d editor.
- [] Implement the settings page, where the user can change game settings such as music, difficulty, brightness, etc. 
- [] Implement the high score page, which will list the top 5 scores in the game amongst all users worldwide that play the game
- [] Design at least 10 stages to kick start the game.
- [] Form different disarm devices that user can use to disarm the bomb once he approaches a certain proximity


## Tables and columns needed in parse

Two Tables 
1. Global table
2. User local table

Columns
1.1 - Username, High Scores
1.2 - Username, User High Scores

## Akshat - Worked on launch screen and home screen. Working on scenekit and ARkit for the game play.

## Neil -  Worked on levels screen. Now working on design flow from one stage to another and in case of failure and success and pop ups that give interactive feel for the game.

## Julie - Worked on launch screen and home screen and now working on design of stages and 3D models.



