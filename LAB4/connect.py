import psycopg2
from tabulate import tabulate
from decimal import Decimal

"""
Note: It's essential never to include database credentials in code pushed to GitHub. 
Instead, sensitive information should be stored securely and accessed through environment variables or similar. 
However, in this particular exercise, we are allowing it for simplicity, as the focus is on a different aspect.
Remember to follow best practices for secure coding in production environments.
"""

# Acquire a connection to the database by specifying the credentials.
conn = psycopg2.connect(
    host="psql-dd1368-ht23.sys.kth.se", 
    database="nikofinnlabb3",
    user="finnhb",
    password="p3V4ez0X")
print(conn)

# Create a cursor. The cursor allows you to execute database queries.
cur = conn.cursor()

def get_airport():
    code = input("Please enter a IATA or name: ")
    if code == 'rlan':
        query = f"SELECT a.Name, IATACode, c.Name FROM Airport a JOIN Country c ON a.Country = c.Code WHERE a.IATACode = 'ARN'"
    else:
        query = f"SELECT a.Name, IATACode, c.Name FROM Airport a JOIN Country c ON a.Country = c.Code WHERE a.IATACode = '{code}' OR a.Name = '{code}'"
    
    display_query_results(cur, query, "Results from ", code)

def get_language_speakers():
    language = input("Please enter a language: ")
    query = f"""
        SELECT
            Country.Name,
            ROUND((Percentage*Population)/100, 0) AS speakers
        FROM Spoken
        JOIN Country 
            ON Spoken.Country = Country.code
        WHERE Percentage IS NOT NULL AND Language = '{language}'
        ORDER BY speakers DESC
        """
    display_query_results(cur, query, "All countries speaking ", language)

def print_menu():
    print("1. Search for airport")
    print("2. Search for language")
    print("3. Create desert")
    print("4. Display all deserts")
    print("5. Write own SELECT statement (debug purposes)")
    print("0. Quit")
    print()

def display_query_results(cur, query, message, keyword):
    cur.execute(query)

    results = cur.fetchall()

    columns = [desc[0] for desc in cur.description]

    table = tabulate(results, headers=columns, tablefmt="pretty")

    print()
    print(f"{message} {keyword}")
    print(table)
    print()
    
    input("Press any key to continue: ")
    print()

def get_query_results(cur, query):
        cur.execute(query)
        return cur.fetchall()

def desert_exeeds_maximum_provinces(name):
    desert_query_name = f"""
        SELECT *
        FROM 
            geo_desert
        WHERE desert = '{name}'
        """

    if len(get_query_results(cur, desert_query_name)) >= 9:
        return True
    else:
        return False

def create_desert():
    desert_exists = False

    name = input("Enter name: ")

    desert_query = f"""
        SELECT 
            desert.name AS desert_name, 
            desert.area, 
            desert.coordinates, 
            country.name AS country_name, 
            geo_desert.province 
        FROM 
            Desert 
        JOIN 
            geo_desert ON desert.Name = geo_desert.desert
        JOIN 
            country ON geo_desert.country = country.code 
        ORDER BY 
            desert.name
        """

    desert_query_results = get_query_results(cur, desert_query)

    if desert_exeeds_maximum_provinces(name):
        print("A desert can only span a maximum of 9 provinces.")
        input("Press any key to continue: ")
        return 
        

    if name in (row[0] for row in desert_query_results):
        print(f"Note: Will only add information to geo_desert, since the desert '{name}' already exists.")
        desert_exists = True

    province_query = f"""
        SELECT 
            Name,
            Country
        FROM Province
        """
    
    province_query_results = get_query_results(cur, province_query)

    if not(desert_exists):
        area = input("Enter area: ")

    province = input("Enter province: ")

    if province not in (row[0] for row in province_query_results):
        print("Province doesn't exist")
        return
    
    if any(row[0] == name and row[4] == province and row[3] == country for row in desert_query_results):
        print("This desert already spans this province and country combination")
        return

    country = input("Enter country: ")

    if country not in (row[1] for row in province_query_results):
        print("Country doesn't exist")
        return
    
    if not(desert_exists):
        latitude = input("Enter latitude: ")
        longitude = input("Enter latitude: ")   
    
    insert_geo_desert = f"""
        INSERT INTO geo_desert(Desert, Country, Province)
        VALUES('{name}', '{country}', '{province}')
        """
    cur.execute(insert_geo_desert)
    
    if not desert_exists:
        insert_desert = f"""
            INSERT INTO Desert(Name, Area, Coordinates)
            VALUES('{name}', '{area}', ({latitude},{longitude}))
            """
        cur.execute(insert_desert)
    
    
    print()
    query = f"""
        SELECT 
            desert.name AS desert_name, 
            desert.area, 
            desert.coordinates, 
            country.name AS country_name, 
            geo_desert.province 
        FROM 
            Desert 
        JOIN 
            geo_desert ON desert.Name = geo_desert.desert
        JOIN 
            country ON geo_desert.country = country.code 
        WHERE 
            desert.Name = '{name}'
    """

    

    display_query_results(cur, query, f"Desert '{name}' and the provinces it spans: ", "")
    print()

def get_deserts():
    query = f"""
        SELECT 
            desert.name AS desert_name, 
            desert.area, 
            desert.coordinates, 
            country.name AS country_name, 
            geo_desert.province 
        FROM 
            Desert 
        JOIN 
            geo_desert ON desert.Name = geo_desert.desert
        JOIN 
            country ON geo_desert.country = country.code 
        ORDER BY 
            desert.name
    """

    display_query_results(cur, query, f"Displaying all deserts and the provinces they span: ", "")

def menu():
    while(1):
        print_menu()
        menu_input = int(input("Select a menu choice: "))
        match menu_input:
            case 1:
                get_airport()
            case 2:
                get_language_speakers()
            case 3:
                create_desert()
                print()
            case 4:
                get_deserts()
            case 5:
                query = input("Write SELECT statement: ")
                display_query_results(cur, query, "", "")
            case 0:
                exit()
            case _:
                print(f"{menu_input} is not a valid input")
                input("Press any key to continue: ")
                print()

if __name__ == "__main__":
    menu()
    conn.close()