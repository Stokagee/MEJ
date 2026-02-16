"""AddressGenerator Robot Framework library

Poskytuje keywordy pro generování náhodných měst podle země s garancí,
že budou navzájem vzdálená alespoň 50 km.

Použití v Robot Framework:
    Library    resources/libraries/address_generator.py
    # Získá 4 náhodná, vzájemně vzdálená města z Česka
    @{mesta}=    Ctyri Nahodne Lokace    Česko
    Log    První město: ${mesta}[0]
    Log    Druhé město: ${mesta}[1]

Knihovna vyžaduje 'geopy' pro výpočet vzdálenosti.
"""
from typing import Dict, List, Tuple, Optional
import random
from robot.api import logger

# Pokus o import knihovny geopy
try:
    from geopy.distance import geodesic
    GEO_AVAILABLE = True
except ImportError:
    GEO_AVAILABLE = False
    print("VAROVÁNÍ: Knihovna 'geopy' není nainstalována. Funkce vyžadující výpočet vzdálenosti nebudou fungovat.")
    print("Pro instalaci spusťte: pip install geopy")


# Konfigurace států: střed a poloměr pro generování (použito pro jiné účely, zde ponecháno)
COUNTRY_CONFIG: Dict[str, Dict] = {
    "Česko": {"center": (15.3345, 49.7417), "radius_km": 150},
    "Slovensko": {"center": (19.6990, 48.1486), "radius_km": 120},
    "Německo": {"center": (10.4515, 51.1657), "radius_km": 300},
    "Polsko": {"center": (19.1451, 51.9194), "radius_km": 250},
    "Rakousko": {"center": (16.3738, 48.2082), "radius_km": 200},
    "Švýcarsko": {"center": (8.2275, 46.8182), "radius_km": 200},
    "Francie": {"center": (2.3522, 48.8566), "radius_km": 400},
    "Itálie": {"center": (12.4964, 41.9028), "radius_km": 400},
    "Španělsko": {"center": (-3.7038, 40.4168), "radius_km": 400},
    "Velká Británie": {"center": (-0.1278, 51.5074), "radius_km": 400},
    "Portugalsko": {"center": (-9.1393, 38.7223), "radius_km": 300},
    "Irsko": {"center": (-6.2603, 53.3498), "radius_km": 250},
    "Belgie": {"center": (4.3517, 50.8503), "radius_km": 150},
    "Holandsko": {"center": (5.2913, 52.1326), "radius_km": 150},
    "Dánsko": {"center": (9.5018, 56.2639), "radius_km": 200},
    "Švédsko": {"center": (18.0686, 59.3293), "radius_km": 400},
    "Norsko": {"center": (10.7522, 59.9139), "radius_km": 400},
    "Finsko": {"center": (24.9384, 60.1699), "radius_km": 300},
    "Estonsko": {"center": (24.7536, 59.43696), "radius_km": 150},
    "Lotyšsko": {"center": (24.1052, 56.9496), "radius_km": 150},
    "Litva": {"center": (25.2797, 54.6872), "radius_km": 150},
    "Maďarsko": {"center": (19.0402, 47.4979), "radius_km": 200},
    "Rumunsko": {"center": (26.1025, 44.4268), "radius_km": 300},
    "Bulharsko": {"center": (23.3219, 42.6977), "radius_km": 200},
    "Řecko": {"center": (23.7275, 37.9838), "radius_km": 300},
    "Chorvatsko": {"center": (15.9781, 45.7984), "radius_km": 200},
    "Slovinsko": {"center": (14.5058, 46.0569), "radius_km": 100},
    "Estonsko": {"center": (24.7536, 59.43696), "radius_km": 150},
    "Lotyšsko": {"center": (24.1052, 56.9496), "radius_km": 150},
    "Litva": {"center": (25.2797, 54.6872), "radius_km": 150},
}

# Data měst s jejich souřadnicemi (zeměpisná délka, šířka)
CITIES_DATA: Dict[str, List[Dict]] = {
    "Česko": [
        {"name": "Praha", "coords": (14.4378, 50.0755)}, {"name": "Brno", "coords": (16.6080, 49.1951)},
        {"name": "Ostrava", "coords": (18.2925, 49.8209)}, {"name": "Plzeň", "coords": (13.3783, 49.7384)},
        {"name": "Liberec", "coords": (15.0620, 50.7662)}, {"name": "Olomouc", "coords": (17.2505, 49.5938)},
        {"name": "České Budějovice", "coords": (14.4747, 48.9745)}, {"name": "Hradec Králové", "coords": (15.8330, 50.2091)},
    ],
    "Slovensko": [
        {"name": "Bratislava", "coords": (17.1077, 48.1486)}, {"name": "Košice", "coords": (21.2575, 48.7129)},
        {"name": "Prešov", "coords": (21.2343, 49.0015)}, {"name": "Žilina", "coords": (18.7428, 49.2210)},
    ],
    "Německo": [
        {"name": "Berlín", "coords": (13.4050, 52.5200)}, {"name": "Mnichov", "coords": (11.5820, 48.1351)},
        {"name": "Hamburg", "coords": (9.9937, 53.5511)}, {"name": "Kolín", "coords": (6.9603, 50.9375)},
        {"name": "Frankfurt", "coords": (8.6821, 50.1109)},
    ],
    "Polsko": [
        {"name": "Varšava", "coords": (21.0122, 52.2297)}, {"name": "Krakov", "coords": (19.9445, 50.0647)},
        {"name": "Lodž", "coords": (19.4560, 51.7592)}, {"name": "Vratislav", "coords": (17.0385, 51.1079)},
    ],
    "Rakousko": [
        {"name": "Vídeň", "coords": (16.3738, 48.2082)}, {"name": "Štýrský Hradec", "coords": (15.4395, 47.0707)},
        {"name": "Linec", "coords": (14.2900, 48.3069)}, {"name": "Salzburg", "coords": (13.0455, 47.8095)},
    ],
    "Švýcarsko": [
        {"name": "Curych", "coords": (8.5417, 47.3769)}, {"name": "Ženeva", "coords": (6.1432, 46.2044)},
        {"name": "Basilej", "coords": (7.5873, 47.5596)}, {"name": "Bern", "coords": (7.4474, 46.9480)},
    ],
    "Francie": [
        {"name": "Paříž", "coords": (2.3522, 48.8566)}, {"name": "Marseille", "coords": (5.3698, 43.2965)},
        {"name": "Lyon", "coords": (4.8357, 45.7640)}, {"name": "Toulouse", "coords": (1.4442, 43.6047)},
        {"name": "Nice", "coords": (7.2620, 43.7102)},
    ],
    "Itálie": [
        {"name": "Řím", "coords": (12.4964, 41.9028)}, {"name": "Milán", "coords": (9.1900, 45.4642)},
        {"name": "Neapol", "coords": (14.2681, 40.8518)}, {"name": "Turín", "coords": (7.6852, 45.0703)},
    ],
    "Španělsko": [
        {"name": "Madrid", "coords": (-3.7038, 40.4168)}, {"name": "Barcelona", "coords": (2.1734, 41.3851)},
        {"name": "Valencie", "coords": (-0.3763, 39.4699)}, {"name": "Sevilla", "coords": (-5.9845, 37.3891)},
    ],
    "Velká Británie": [
        {"name": "Londýn", "coords": (-0.1278, 51.5074)}, {"name": "Manchester", "coords": (-2.2426, 53.4808)},
        {"name": "Birmingham", "coords": (-1.8904, 52.4862)}, {"name": "Glasgow", "coords": (-4.2514, 55.8642)},
    ],
    "Portugalsko": [
        {"name": "Lisabon", "coords": (-9.1393, 38.7223)}, {"name": "Porto", "coords": (-8.6291, 41.1579)},
        {"name": "Faro", "coords": (-7.9259, 37.0163)},
    ],
    "Irsko": [
        {"name": "Dublin", "coords": (-6.2603, 53.3498)}, {"name": "Cork", "coords": (-8.4761, 51.8969)},
        {"name": "Galway", "coords": (-9.0537, 53.2707)},
    ],
    "Belgie": [
        {"name": "Brusel", "coords": (4.3517, 50.8503)}, {"name": "Antverpy", "coords": (4.4025, 51.2194)},
        {"name": "Gent", "coords": (3.7102, 51.0543)},
    ],
    "Holandsko": [
        {"name": "Amsterdam", "coords": (4.8952, 52.3702)}, {"name": "Rotterdam", "coords": (4.4777, 51.9244)},
        {"name": "Haag", "coords": (4.3113, 52.0705)},
    ],
    "Dánsko": [
        {"name": "Kodaň", "coords": (12.5683, 55.6761)}, {"name": "Aarhus", "coords": (10.2039, 56.1629)},
        {"name": "Odense", "coords": (10.3900, 55.3959)},
    ],
    "Švédsko": [
        {"name": "Stockholm", "coords": (18.0686, 59.3293)}, {"name": "Göteborg", "coords": (11.9746, 57.7089)},
        {"name": "Malmö", "coords": (13.0038, 55.6050)},
    ],
    "Norsko": [
        {"name": "Oslo", "coords": (10.7522, 59.9139)}, {"name": "Bergen", "coords": (5.3221, 60.3913)},
        {"name": "Trondheim", "coords": (10.3951, 63.4305)},
    ],
    "Finsko": [
        {"name": "Helsinky", "coords": (24.9384, 60.1699)}, {"name": "Tampere", "coords": (23.7871, 61.4991)},
        {"name": "Turku", "coords": (22.2666, 60.4515)},
    ],
    "Estonsko": [
        {"name": "Tallinn", "coords": (24.7536, 59.43696)}, {"name": "Tartu", "coords": (26.7160, 58.3776)},
    ],
    "Lotyšsko": [
        {"name": "Riga", "coords": (24.1052, 56.9496)}, {"name": "Daugavpils", "coords": (26.5042, 55.8740)},
    ],
    "Litva": [
        {"name": "Vilnius", "coords": (25.2797, 54.6872)}, {"name": "Kaunas", "coords": (23.8813, 54.8987)},
    ],
    "Maďarsko": [
        {"name": "Budapešť", "coords": (19.0402, 47.4979)}, {"name": "Debrecín", "coords": (21.6225, 47.5317)},
        {"name": "Segedín", "coords": (20.1502, 46.2530)},
    ],
    "Rumunsko": [
        {"name": "Bukurešť", "coords": (26.1025, 44.4268)}, {"name": "Kluž", "coords": (23.6236, 46.7712)},
        {"name": "Timișoara", "coords": (21.2257, 45.7489)},
    ],
    "Bulharsko": [
        {"name": "Sofie", "coords": (23.3219, 42.6977)}, {"name": "Plovdiv", "coords": (24.7453, 42.1354)},
        {"name": "Varna", "coords": (27.9271, 43.2076)},
    ],
    "Řecko": [
        {"name": "Atény", "coords": (23.7275, 37.9838)}, {"name": "Soluň", "coords": (22.9364, 40.6401)},
        {"name": "Patras", "coords": (21.7345, 38.2466)},
    ],
    "Chorvatsko": [
        {"name": "Záhřeb", "coords": (15.9781, 45.7984)}, {"name": "Split", "coords": (16.4409, 43.5081)},
        {"name": "Rijeka", "coords": (14.4409, 45.3271)},
    ],
    "Slovinsko": [
        {"name": "Lublaň", "coords": (14.5058, 46.0569)}, {"name": "Maribor", "coords": (15.6496, 46.5547)},
    ],
}


def ctyri_nahodne_lokace(country: str) -> list:
    """
    Vygeneruje 4 náhodná, unikátní města v zadané zemi, která jsou od sebe vzdálená alespoň 50 km.

    Tento keyword vyžaduje nainstalovanou Python knihovnu 'geopy'.

    Args:
        country (str): Název státu (např. "Česko", "Německo").

    Returns:
        list: Seznam 4 názvů měst.

    Raises:
        NotImplementedError: Pokud není k dispozici knihovna 'geopy'.
        ValueError: Pokud stát není podporován nebo nelze najít 4 dostatečně vzdálená města.

    Podporované země: Belgie, Bulharsko, Chorvatsko, Česko, Dánsko, Estonsko, Finsko, Francie,
    Holandsko, Irsko, Itálie, Litva, Lotyšsko, Maďarsko, Německo, Norsko, Polsko,
    Portugalsko, Rakousko, Rumunsko, Řecko, Slovensko, Slovinsko, Španělsko, Švédsko, Švýcarsko,
    Velká Británie.
    """
    logger.info(f"\n---> Generating 4 random locations for country: {country}")

    if not GEO_AVAILABLE:
        raise NotImplementedError("Funkce 'ctyri_nahodne_lokace' vyžaduje knihovnu 'geopy'. Prosím, nainstalujte ji pomocí 'pip install geopy'.")

    country_norm = country.strip().title()
    if country_norm not in CITIES_DATA:
        raise ValueError(f"Stát '{country}' není v databázi podporovaných zemí. Dostupné země: {', '.join(sorted(CITIES_DATA.keys()))}")

    all_cities = CITIES_DATA[country_norm]
    if len(all_cities) < 4:
        raise ValueError(f"Pro stát '{country}' není v databázi dostatek měst k vygenerování 4 unikátních lokací.")

    # ZMĚNA: Tento seznam nyní ukládá celé slovníky, ne jen jména
    selected_cities_data = []
    available_cities = all_cities.copy()
    min_distance_km = 50

    while len(selected_cities_data) < 4:
        if not available_cities:
            raise ValueError(f"Nelze najít další město, které by bylo alespoň {min_distance_km} km vzdálené od již vybraných.")

        candidate_city = random.choice(available_cities)
        is_valid = True

        # Zkontrolujeme vzdálenost k již vybraným městům
        for selected_city in selected_cities_data:
            # ZMĚNA: Nyní to funguje, protože obě proměnné jsou slovníky
            distance = geodesic(candidate_city['coords'], selected_city['coords']).km
            if distance < min_distance_km:
                is_valid = False
                break

        if is_valid:
            # ZMĚNA: Ukládáme celý slovník
            selected_cities_data.append(candidate_city)
            available_cities.remove(candidate_city)
        else:
            available_cities.remove(candidate_city)

    # ZMĚNA: Až na konci z celých slovníků vytáhneme jen jména
    final_city_names = [city['name'] for city in selected_cities_data]
    logger.info(f"\n---> Generated locations: {final_city_names}")
    return final_city_names