source ./setenv.sh $1 $2

##### Variable section - START
SCRIPT=container-run.sh
DEFAULT_TRUSTSTORE=/opt/robipozzi-kafka/ssl/kafka.client.truststore.jks
##### Variable section - END

##### Function section - START
main()
{
	CURRENT_DIRECTORY=$(pwd)
	if [ -z $PROFILE_OPTION ]; then 
        printProfile
    fi
    echo 
    echo ${cyn}Running application in container ...${end}
    runApp
}

runApp()
{
	echo ${cyn}Removing $CONTAINER_NAME container ...${end}
	docker rm -f $CONTAINER_NAME
	echo ${cyn}Container removed${end}
	echo
	#############################################################################################################################################
	# The application will be launched with the profile selected (i.e.: --spring.profiles.active=<PROFILE>), 									#
	# Spring Boot will search for a configuration file named application-<PROFILE>.properties and will load configuration properties from that. #
	# 																																			#
	# Alternatively, a different configuration file can be used at runtime by setting the following environment property:						#
	# --spring.config.location=file://<path to application config file>																			#
	#############################################################################################################################################
	case $PROFILE_OPTION in
		1)  echo ${cyn}Running $CONTAINER_NAME container ...${end}
			docker run -it --name $CONTAINER_NAME $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
			;;
		2)  echo ${cyn}Running $CONTAINER_NAME container ...${end}
			inputTruststore
			inputTruststorePassword
			docker run -it -e SPRING_PROFILES_ACTIVE=ssl -e TRUSTSTORE_LOCATION=$TRUSTSTORE -e TRUSTSTORE_PASSWORD=$TRUSTSTORE_PWD -v $HOME/opt/robipozzi-kafka/ssl:/opt/robipozzi-kafka/ssl --name $CONTAINER_NAME $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
			;;
        3)  echo ${cyn}Running $CONTAINER_NAME container ...${end}
			docker run -it -e "SPRING_PROFILES_ACTIVE=confluent" --name $CONTAINER_NAME $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION
            ;;
		*) 	printf "\n${red}No valid option selected${end}\n"
			printProfile
			;;
	esac
}

inputTruststore()
{
    ###### Set truststore location
    if [ "$TRUSTSTORE" != "" ]; then
        echo Truststore location is set to $TRUSTSTORE
    else
        echo ${grn}Enter truststore location - leaving blank will set truststore to ${end}${mag}$DEFAULT_TRUSTSTORE : ${end}
        read TRUSTSTORE
        if [ "$TRUSTSTORE" == "" ]; then
        	TRUSTSTORE=$DEFAULT_TRUSTSTORE
        fi
    fi
}
##### Function section - END

# ##############################################
# #################### MAIN ####################
# ##############################################
main