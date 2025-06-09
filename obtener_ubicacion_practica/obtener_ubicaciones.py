from geopy.geocoders import Nominatim

geolocator = Nominatim(user_agent="ejemplo")
location = geolocator.geocode("Facultad de estudios superiores aragon, nezahualcoyotl, mexico")
if location:
    print(f"Direccion: {location.address}")
    print(f"Latitud: {location.latitude}, longitud: {location.longitude}")
else:
    print("Error.")