# Updates the LLX GoldDb and IntegrationDB databases
alias updbs="docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/integrationdb.ps1 && docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/golddb.ps1"
