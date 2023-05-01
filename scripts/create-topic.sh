source ./setenv.sh
# ##### Variable section - START
SCRIPT=create-topic.sh
DESCRIBE_TOPICS_SCRIPT=describe-topics.sh
PLATFORM_OPTION=$1
KAFKA_TOPIC=$2
BOOTSTRAP_SERVER=
TOPIC=
# ##### Variable section - END

# ***** Function section - START
########################
## Create Kafka Topic ##
########################
main()
{
	if [ -z $PLATFORM_OPTION ]; then 
        printSelectPlatform
    fi
	if [ -z $KAFKA_TOPIC ]; then 
		#printHelp
		inputKafkaTopic
	fi
	CREATE_TOPIC_CMD_RUN="$KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --create --replication-factor 1 --partitions 1 --topic $KAFKA_TOPIC"
    if [ $PLATFORM_OPTION == "2" ]; then
        CREATE_TOPIC_CMD_RUN="$KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server $BOOTSTRAP_SERVER --create --replication-factor 1 --partitions 1 --topic $KAFKA_TOPIC --command-config ./deployments/openshift/config.properties"
    fi
	echo ${cyn}Creating Topic:${end} ${grn}$KAFKA_TOPIC${end}
	$CREATE_TOPIC_CMD_RUN
	source $DESCRIBE_TOPICS_SCRIPT $PLATFORM_OPTION
}

###############
## printHelp ##
###############
printHelp()
{
	printf "\n${yel}Usage:${end}\n"
  	printf "${cyn}$SCRIPT <PLATFORM_OPTION> <KAFKA_TOPIC>${end}\n"
	printf "${cyn}where:${end}\n"
	printf "${cyn}- <PLATFORM_OPTION> can be one of the following${end}\n"
	printf "${cyn}	1. Localhost${end}\n"
	printf "${cyn}	2. Openshift${end}\n"
	printf "${cyn}- <KAFKA_TOPIC> is a string representing the Kafka topic to be created${end}\n"
}

printSelectPlatform()
{
	echo ${grn}Select Kafka cluster run platform : ${end}
    echo "${grn}1. Localhost${end}"
    echo "${grn}2. Openshift (RHOKS cluster)${end}"
	read PLATFORM_OPTION
	setBootstrapServer
}

setBootstrapServer()
{
	case $PLATFORM_OPTION in
		1)  BOOTSTRAP_SERVER=$LOCALHOST_KAFKA_BOOTSTRAP
			;;
        2)  BOOTSTRAP_SERVER=$OPENSHIFT_KAFKA_BOOTSTRAP
            ;;
		*) 	printf "\n${red}No valid option selected${end}\n"
			printSelectPlatform
			;;
	esac
}

inputKafkaTopic()
{
    ###### Set Kafka Topic
    if [ "$KAFKA_TOPIC" != "" ]; then
        echo Kafka topic is set to $KAFKA_TOPIC
    else
        echo ${grn}Enter Kafka topic - leaving blank will set topic to ${end}${mag}$TEMPERATURES_TOPIC : ${end}
        read KAFKA_TOPIC
        if [ "$KAFKA_TOPIC" == "" ]; then
            KAFKA_TOPIC=$TEMPERATURES_TOPIC
        fi
    fi
}
# ***** Function section - END

# ##############################################
# #################### MAIN ####################
# ##############################################
# ************ START evaluate args ************"
if [ "$1" != "" ]; then
    setBootstrapServer
fi
# ************** END evaluate args **************"
RUN_FUNCTION=main
$RUN_FUNCTION