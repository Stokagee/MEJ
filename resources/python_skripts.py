from faker import Faker
from robot.api.deco import keyword
from robot.api import logger
import random


class StringLibrary:
    def __init__(self):
        self.faker = Faker()

    def catenate(self, *items):
        """Catenates the given items together and returns the resulted string.

        By default, items are catenated with spaces, but if the first item
        contains the string ``SEPARATOR=<sep>``, the separator ``<sep>`` is
        used instead. Items are converted into strings when necessary.
        
        Supports FAKER=<type> for generating random data.

        Examples:
        | ${str1} = | Catenate | Hello         | world |       |
        | ${str2} = | Catenate | SEPARATOR=@   | Hello | FAKER=name |
        | ${str3} = | Catenate | SEPARATOR=    | FAKER=email | FAKER=email |
        =>
        | ${str1} = 'Hello world'
        | ${str2} = 'Hello@John Doe'
        | ${str3} = 'jane.doe@example.comjane.doe@example.com'
        """
        if not items:
            return ''
        items = [str(item) for item in items]
        if items[0].startswith('SEPARATOR='):
            sep = items[0][len('SEPARATOR='):]
            items = items[1:]
        else:
            sep = ' '

        # Replace FAKER=<type> with generated data
        for i in range(len(items)):
            if items[i].startswith('FAKER='):
                faker_type = items[i][len('FAKER='):]
                if hasattr(self.faker, faker_type):
                    items[i] = getattr(self.faker, faker_type)()
                else:
                    raise ValueError(f"Faker does not support type: {faker_type}")

        return sep.join(items)


def generate_vat_number(country_code="CZ"):
    """
    Generates a VAT number for the specified country.
    """
    logger.info(f"\n---> Generating VAT number for country: {country_code}")
    faker = Faker()
    vat_number = faker.random_number(digits=8, fix_len=True)
    result = f"{country_code}{vat_number}"
    logger.info(f"\n---> Generated VAT number: {result}")
    return result

def calculate_iban_checksum(country_code: str, bban: str) -> str:
    """
    Vypočítá kontrolní číslice IBAN na základě země a BBAN.
    """
    # Převést písmena země na čísla (A=10, B=11, ..., Z=35)
    country_numeric = ''.join(str(ord(char) - 55) for char in country_code)
    # Sestavit IBAN pro výpočet kontrolního čísla
    iban_numeric = f"{bban}{country_numeric}00"
    # Vypočítat zbytek po dělení 97
    checksum = 98 - (int(iban_numeric) % 97)
    # Vrátit kontrolní čísla jako 2-místné číslo
    return f"{checksum:02}"

def generate_valid_czech_iban() -> str:
    """
    Vygeneruje validní IBAN pro Českou republiku.
    """
    logger.info("\n---> Generating valid Czech IBAN")
    country_code = "CZ"

    # Vygenerovat BBAN: bankovní kód (4 číslice) + prefix účtu (6 číslic) + hlavní číslo účtu (10 číslic)
    bank_code = f"{random.randint(1000, 9999)}"
    account_prefix = f"{random.randint(0, 999999):06}"  # Prefix může být 0-padded
    account_number = f"{random.randint(0, 9999999999):010}"  # Hlavní číslo účtu je 10 číslic

    # Sestavit BBAN
    bban = f"{bank_code}{account_prefix}{account_number}"

    # Vypočítat kontrolní číslice
    checksum = calculate_iban_checksum(country_code, bban)

    # Sestavit celý IBAN
    iban = f"{country_code}{checksum}{bban}"
    logger.info(f"\n---> Generated IBAN: {iban}")
    return iban

# Testování
if __name__ == "__main__":
    print(generate_valid_czech_iban())
