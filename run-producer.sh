##### Terminal Colors - START
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
coffee=$'\xE2\x98\x95'
coffee3="${coffee} ${coffee} ${coffee}"
##### Terminal Colors - END

##### Variable section - START
SCRIPT=run-producer.sh
JAR_NAME=robipozzi-kafka-producer-java
VERSION=0.0.1-SNAPSHOT
PROFILE_OPTION=$1
##### Variable section - END

##### Function section - START
main()
{
	if [ -z $PROFILE_OPTION ]; then 
        printProfile
    fi
	java -version
	
	case $PROFILE_OPTION in
		1)  java -jar target/$JAR_NAME-$VERSION.jar
			;;
		2)  java -jar target/$JAR_NAME-$VERSION.jar --spring.profiles.active=ssl
			;;
        3)  java -jar target/$JAR_NAME-$VERSION.jar --spring.profiles.active=confluent
            ;;
		*) 	printf "\n${red}No valid option selected${end}\n"
			printProfile
			;;
	esac
}

printProfile()
{
	echo ${grn}Select Kafka cluster run platform : ${end}
    echo "${grn}1. Localhost${end}"
    echo "${grn}2. Localhost (SSL enabled)${end}"
	echo "${grn}3. Confluent${end}"
	read PROFILE_OPTION
	setProfile
}

setProfile()
{
	case $PROFILE_OPTION in
		1)  printf "\n${grn}Kafka cluster is on localhost, going with local profile ...${end}\n" 
			;;
		2)  printf "\n${grn}Kafka cluster is on localhost with SSL enabled, going with ssl profile ...${end}\n" 
			;;
        3)  printf "\n${grn}Kafka cluster is running on Confluent, going with confluent profile ...${end}\n"
            ;;
		*) 	printf "\n${red}No valid option selected${end}\n"
			printProfile
			;;
	esac
}
##### Function section - END

# ##############################################
# #################### MAIN ####################
# ##############################################
# ************ START evaluate args ************"
if [ "$1" != "" ]; then
    setProfile
fi
# ************** END evaluate args **************"
RUN_FUNCTION=main
$RUN_FUNCTION