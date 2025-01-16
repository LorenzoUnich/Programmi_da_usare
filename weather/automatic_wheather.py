import requests
import csv, json
from collections import defaultdict

lat, lon  =  "40.8333", "14.25"
csv_file = 'Weather_Naples.csv'
csv_obj = open(csv_file, 'w+')
API_key = "41e18095f3b504298418e05f761bf4ee"
key = f"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_key}"
response = requests.get(key)
row = (response.headers)

def case_insensitive_dict(data):
    return defaultdict(str, {k.lower(): v for k, v in data.items()})

print(type(row))
"""json_data = json.loads(str(row))
csv_writer = csv.writer(csv_obj)
csv_writer.writerow(header)"""
def add_row_to_csv(csv_file, row):
    # Convertiamo le chiavi a una lista case-sensitive
    headers = [key.capitalize() for key in row.keys()]
    row_data = [row[key] for key in headers]

    # Controlla se il file esiste già e se ha intestazioni
    try:
        with open(csv_file, mode='r', newline='') as file:
            reader = csv.reader(file)
            file_has_header = next(reader, None) is not None
    except FileNotFoundError:
        file_has_header = False

    # Aggiungi la riga al file CSV
    with open(csv_file, mode='a', newline='') as file:
        writer = csv.writer(file)
        if not file_has_header:
            writer.writerow(headers)  # Scrivi le intestazioni
        writer.writerow(row_data)

# Chiamata alla funzione
add_row_to_csv(csv_file, row)
print("Done!")