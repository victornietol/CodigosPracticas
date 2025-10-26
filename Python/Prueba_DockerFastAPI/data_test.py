from faker import Faker
from faker_animals import AnimalsProvider
import mysql.connector

def create_insert_data(amount: int):
    fake = Faker()
    fake.add_provider(AnimalsProvider)

    DATABASE = {
        "host": "127.0.0.1",
        "user": "root",
        "password": "1234",
        "database": "animals",
        "port": 3307
    }

    try:
        conn = mysql.connector.connect(**DATABASE)
        cur = conn.cursor()

        mamiferos = [(fake.mammal()["common_name"],) for _ in range(amount)]
        aves = [(fake.bird()["common_name"],) for _ in range(amount)]
        reptiles = [(fake.reptile()["common_name"],) for _ in range(amount)]

        cur.executemany("insert into mamifero (nombre) values (%s)", mamiferos)
        cur.executemany("insert into ave (nombre) values (%s)", aves)
        cur.executemany("insert into reptil (nombre) values (%s)", reptiles)

    except Exception as e:
        print(f"Ocurrio el error: {e}")

    else:
        conn.commit()
        print(f"Registros insertados en cada tabla: {amount}")

    finally:
        cur.close()
        conn.close()


if __name__ == "__main__":
    n = 50
    create_insert_data(n)