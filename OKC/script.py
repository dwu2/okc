#Darren Wu

import csv
import math

ARC3_LENGTH = 23.75

#Takes in parameters of location and returns shooting zone
def translateLocation(playerInfo): 
    x = abs(float(playerInfo[1]))
    y = (float(playerInfo[2]))

    if(y>7.8):
        if(ARC3_LENGTH < math.sqrt(y ** 2 + x ** 2)):
            return ("NC3")
        else:
            return ("2PT")     
    else:
        if(x>22):
            return("C3")
        else:
            return("2PT")

#calculates and prints the shot distribution
def shot_distribution(team):
    shot_map = {}
    total_shots = len(team)

    for player in team:
        if(player[2] not in shot_map):
            shot_map[player[2]] = 1
            continue
        else:
            shot_map[player[2]] += 1
    for area in shot_map:
        print(team[0][0]+ " Shot Distribution " + area + ": " + str(round(shot_map[area]/total_shots,3)))

#calculates the eFG given zone, shots made, shots taken
def calculate_eFG(a, shots):
    if a != "2PT":
        return (shots[0]*1.5)/shots[1]
    else:
        return (shots[0])/shots[1]

#Takes a team and returns the eFG for each
def eFG(team):
    fg_map = {}
    for player in team:
        if(player[2] not in fg_map):
            fg_map[player[2]] = [int(player[1]),1]
        else:
            if player[1] == "1":
                fg_map[player[2]][0] += 1
            fg_map[player[2]][1] += 1
    for area in fg_map:
        print(player[0] + " EFG " + area + ": " + str(round(calculate_eFG(area, fg_map[area]),3)))


#Iterate through csv, seperate into Team A and B
Team_A = []
Team_B = []

with open("shots_data.csv","r") as file:
    read = csv.reader(file, delimiter = "\t")
    next(read)
    for l, line in enumerate(read):
        player = line[0].split(",")
        shotType = translateLocation(player)
        player.pop(1)  #removing location parameters
        player.pop(1)
        player.append(shotType)

        #adding to respective team
        if player[0] == "Team A":
            Team_A.append(player)
        if player[0] == "Team B":
            Team_B.append(player)



shot_distribution(Team_A)
shot_distribution(Team_B)
eFG(Team_A)
eFG(Team_B)




