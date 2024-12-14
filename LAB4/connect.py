import psycopg2
from tabulate import tabulate

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
    print("0. Quit")
    print()

def display_query_results(cur, query, message, keyword):
    cur.execute(query)

    results = cur.fetchall()

    columns = [desc[0] for desc in cur.description]

    table = tabulate(results, headers=columns, tablefmt="pretty")

    print()
    print(f"{message} {keyword}:")
    print(table)
    print()
    
    input("Press any key to continue: ")
    print()

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
                print("Not implemented")
                print()
                input("Press any key to continue: ")
                print()
            case 0:
                exit()
            case _:
                print("{menu_input} is not a valid input")

if __name__ == "__main__":
    menu()
    conn.close()