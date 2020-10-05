--------------
-- OPTIONAL --
--------------
-- Name:
-- Twitter handle:
-- Facebook page:
-- Website:
-- Date:

--------------
-- Mandatory --
--------------
- Solution

WITH Adoption_count AS
(
SELECT a.species AS species,
breed,
CASE WHEN adoption_date IS NULL
THEN 0 ELSE 1 END AS no_of_adoptions
FROM animals a
LEFT JOIN adoptions ad
ON a.name = ad.name
AND
a.species = ad.species

)

SELECT
breed
FROM
(
SELECT DISTINCT
species,
breed,
sum(no_of_adoptions) OVER (PARTITION BY breed) AS Adopted
FROM adoption_count
ORDER BY species
) T1

WHERE Adopted = 0

-- Explanation

The above is an alternate solution to the Challenge : Breeds that were never adopted
Course : Advanced SQL: Logical Query Processing, Part 2 - On LinkedIn Learning
In the CTE, I have left joined the animals table with adoptions table to find out which species and breeds have a null adoption_date against them.
Then I have assigned 0 wherever the adoption_date is null.
In the derived table, I have just tried to sum the no_of non-null adoption_dates for each breed using a window function and then in the main query I have just filtered only those breeds that have 0 non-null adoption dates and returned the same.
