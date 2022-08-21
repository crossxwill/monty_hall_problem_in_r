### Monty Hall Problem in R -----

library(tidyverse)

set.seed(1)

### exactly 1 out of 3 doors has a car
### exactly 2 out of 3 doors has a goat

outcomes <- c("goat", "goat", "car")

### shuffle the outcomes across 3 doors

three_doors <- sample(outcomes, 3, replace=FALSE)

three_doors

### strategy 1: randomly pick a door and stick with the original choice

door_number <- c(1,2,3)

pick_a_door <- sample(door_number, 1, replace=FALSE)

pick_a_door

#### Did you win a car?

strat1_outcome <- three_doors[pick_a_door]=="car"

strat1_outcome

### strategy 2: randomly pick a door, game show host eliminates a door
### that contains a goat, and you switch to the last remaining door

remaining_doors <- door_number[-pick_a_door]

game_show_door <- remaining_doors[which(three_doors[remaining_doors] != "car")[1]]

last_remaining_door <- door_number[-c(pick_a_door, game_show_door)]

last_remaining_door

strat2_outcome <- three_doors[last_remaining_door]=="car"

strat2_outcome

#### repeat the game 100,000 times

play_one_game <- function(seed) {
  set.seed(seed)
  
  ### exactly 1 out of 3 doors has a car
  ### exactly 2 out of 3 doors has a goat
  
  outcomes <- c("goat", "goat", "car")
  
  ### shuffle the outcomes across 3 doors
  
  three_doors <- sample(outcomes, 3, replace=FALSE)
  
  three_doors
  
  ### strategy 1: randomly pick a door and stick with the original choice
  
  door_number <- c(1,2,3)
  
  pick_a_door <- sample(door_number, 1, replace=FALSE)
  
  pick_a_door
  
  #### Did you win a car?
  
  strat1_outcome <- three_doors[pick_a_door]=="car"
  
  strat1_outcome
  
  ### strategy 2: randomly pick a door, game show host eliminates a door
  ### that contains a goat, and you switch to the last remaining door
  
  remaining_doors <- door_number[-pick_a_door]
  
  game_show_door <- remaining_doors[which(three_doors[remaining_doors] != "car")[1]]
  
  last_remaining_door <- door_number[-c(pick_a_door, game_show_door)]
  
  last_remaining_door
  
  strat2_outcome <- three_doors[last_remaining_door]=="car"
  
  strat2_outcome
  
  return(data.frame(strat1 = strat1_outcome, strat2=strat2_outcome))
}


lots_of_games <- lapply(1:100000, play_one_game)

lots_of_games_df <- bind_rows(lots_of_games)

lapply(lots_of_games_df, mean)