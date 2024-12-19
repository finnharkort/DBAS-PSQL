DROP PROCEDURE IF EXISTS investment_return;
CREATE PROCEDURE 
investment_return (
IN initial_investment REAL,
IN yearly_return REAL,
IN number_of_years INT,
OUT return_size INT
)
language plpgsql
as $$
BEGIN
    return_size := initial_investment * POWER(1 + yearly_return, number_of_years);
END; $$;


DROP PROCEDURE IF EXISTS investment_return;
CREATE PROCEDURE 
investment_return (
IN initial_investment REAL,
IN yearly_return REAL,
IN number_of_years INT,
INOUT return_size INT
)
language plpgsql
as $$
BEGIN
    return_size := initial_investment * POWER(1 + yearly_return, number_of_years);
END; $$;



CREATE TABLE Test(
    initial_investment INT,
    yearly_return INT,
    number_of_years INT,
    return_size INT
);



CALL investment_return(100, 0.1, 10, 0);
