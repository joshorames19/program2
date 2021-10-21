//------------------------------------------------------------------------------------------------------
// File: program1.go
// Teacher: Beth Allen
// Class: CS 424-01
// Purpose: reate a program that takes a file full of player data and make calculations on that data,
// sort that data, and print out the calculated data to screen
// Programming Language: GO 1.17
// System: Windows 10 
// Author: Joshua Orames
//------------------------------------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////////////////////////////
//Packages needed to run program including string conversion package and a few for file and formatting 
////////////////////////////////////////////////////////////////////////////////////////////////////////
  
package main
import "fmt"
import "os"
import "log"
import "bufio"
import "strconv"

//////////////////////////////////////////////////////////////
//Struct to keep and organize individual data of each player 
/////////////////////////////////////////////////////////////

type Player struct 
{
firstName	string		//first name of player
lastName	string		//last name of player
plateAppearances float64	//number of plate appearances
atBats	float64			//number of times up to bat
singles	float64			//number of singles that player has
doubles	float64			//number of doubles that player has
triples	float64			//number of triples that player has
homeRuns float64		//number of homeruns that player has
walks	float64			//number of walks that player has
hitByPitch float64		//number of hits thrown by pitcher
battingAvg float64		//batting average of player
slugging float64		//slugging percent of player
onBase float64			//on-base percentage of player
ops float64			//on-bat plus slugging percentage of player
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
//Function calculating batting average of players using the parameters needed to calculate the average
///////////////////////////////////////////////////////////////////////////////////////////////////////

func battingAverage(singles float64, doubles float64, triples float64, homeRuns float64, atBats float64) float64 {
	var temp float64 = float64((singles+doubles+triples+homeRuns)/atBats)		
	return(temp)		//returns float so that the decimal is there and not thrown away
}

///////////////////////////////////////////////////////////////////////////////////////////////
//Function calculating slugging percentage of players using the parameters needed to calculate
////////////////////////////////////////////////////////////////////////////////////////////////

func sluggingPercent(singles float64, doubles float64, triples float64, homeRuns float64, atBats float64) float64 {
	var temp float64 =float64((singles+2*doubles+3*triples+4*homeRuns)/atBats)		
	return(temp)		//returns float so that the decimal is there and not thrown away
}

//////////////////////////////////////////////////////////////////////////////////////////////
//Function calculating on-base percentage of players using the parameters needed to calculate
//////////////////////////////////////////////////////////////////////////////////////////////

func OBS(singles float64, doubles float64, triples float64, homeRuns float64, walks float64, hitByPitch float64, plateAppearances float64) float64 {
	var temp float64=float64((singles+doubles+triples+homeRuns+walks+hitByPitch) / plateAppearances)
	return(temp)		//returns float so that the decimal is there and not thrown away
}

////////////////////////////////////////////////////////////////////////////////////////////////
//Function calculating on-bat plus slugging of players using the parameters needed to calculate
////////////////////////////////////////////////////////////////////////////////////////////////

func OPS(OBS float64, sluggingPercent float64) float64 {
	return(OBS+sluggingPercent)		//returns float so that the decimal is there and not thrown away
}

////////////////
//main function 
///////////////

func main() {

///////////////////////////////////////
//Declaring and Initializing variables
//////////////////////////////////////

var count int=0			//integer that keeps track of index of array and the 10 pieces of data making up th Player struct
var a [11]string		//array that temporarily hold data of the player		
var players = []*Player{}	//creates and array of players
var fileName string 		//stores filename of player data
var playerCount int=0		//keeps track of the amount of players

//////////////////////////////////////////////////////
//Display prompt and take in user input for file name
/////////////////////////////////////////////////////

    fmt.Printf("Welcome to the player statistics calculator test program. I am going to \nread players from an input file. You will tell me the name of \nyour input file. I will store all of the players in a list, \ncompute each player's averages and then write the resulting team report to \nyour output file. \n")
    fmt.Println("Enter File Name: ")
  
    fmt.Scanln(&fileName)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Open file and read contents of file word by word and pass the data to the player struct in which is passed to a player list
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    file, err := os.Open(fileName)

	//If file not found throw error
	
    if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

/////////////////////////////////////////////////////////////////////
//Scanning file line by line and then splitting the line into words
////////////////////////////////////////////////////////////////////

    scanner := bufio.NewScanner(file)
    scanner.Split(bufio.ScanWords)
    for scanner.Scan() {		//scan file until file ends
        var line string = scanner.Text()
	
	a[count]=line
      
	count=count+1
	if count==10{	//helps reset array index that temporarily holds data for struct

	playerCount=playerCount+1

	//fills struct contents with player data from array that temporarily holds data

	P := new(Player)
	P.firstName=a[0]
	P.lastName=a[1]
	P.plateAppearances,err=strconv.ParseFloat(a[2],64)
	P.atBats,err=strconv.ParseFloat(a[3],64)
	P.singles,err=strconv.ParseFloat(a[4],64)
	P.doubles,err=strconv.ParseFloat(a[5],64)	
	P.triples,err=strconv.ParseFloat(a[6],64)
	P.homeRuns,err=strconv.ParseFloat(a[7],64)
	P.walks,err=strconv.ParseFloat(a[8],64)
	P.hitByPitch,err=strconv.ParseFloat(a[9],64)
	P.battingAvg=battingAverage(P.singles,P.doubles,P.triples,P.homeRuns,P.atBats)
	P.slugging=sluggingPercent(P.singles,P.doubles,P.triples,P.homeRuns,P.atBats)
	P.onBase=OBS(P.singles,P.doubles,P.triples,P.homeRuns,P.walks,P.hitByPitch,P.plateAppearances)
	P.ops=OPS(P.onBase, P.slugging)	

	players=append(players, P)	 //appends new player to end of array of Players

	count=0				//reset array to be filled with another players data
	}
	

	
    
    if err := scanner.Err(); err != nil {	//if error with reading file show error
        log.Fatal(err)
    }




}

///////////////////////////////
//Sort structs in list by OPS
//////////////////////////////

for k:=0;k<playerCount;k++ {
	var minInd int=k
	for l:=0;l<playerCount;l++ {
		if players[l].ops < players[minInd].ops {	//compares OPS values
			minInd=l

			var temp=players[minInd]		//swaps Player structs in array in order of OPS for printing later
			players[minInd]=players[k]
			players[k]=temp
		}


		
	}	
	}

////////////////////////////////////////////////
//Prints out a formatted table of player data
///////////////////////////////////////////////
fmt.Printf("BASEBALL TEAM REPORT --- %d PLAYERS FOUND IN FILE\n\n",playerCount)


fmt.Println("    Player Name  :    Average  Slugging Onbase%  OPS     \n----------------------------------------------------------") 
for j:=0;j<playerCount;j++ {	//loop to print out calculated player data to screen
fmt.Printf("%7s, %7s : %8.3f %8.3f %8.3f %8.3f\n",players[j].lastName,players[j].firstName,players[j].battingAvg,players[j].slugging,players[j].onBase,players[j].ops)  //prints formatted data of Player structs from array
}

os.Exit(0)		//terminate program
}

