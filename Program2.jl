#------------------------------------------------------------------------------------------------------
# File: program2.jl
# Teacher: Beth Allen
# Class: CS 424-01
# Purpose: Create a program that takes a file full of player data and make calculations on that data,
# sort that data, and print out the calculated data to screen
# Programming Language: Julia 1.6.3
# System: Windows 10 
# Author: Joshua Orames, Nick Johnson
#------------------------------------------------------------------------------------------------------

using Printf

#------------------------------------------------------------------------------------------------------
#Functions that calculate the math of the program (batting average, slugging percentage, OBS, OPS)
#------------------------------------------------------------------------------------------------------

#Function to calculate batting average

function battingAvg(singles,doubles,triples,homeRuns,atBats)::Float64
temp=(singles+doubles+triples+homeRuns)/atBats
return temp
end

#Function to calculate slugging Percent

function sluggingPercent(singles,doubles,triples,homeRuns,atBats)::Float64
temp=(singles+2*doubles+3*triples+4*homeRuns)/atBats
return temp
end

#Function to calculate OBS

function OBS(singles,doubles,triples,homeRuns,walks,hitByPitch,plateAppearances)::Float64
temp=(singles+doubles+triples+homeRuns+walks+hitByPitch)/plateAppearances
return temp
end

#Function to calculate OPS

function OPS(OBS,sluggingPercent)::Float64
return(OBS+sluggingPercent)
end

#------------------------------------------------------------------------------------------------------
#Struct to hold player data from file
#------------------------------------------------------------------------------------------------------

struct player
	firstName::String
	lastName::String
	plateAppearances::Float64
	atBats::Float64
	singles::Float64
	doubles::Float64
	triples::Float64
	homeRuns::Float64
	walks::Float64
	hitByPitch::Float64
	
end

#------------------------------------------------------------------------------------------------------
#Arrays to hold data read in by file until it is placed into struct
#------------------------------------------------------------------------------------------------------

data=[]
playerData=[]

#------------------------------------------------------------------------------------------------------
#Formatted welcome screen with player input for file
#------------------------------------------------------------------------------------------------------
print("Welcome to the player statistics calculator test program. I am going to\nread ArrayofStructs from an input data file. You will tell me the name of\nyour input file. I will store all of the ArrayofStructs in a list,\ncompute each ArrayofStructs averages and then write teh resulting team report to\nthe screen.\n")

print("Enter the name of your input file: ")

#Input from user

input=readline()

#Opens file and reads it line by line and pushes data into a 2D array called data[] 

open("C:/Users/Orames/Desktop/"*input) do file
    for ln in eachline(file)
     #=   println("$(ln)")  =#
	push!(data,split(ln," "))
    end

println("BASEBALL TEAM REPORT --- ",countlines("C:/Users/Orames/Desktop/"*input)," PLAYERS FOUND IN FILE")

#------------------------------------------------------------------------------------------------------
#Intializing Array of player structs so that multiple ArrayofStructs will be put into an easily accessable array 
#------------------------------------------------------------------------------------------------------

ArrayofStructs=Array{player,1}(undef,countlines("C:/Users/Orames/Desktop/"*input))

#------------------------------------------------------------------------------------------------------
#Code to read file line by line and split line into a 2D array with places with no data taken out.
#2D array is put into a 1D array that has places with no data data out.
#------------------------------------------------------------------------------------------------------

#Nested loops that puts 2D array (data[][]) that holds file data and filters out places in array with no data and
#stores it into 1D array (playerData[])

for i in 1:countlines("C:/Users/Orames/Desktop/"*input)
for j in 1:length(data[i])
temp=data[i][j]
if(temp!="")
push!(playerData,data[i][j])
end
end
end

#------------------------------------------------------------------------------------------------------
#Array of player structs holds data from array playerData[] which stored file contents
#------------------------------------------------------------------------------------------------------
m=0

for i in 1:countlines("C:/Users/Orames/Desktop/"*input)
ArrayofStructs[i]=player(playerData[m+1],playerData[m+2],parse(Float64,playerData[m+3]),parse(Float64,playerData[m+4]),parse(Float64,playerData[m+5]),parse(Float64,playerData[m+6]),parse(Float64,playerData[m+7]),parse(Float64,playerData[m+8]),parse(Float64,playerData[m+9]),parse(Float64,playerData[m+10]))
m=m+10
end

#------------------------------------------------------------------------------------------------------
#Print player data
#------------------------------------------------------------------------------------------------------

@printf("\n")
println("    Player Name  :    Average  Slugging Onbase%  OPS     \n----------------------------------------------------------")
for j in 1:countlines("C:/Users/Orames/Desktop/"*input)
@printf("%7s, %7s : %8.3f %8.3f %8.3f %8.3f\n",ArrayofStructs[j].lastName,ArrayofStructs[j].firstName,battingAvg(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats),sluggingPercent(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats),OBS(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].walks,ArrayofStructs[j].hitByPitch,ArrayofStructs[j].plateAppearances),OPS(OBS(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].walks,ArrayofStructs[j].hitByPitch,ArrayofStructs[j].plateAppearances),sluggingPercent(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats)))
end

#Loop to swap OPS if higher

for i in 1:countlines("C:/Users/Orames/Desktop/"*input)
minInd=i
for j in 1:countlines("C:/Users/Orames/Desktop/"*input)
if(OPS(OBS(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].walks,ArrayofStructs[j].hitByPitch,ArrayofStructs[j].plateAppearances),sluggingPercent(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats))<OPS(OBS(ArrayofStructs[minInd].singles,ArrayofStructs[minInd].doubles,ArrayofStructs[minInd].triples,ArrayofStructs[minInd].homeRuns,ArrayofStructs[minInd].walks,ArrayofStructs[minInd].hitByPitch,ArrayofStructs[minInd].plateAppearances),sluggingPercent(ArrayofStructs[minInd].singles,ArrayofStructs[minInd].doubles,ArrayofStructs[minInd].triples,ArrayofStructs[minInd].homeRuns,ArrayofStructs[minInd].atBats)))
minInd=j
temp=ArrayofStructs[minInd]
ArrayofStructs[minInd]=ArrayofStructs[i]
ArrayofStructs[i]=temp
end
end
end

#Print by highest OPS

@printf("\n")
@printf("DESCENDING OPS \n")
println("    Player Name  :    Average  Slugging Onbase%  OPS     \n----------------------------------------------------------")
for j in 1:countlines("C:/Users/Orames/Desktop/"*input)
@printf("%7s, %7s : %8.3f %8.3f %8.3f %8.3f\n",ArrayofStructs[j].lastName,ArrayofStructs[j].firstName,battingAvg(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats),sluggingPercent(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats),OBS(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].walks,ArrayofStructs[j].hitByPitch,ArrayofStructs[j].plateAppearances),OPS(OBS(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].walks,ArrayofStructs[j].hitByPitch,ArrayofStructs[j].plateAppearances),sluggingPercent(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats)))
end

#Loop to swap batting average if higher

for i in 1:countlines("C:/Users/Orames/Desktop/"*input)
minInd=i
for j in 1:countlines("C:/Users/Orames/Desktop/"*input)
if(battingAvg(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats)<battingAvg(ArrayofStructs[minInd].singles,ArrayofStructs[minInd].doubles,ArrayofStructs[minInd].triples,ArrayofStructs[minInd].homeRuns,ArrayofStructs[minInd].atBats))
minInd=j
temp=ArrayofStructs[minInd]
ArrayofStructs[minInd]=ArrayofStructs[i]
ArrayofStructs[i]=temp
end
end
end

#Print by highest batting average

@printf("\n")
@printf("DESCENDING BATTING AVERAGE \n")
println("    Player Name  :    Average  Slugging Onbase%  OPS     \n----------------------------------------------------------")
for j in 1:countlines("C:/Users/Orames/Desktop/"*input)
@printf("%7s, %7s : %8.3f %8.3f %8.3f %8.3f\n",ArrayofStructs[j].lastName,ArrayofStructs[j].firstName,battingAvg(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats),sluggingPercent(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats),OBS(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].walks,ArrayofStructs[j].hitByPitch,ArrayofStructs[j].plateAppearances),OPS(OBS(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].walks,ArrayofStructs[j].hitByPitch,ArrayofStructs[j].plateAppearances),sluggingPercent(ArrayofStructs[j].singles,ArrayofStructs[j].doubles,ArrayofStructs[j].triples,ArrayofStructs[j].homeRuns,ArrayofStructs[j].atBats)))
end





end