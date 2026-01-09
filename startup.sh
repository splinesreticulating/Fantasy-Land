#!/bin/bash

# Configuration
PORT=4000
# Allow overriding port via command line argument
if [ "$1" != "" ]; then
    PORT="$1"
fi

# Get the directory where the script is located (root of the mud)
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
AREA_DIR="$BASEDIR/area"
LOG_DIR="$BASEDIR/log"
BIN_NAME="rot"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Change to area directory (MUDs expect to run from here to find area files)
cd "$AREA_DIR" || { echo "Error: Could not change to $AREA_DIR"; exit 1; }

# Verify binary exists
if [ ! -f "./$BIN_NAME" ]; then
    echo "Error: Binary '$BIN_NAME' not found in $AREA_DIR"
    echo "Did you compile the code? Try running 'make' in the src directory."
    exit 1
fi

echo "Starting MUD on port $PORT..."
echo "Logs will be saved to $LOG_DIR"
echo "To stop this loop, press Ctrl+C"

while true; do
    # Find next available log filename (1000.log, 1001.log, etc.)
    INDEX=1000
    while [ -f "$LOG_DIR/$INDEX.log" ]; do
        ((INDEX++))
    done
    LOGFILE="$LOG_DIR/$INDEX.log"

    echo "-----------------------------------------------------"
    echo "$(date): Launching $BIN_NAME on port $PORT"
    echo "Logging output to: $LOGFILE"
    echo "-----------------------------------------------------"
    
    # Run the MUD
    # We redirect both stdout (1) and stderr (2) to the log file
    ./$BIN_NAME $PORT > "$LOGFILE" 2>&1
    
    # Check for shutdown.txt - this is created by the game when a user types 'shutdown'
    # If found, we exit the loop completely.
    if [ -f "shutdown.txt" ]; then
        rm "shutdown.txt"
        echo "Clean shutdown requested. Exiting startup script."
        exit 0
    fi
    
    echo "MUD exited unexpectedly (crash or reboot). Restarting in 10 seconds..."
    sleep 10
done
