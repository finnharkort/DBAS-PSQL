def get_desert_query(desert_name):
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
            desert.Name = '{desert_name}'
    """
    return query

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
            Name = '{province}'
            AND Country = '{country}'
        """
    
    return query

def get_areas_query(desert_name):
    query = f"""
        SELECT 
            desert.area AS desertArea,
            province.area AS provinceArea
        FROM 
            Desert
        JOIN 
            geo_desert ON Desert.name = desert
        JOIN 
            province ON province = province.name
        WHERE 
            desert.name = '{desert_name}'
        """
    return query

def get_all_airports_query(code):
    query = f"""
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
            a.IATACode = '{code}' 
            OR a.Name LIKE '%{code}%';
        """
    return query

def get_all_language_speakers_query(language):
    query = f"""
        SELECT
            Country.Name,
            ROUND((Percentage*Population)/100, 0) AS speakers
        FROM 
            Spoken
        JOIN 
            Country 
        ON Spoken.Country = Country.code
        WHERE 
            Percentage IS NOT NULL AND Language = '{language}'
        ORDER BY 
            speakers DESC
        """
    return query