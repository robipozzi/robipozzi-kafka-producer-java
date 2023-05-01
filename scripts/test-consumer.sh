source ./setenv.sh
# ##### Variable section - START
SCRIPT=test-consumer.sh
PLATFORM_OPTION=$1
KAFKA_TOPIC=$2
BOOTSTRAP_SERVER=
# ##### Variable section - END

# ***** Function section - START
main()
{
    if [ -z $PLATFORM_OPTION ]; then 
        printSelectPlatform
    fi
	if [ -z $KAFKA_TOPIC ]; then 
		#printHelp
		inputKafkaTopic
	fi
    CMD_RUN="$KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server $BOOTSTRAP_SERVER --topic $KAFKA_TOPIC --from-beginning"
    if [ $PLATFORM_OPTION == "2" ]; then
        CMD_RUN="$KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server $BOOTSTRAP_SERVER --topic $KAFKA_TOPIC --from-beginning --consumer-property security.protocol=SSL --consumer-property ssl.truststore.password=password --consumer-property ssl.truststore.location=./deployments/openshift/tls/truststore.jks"
    fi
    echo ${cyn}Running Kafka command : ${end} ${grn}$CMD_RUN${end}
    $CMD_RUN
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