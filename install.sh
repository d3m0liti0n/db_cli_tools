#!/bin/bash

OS_NAME=$(uname)

if [[ "$OS_NAME" == "Darwin" || "$OS_NAME" == "Linux" ]]; then
  echo "WARN: pipx is needed to install clients..."
  pipx install mycli
  pipx install pgcli
  pipx install litecli

  echo "INFO: Installing clickhouse-cli as client for ClickHouse by default, if you want to switch to official clickhouse client\n"
  echo "please run ``curl https://clickhouse.com/ | sh``"
  pipx install clickhouse-cli

  if ! command -v aws &> /dev/null; then
    echo "WARN: AWS CLI v2 is required for RDS IAM authentication: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
  fi

  # if brew exists let's install mongosh with brew, otherwise skip it and user install it by themselves
    if command -v brew &> /dev/null; then
      brew install mongosh
    else
      echo "WARN: Homebrew is not installed. For mongosh install please visit https://www.mongodb.com/docs/mongodb-shell/install/"
    fi

else
  brew install pgcli mycli mongosh litecli clickhouse-cli
fi
