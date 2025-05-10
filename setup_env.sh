#!/bin/bash  
  
# Load environment variables from .env file  
if [ -f .env ]; then  
  echo "Loading environment variables from .env file..."  
    
  # Read each line from .env file  
  while IFS= read -r line || [[ -n "$line" ]]; do  
    # Skip comments and empty lines  
    [[ $line =~ ^#.*$ ]] && continue  
    [[ -z $line ]] && continue  
      
    # Extract variable and value  
    if [[ $line =~ ^([^=]+)=(.*)$ ]]; then  
      key="${BASH_REMATCH[1]}"  
      value="${BASH_REMATCH[2]}"  
        
      # Remove quotes if present  
      value="${value%\"}"  
      value="${value#\"}"  
      value="${value%\'}"  
      value="${value#\'}"  
        
      # Export the variable  
      export "$key=$value"  
      echo "Exported: $key"  
    fi  
  done < .env  
    
  echo "Environment variables loaded successfully."  
else  
  echo "Error: .env file not found."  
  exit 1  
fi
