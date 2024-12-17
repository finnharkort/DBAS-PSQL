from decimal import Decimal
import psycopg2
from queries import *
from tabulate import tabulate

"""
Note: It's essential never to include database credentials in code pushed to GitHub. 
Instead, sensitive information should be stored securely and accessed through environment variables or similar. 
However, in this particular exercise, we are allowing it for simplicity, as the focus is on a different aspect.
Remember to follow best practices for secure coding in production environments.
"""

########## database connection ########

# Acquire a connection to the database by specifying the credentials.
conn = psycopg2.connect(
    host="psql-dd1368-ht23.sys.kth.se", 
    database="nikofinnlabb3",
    user="finnhb",
    password="p3V4ez0X")
print(conn)

# Create a cursor. The cursor allows you to execute database queries.
cur = conn.cursor()

######################################

desert_exists = False

########## helper functions ##########

def key_continue(message):
    print(message)
    input("Press any key to continue: ")
    print()

# displays a table using tabular
def display_query_results(cur, query, message):
    cur.execute(query)

    results = cur.fetchall()

    columns = [desc[0] for desc in cur.description]

    table = tabulate(results, headers=columns, tablefmt="fancy_grid")

    print()
    print(f"{message}")
    print(table)
    print()
    input("Press any key to continue: ")
    print()

# returns cur.fetchall() for a given query
def get_query_results(query):
    cur.execute(query)
    return cur.fetchall()

def get_country_code_by_name(country_name):
    query = f"SELECT Name, Code FROM Country WHERE Name LIKE '%{country_name}%'" # using wildcard
    result = get_query_results(query)
    
    # result [0][0] is country_name
    # result [0][1] is country_code
    if result: 
        country_name = result[0][0]
        print(f"Selected Country: '{country_name}'")
        country_code = result[0][1]
        return country_code
    else:
        return ""
    
######################################
    
############ task 1 and 2 ############
    
def search_for_airport():
    code = input("Please enter IATA or name: ")

    query = get_all_airports_query(code)

    display_query_results(cur, query, f"Results from {code}: ")

def search_for_language():
    language = input("Please enter a language: ")

    query = get_all_language_speakers_query
    
    display_query_results(cur, query, f"All countries speaking {language}: ")

######################################

############ constraints #############

# P+ 1 a)
def desert_exeeds_maximum_provinces(desert_name):
    query = f"""
        SELECT 
            Desert, 
            COUNT(DISTINCT Province) AS ProvinceCount
        FROM 
            geo_Desert
        WHERE desert = '{desert_name}'
        GROUP BY 
            Desert
        """

    result = get_query_results(query)

    if result:
        if result[0][1] >= 9:
            return True
        else:
            return False
    else:
        return False
    
# P+ 1 b)
def country_exceeds_maximum_deserts(country_code):
    query = f"""
        SELECT 
            Country, 
            COUNT(DISTINCT Desert) AS DesertCount
        FROM 
            geo_Desert
        WHERE 
            Country = '{country_code}'
        GROUP BY 
            Country
        """
        
    result = get_query_results(query)

    # checks that the second column (amount of distinct deserts for a given country) of the first tuple (the only tuple in this case) is equal to or above 20
    if result:
        if result[0][1] >= 20:
            return True
        else:
            return False
    else:
        return False
    
# P+ 1 c) 
# compares the user-inputed area with the area of the province its being added on
# if the use-inputed area > 30 * province area -> return true
def desert_area_exceeds_province_area(province, country, area):

    results = get_query_results(get_provinces_query(province, country))
    
    area = Decimal(area)
    province_area = Decimal(results[0][2])
    
    if area > 30 * province_area:
        return True
    
    return False 
    
# P 2 c) constraint
# checks that the country-province combination exists in the province schema 
def country_province_exists(country_code, province):
    results = get_query_results(get_provinces_query(country_code, province))

    if results:
        return True
    else:
        return False
    
######################################

##### constraint implementation ######
    
# handles constraints related to desert name only
def select_desert_name():

    desert_name = input("Enter name: ")

    if desert_exeeds_maximum_provinces(desert_name):
        key_continue("Desert not created: A desert can only span a maximum of 9 provinces.")
        return False
    
    return desert_name
    
# handles constraints related to the selection of country and/or province.
def select_country(desert_name, province, area, desert_query_results):
    country_name = input("Enter country name: ")

    country_code = get_country_code_by_name(country_name)

    # checks that we do not run into primary key constraint
    if any(row[0] == desert_name and row[4] == province and row[3] == country_name for row in desert_query_results):
        key_continue("Desert not created. This desert already spans this province and country combination")
        return False

    # checks if a country has more than 30 separate deserts spanning over it
    if country_exceeds_maximum_deserts(country_code):
        key_continue("Desert not created: A country can only contain a maximum of 20 separate deserts.")
        return False
    
    # checks if a country-province combination exists
    if not(country_province_exists(country_code, province)):
        key_continue(f"Desert not created: Country-Province combination '{country_name}'-'{province}' doesn't exist")
        return False

    # checks if the desert area is more than 30 times larger than any of the provinces it spans. 
    # this only has to be checked when a new desert is created since already created deserts cant have their areas changed.
    if desert_area_exceeds_province_area(country_code, province, area):
        key_continue("Desert not created: The area of a desert can not be more than 30 times larger than any of the provinces it spans.")
        return False
    
    return country_code

######################################

############## inserts ###############

def insert_desert(desert_name, area, latitude, longitude):
    insert_desert = f"""
        INSERT INTO Desert(Name, Area, Coordinates)
        VALUES('{desert_name}', '{area}', ({latitude},{longitude}))
        """
    cur.execute(insert_desert)

def insert_geo_desert(desert_name, country_code, province):
    insert_geo_desert = f"""
        INSERT INTO geo_desert(Desert, Country, Province)
        VALUES('{desert_name}', '{country_code}', '{province}')
        """
    cur.execute(insert_geo_desert)

######################################

# goes through each user input step and asserts every relevant constraint
def create_desert():

    # gets a table of desert and geo_desert joined. all information about all deserts
    desert_query_results = get_query_results(get_all_deserts_query())

    # asks for desert_name with constraints
    if not (desert_name := select_desert_name()): 
        return
    
    # checks if desert_name exists in any of the resulting tuples from desert_query_results
    desert_exists = desert_name in (row[0] for row in desert_query_results)

    # displays a message that lets the user know that they are updating an existing desert if the desert_name already exists in the desert schema
    if desert_exists:
        print(f"Note: Will only update geographical information about '{desert_name}', since the desert '{desert_name}' already exists.")

    # asks for area (if we are creating a new desert. already created deserts cant have their area changed. no constraints)
    area = 0 # we need it initialized for some edge cases
    if not desert_exists:
        area = input("Enter area: ")
        
    # asks for province (no constraints, since we need to await country input to check any constraints related to country-province)
    province = input("Enter province: ")

    #asks for country (user input by country_name, but fetches the country_code)
    if not (country_code := select_country(desert_name, province, area, desert_query_results)): 
        return
    
    #asks for coordinates. already created deserts cant have their coordinates changed. no constraints
    if not(desert_exists):
        latitude = input("Enter latitude: ")
        longitude = input("Enter longitude: ")   

    # if the desert doesn't already exist, insert into both geo_desert and desert, otherwise only in geo_desert
    if not desert_exists:
        insert_desert(desert_name, area, latitude, longitude)
    insert_geo_desert(desert_name, country_code, province)
    
    # display all the information about the desert the user has created/updated
    print()
    display_query_results(cur, get_desert_query(desert_name), f"Desert '{desert_name}' and the provinces it spans: ")

######################################

################ menu ################

def print_menu():
    print("1. Search for airport")
    print("2. Search for language")
    print("3. Create desert")
    print("4. Display all deserts")
    print("5. Write own SELECT statement (debug purposes)")
    print("0. Quit")
    print()

def menu():
    print_menu()

    menu_input = int(input("Select a menu choice: "))

    match menu_input:
        case 1:
            search_for_airport()
        case 2:
            search_for_language()
        case 3:
            create_desert()
        case 4: # displays all deserts
            display_query_results(cur, get_all_deserts_query(), f"Displaying all deserts and the provinces they span: ")
        case 0:
            exit()
        case _:
            print(f"{menu_input} is not a valid input")
            input("Press any key to continue: ")
            print()

if __name__ == "__main__":
    while(1):
        menu()

    conn.close()