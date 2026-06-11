# Dans votre terminal (Azure CLI doit être installé)

RESOURCE_GROUP="asigurRG"
APP_NAME="DevAppAdrien" # nom unique obligatoire
LOCATION="francecentral"

# Créer le resource group
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

# Créer le plan App Service (B1 — nécessaire pour Always On et la stabilité)
az appservice plan create \
  --name "pythonappdev" \
  --resource-group "$RESOURCE_GROUP" \
  --sku B1 \
  --is-linux

# Créer l'App Service Python
az webapp create \
  --name "$APP_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --plan "plan-nexacloud" \
  --runtime "PYTHON:3.11"

# Récupérer le publish profile (à coller dans les secrets GitHub)
az webapp deployment list-publishing-profiles \
  --name "$APP_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --xml
