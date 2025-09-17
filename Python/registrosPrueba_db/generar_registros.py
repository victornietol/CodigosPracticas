from faker import Faker
import csv


def generate_row():
    fake = Faker('es_MX')
    return {
        "nombre": fake.name(),
        "apellido_p": fake.first_name(),
        "apellido_m": fake.last_name(),
        "email": fake.email(),
        "telefono": fake.phone_number(),
        "ciudad": fake.city()
    }

def create_file(file_name, fieldnames, total, chunk):
    print("Generando archivo...")
    with open("./"+file_name, "w", newline='', encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        index = 1 
        while index <= total:
            rows = [generate_row() for _ in range(index, min(index+chunk, total)+1)]
            writer.writerows(rows)
            index += chunk
    print("Archivo creado: "+ file_name)

total = 100_000 # Registros
chunk = 10_000 # Escribe por partes
file_name = "data_fake_100k.csv"
fieldnames = ["nombre", "apellido_p", "apellido_m", "email", "telefono", "ciudad"]

create_file(file_name, fieldnames, total, chunk)