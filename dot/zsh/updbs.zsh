# Updates the LLX GoldDb and IntegrationDB databases
alias updbs="docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/integrationdb.ps1 && docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/golddb.ps1"

# Rebuilds LLX IntegrationDB and updates GoldDB
alias rbdbs="docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/integrationdb.ps1 -rebuild && docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/golddb.ps1"

# Updates LLX GoldDB
alias upgold="docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/golddb.ps1"

# Rebuilds LLX GoldDB
alias rbgold="docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/golddb.ps1 -rebuild"

# Updates LLX IntegrationDB
alias upint="docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/integrationdb.ps1"

# Rebuilds LLX IntegrationDB
alias rbint="docker compose -f docker-compose.yml -f docker-compose.vscode.override.yml -f docker-compose.m1.override.yml run webapi pwsh /app/webapi/Docker.Dev/integrationdb.ps1 -rebuild"
