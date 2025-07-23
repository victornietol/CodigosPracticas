import requests
import json

# URL para estaciones del Metrobús
url = "https://serviciosatlas.sgirpc.cdmx.gob.mx/arcgis/rest/services/AtlasOnline/Sistema_Expuesto/FeatureServer/3/query"
params = {
    "where": "1=1",
    "outFields": "nombre",
    "f": "geojson"
}

resp = requests.get(url, params=params)
data = resp.json()

# Construir el diccionario
resultado = {}
for feature in data["features"]:
    nombre = feature["properties"]["nombre"]
    coords = feature["geometry"]["coordinates"]  # [lon, lat]
    resultado[nombre] = [coords[1], coords[0]]   # [lat, lon]

# Exportar como lista de objetos JSON
lista = [{nombre: coords} for nombre, coords in resultado.items()]

# Guardar
with open("estaciones_metrobús_cdmx.json", "w", encoding="utf-8") as f:
    json.dump(lista, f, ensure_ascii=False, indent=2)