#!/bin/bash

# Define the .env file path
ENV_FILE=".env"

# Define an array of possible folder names
LOBBY_FOLDERS=("lottery-build" "card-build" "dingdong-build")

# Prompt the user for the environment
echo "Please choose the environment (STG, DEV, TEST):"
read -r ENVIRONMENT

# Loop through each folder name and check if it exists
for LOBBY_FOLDER in "${LOBBY_FOLDERS[@]}"; do
    if [ -d "$LOBBY_FOLDER" ]; then
        rm -rf "$LOBBY_FOLDER"
        echo "Deleted existing '$LOBBY_FOLDER' directory."
    else
        echo "'$LOBBY_FOLDER' directory does not exist."
    fi
done

# Set the API URL based on the user's input
case "$ENVIRONMENT" in
    STG|stg)
        API_URL="https://stg-hkb-api.dev-diamondteam.com"
        ;;
    DEV|dev)
        API_URL="https://dev-v2-hkb2.dev-diamondteam.com"
        ;;
    TEST|test)
        API_URL="https://test-v2-hkb2.dev-diamondteam.com"
        ;;
    *)
        echo "Invalid environment! Please choose STG, DEV, or TEST."
        exit 1
        ;;
esac


# Update the REACT_APP_API_URL in the .env file based on user input
sed -i "s|^REACT_APP_API_URL=.*|REACT_APP_API_URL=$API_URL|" "$ENV_FILE"
echo "Moving to $ENVIRONMENT environment."

# Run the npm build command
npm run build

echo "YOUR BUILD FOR $ENVIRONMENT ENVIRONMENT IS READY!!"
