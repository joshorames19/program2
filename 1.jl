function battingAvg(singles,doubles,triples,homeRuns,atBats)::Float64
temp=(singles+doubles+triples+homeRuns)/atBats
return temp
end

function sluggingPercent(singles,doubles,triples,homeRuns,atBats)::Float64
temp=(singles+2*doubles+3*triples+4*homeRuns)/atBats
return temp
end

function OBS(singles,doubles,triples,homeRuns,walks,hitByPitch,plateAppearances)::Float64
temp=(singles+doubles+triples+homeRuns+walks+hitByPitch)/plateAppearances
return temp
end

function OPS(OBS,sluggingPercent)::Float64
return(OBS+sluggingPercent)
end

struct player
	firstName::String
	lastName::String
	singles::Float64
	doubles::Float64
	triples::Float64
	atBats::Float64
	homeRuns::Float64
	walks::Float64
	hitByPitch::Float64
	plateAppearances::Float64
end

data=[]

print("Welcome to the player statistics calculator test program. I am going to\nread players from an input data file. You will tell me the name of\nyour input file. I will store all of the players in a list,\ncompute each players averages and then write teh resulting team report to\nthe screen.\n")

print("Enter the name of your input file: ")

input=readline()

open("C:/Users/Orames/Desktop/"*input) do file
    for ln in eachline(file)
     #=   println("$(ln)")  =#
	push!(data,split(ln," "))
    end

println("BASEBALL TEAM REPORT --- ",countlines("C:/Users/Orames/Desktop/"*input)," PLAYERS FOUND IN FILE")

#= println(data[5][1]) =#
println(data)

for i in 1:countlines("C:/Users/Orames/Desktop/"*input)
for j in 1:length(data[i])
temp=data[i][j]
if(temp!="")
print(data[i][j]*"\n")
end
end
end


end