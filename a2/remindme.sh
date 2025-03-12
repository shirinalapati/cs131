#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: remindme \"message\" HH:MM"
    exit 1
fi

MESSAGE=$1
TIME=$2

# This validates the HH:MM format
if [[ ! $TIME =~ ^[0-2][0-9]:[0-5][0-9]$ ]]; then
    echo "Error: Time must be in HH:MM format."
    exit 1
fi

# Get current local date & time
CURRENT_TIME=$(date +%s)  # Local time in seconds
TARGET_TIME=$(date -d "$(date +%Y-%m-%d) $TIME" +%s)

# If the time has already passed today, this will schedule for tomorrow
if [ "$TARGET_TIME" -lt "$CURRENT_TIME" ]; then
    TARGET_TIME=$(date -d "tomorrow $TIME" +%s)
fi

# Calculate the amount of sleep time
SLEEP_TIME=$((TARGET_TIME - CURRENT_TIME))

echo "Reminder set for $TIME: \"$MESSAGE\""

# Wait before displaying reminder
sleep "$SLEEP_TIME"
echo "🔔 Reminder: $MESSAGE"

