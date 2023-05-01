#!/usr/bin/env bash
# when sourcing log, first argument should be the file within $HADOOP_LOG_DIR that will be written to

filename=${1}
LOG_FILEPATH="$HADOOP_LOG_DIR/$filename"

# logs provided message to whichever filepath is provided when sourcing log.sh
# Use -e for error logging, -w for warning logs
# log [-ew] MESSAGE
log(){
  prefix="" # No prefix with default INFO-level logging
  while getopts ":ew" arg; do
    case $arg in
      e) # change prefix to ERROR: in logs
        prefix="ERROR:"
        shift
        ;;
      w) # change prefix to WARNING: in logs
        prefix="WARNING:"
        shift
        ;;
    esac
  done
  message=${1}
  echo "$(date +"%F %T") $prefix $message" >> $LOG_FILEPATH
}
