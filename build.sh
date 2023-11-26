source ./setenv.sh

##### Variable section - START
SCRIPT=build.sh
MAVEN_GOAL_OPTION=$1
MAVEN_GOAL=
##### Variable section - END

main()
{
	if [ -z $MAVEN_GOAL_OPTION ]; then 
        printMavenGoals
    fi
	java -version
	
	source mvnw $MAVEN_GOAL
}

printMavenGoals()
{
	echo ${grn}Select Maven goal : ${end}
    echo "${grn}1. install${end}"
	echo "${grn}2. test${end}"
	echo "${grn}3. clean${end}"
	read MAVEN_GOAL_OPTION
	setMavenGoal
}

setMavenGoal()
{
	case $MAVEN_GOAL_OPTION in
		1)  printf "\n${grn}Maven goal = install${end}\n"
		    MAVEN_GOAL=install
			;;
        2)  printf "\n${grn}Maven goal = test${end}\n"
            MAVEN_GOAL=test
            ;;
        3)  printf "\n${grn}Maven goal = clean${end}\n"
            MAVEN_GOAL=clean
            ;;
		*) 	printf "\n${red}No valid goal selected${end}\n"
			printMavenGoals
			;;
	esac
}

# ##############################################
# #################### MAIN ####################
# ##############################################
# ************ START evaluate args ************"
if [ "$1" != "" ]; then
    setMavenGoal
fi
# ************** END evaluate args **************"
main