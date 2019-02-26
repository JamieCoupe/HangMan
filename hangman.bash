
#! /bin/bash
#
#
#A simple hangman game
#

#Random Word List for automatic word
declare -a wordList
wordList=(vengeful bait crime spicy colourful pancake groan angry committee steady)

#function to initilise the game
startGame(){

        clear

        #Start the game by entering a word to guess only needed is manual input
#       echo "-----------------------------------------------------------------------"
#       echo "Please enter the  word to guess"
#       echo "-----------------------------------------------------------------------"
#       read -s randomWord

        #Selecting random word from the list for auto mode

        randomNo=$((1 + RANDOM % 10))
        randomWord="${wordList[$randomNo]}"
        echo "$randomNo"
        echo "randomWord"

        #setup guessing word as array
        for ((a=0;a<${#randomWord};a++))
        do
                guessingWord[$a]+=${randomWord:$a:1}
        done

        blankWord
        count=0
        correctGuess=0

        echo "  -----"
        echo "  |   |"
        echo "  |"
        echo "  |"
        echo "  |"
        echo "  |"
}

#Function to blank the random word and update as game goes on
blankWord(){

        #Go through string and change all to -
   for ((j=0;j<${#randomWord};j++))
        do
                blankedWord[$j]="-"
        done

        #Print the blanked out word
        echo "Word to guess: $blankedWord"
}

#Hang him
hangman(){

        #update Used letters
        used="$used $guess"

        #Display gallows based on number of wrong guesses as count
        case $count in

        0)      clear
                echo "  -----"
                echo "  |   |"
                echo "  |"
                echo "  |"
                echo "  |"
                echo "  |"
                echo "---------";;

        1)      clear
                echo "  -----"
                echo "  |   |"
                echo "  |   @"
                echo "  |"
                echo "  |"
                echo "  |"
                echo "---------"
                echo "Letters used: $used"
                echo "$type Guess";;

        2)      clear
                echo "  -----"
                echo "  |   |"
                echo "  |   @"
                echo "  |   |"
                echo "  |"
                echo "  |"
                echo "---------"
                echo "Letters used: $used"
                echo "$type Guess";;

        3)      clear
				echo "  -----"
                echo "  |   |"
                echo "  |  \@/"
                echo "  |   |"
                echo "  |"
                echo "  |"
                echo "---------"
                echo "Letters used: $used"
                echo "$type Guess";;

        4)      clear
                echo "  -----"
                echo "  |   |"
                echo "  |  \@/"
                echo "  |   |"
                echo "  |  ||"
                echo "  |"
                echo " ---------"
                echo "You lose!"
                echo "The word was $randomWord";;

        *)      echo "Thank you for playing";;
        esac

}

#Guessing Function
guessing(){

        #read guess
        echo "----------------------------------------------------------------------"
        echo "Word to guess: ${blankedWord[*]}"
        echo "Enter your guess:"
        echo "----------------------------------------------------------------------"
        read guess
        clear

        #Iterate through word to check letters
        for ((i=0;i<${#randomWord};i++))
        do

                #set letter equal to substring from word at the position
                letter=${randomWord:$i:1}

                #Check if guess is equal to substring
                if [[  "$i" -eq $((${#randomWord}-1)) && "$letter" != "$guess" ]]
                then

                        #If its at the end and not found a match
                        count=$(($count + 1))
 type="Incorrect"
                        hangman
                        break

                elif [[  "$letter" == "$guess" ]]
                then
                        #If it has found a match
                        type="Correct"
                        hangman
                        updateBlank
                        break
                fi
        done

}

#Function to update the blank word
updateBlank(){

                #replace the letters not guessed with blanks
                for ((v=0;v<${#randomWord};v++))
                do

                        #if character guessed is equal to character in position at guessed word
                        #display letter, otherwise show -
                        if [[ "${guessingWord[$v]}" == "$guess" && "${guessingWord[$v]}" != "${
blankedWord[$v]}" ]]
                        then
                                blankedWord[$v]=${guessingWord[$v]}
                                ((correctGuess++))
                        fi
                done
}


declare -A guessingWord
declare -A blankedWord

#Start the game
startGame

#loop until count is greater than
until [[ "$count" -gt 4 ]]
do
        #Run the guessing function until all stages have been shown
        guessing

        
        #Exit loop if correct guesses have been made
        if [[ "$correctGuess" -eq "${#randomWord}" ]]
        then

                #Display message
                clear
                echo "You've Won!"
                echo "The word was $randomWord"
                echo "You guessed in $count turns"
                break
        fi
done

#
