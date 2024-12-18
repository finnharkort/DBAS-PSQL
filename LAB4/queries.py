def get_desert_query(desert_name):
    query = """
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
            desert.Name = %s
    """
    
    parameters = (desert_name,)
    
    return query, parameters


def get_all_deserts_query():
    query = f"""
        SELECT 
            desert.name AS desert_name, 
            desert.area, 
            desert.coordinates, 
            country.name AS country_name, 
            geo_desert.province,
            country.code
        FROM 
            Desert 
        JOIN 
            geo_desert ON desert.Name = geo_desert.desert
        JOIN 
            country ON geo_desert.country = country.code
    """
    return query

def get_provinces_query(country, province):
    query = f"""
        SELECT 
            Name,
            Country,
            Area
        FROM Province
        WHERE 
            Name = %s
            AND Country LIKE %s
        """
    
    parameters = (province, '%' + country + '%')
    
    return query, parameters

def get_all_airports_query(code):
    query = """
        SELECT 
            a.Name AS AirportName, 
            a.IATACode, 
            c.Name AS CountryName
        FROM 
            Airport a
        JOIN 
            Country c 
        ON 
            a.Country = c.Code
        WHERE 
            a.IATACode = %s 
            OR a.Name LIKE %s
    """
    parameters = (code, '%' + code + '%')
    return query, parameters


def get_all_language_speakers_query(language):
    query = """
        SELECT
            Country.Name,
            ROUND((Percentage*Population)/100, 0) AS speakers,
            Spoken.Language
        FROM 
            Spoken
        JOIN 
            Country 
        ON Spoken.Country = Country.code
        WHERE 
            Percentage IS NOT NULL AND Language LIKE %s
        ORDER BY 
            speakers DESC
    """
    parameters = ('%' + language + '%',)
    return query, parameters
