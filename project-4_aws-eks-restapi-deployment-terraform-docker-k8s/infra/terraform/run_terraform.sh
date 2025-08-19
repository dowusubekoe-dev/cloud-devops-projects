#!/bin/bash

# Load environment variables from .env file
# This assumes .env is in the parent directory of your terraform code
# Adjust path if your .env file is elsewhere
if [ -f "./.env" ]; then # Adjust this path to correctly point to your .env file
  export $(grep -v '^#' ./.env | xargs)
fi

# Set TF_VAR_db_password from the DB_PASSWORD loaded from .env
export TF_VAR_db_password=$DB_PASSWORD

# Execute the terraform command
terraform "$@"