#SQL Mini Project: Analyzing Unicorn Companies
#1. Project Overview:
This project involves analyzing a dataset of unicorn companies, which are privately held
companies valued at over $1 billion as of November 2021. The project will include data creation,
analysis using SQL, and answering specific questions about the dataset.
#2. CSV Data Structure:
You can use the following CSV structure to represent the dataset:
SpaceX,United States,Aerospace,100.3,2002,Fidelity, Founders Fund,
Baillie Gifford
Stripe,United States,FinTech,95.0,2010,Sequoia Capital, Andreessen
Horowitz, Baillie Gifford
ByteDance,China,Artificial Intelligence,140.0,2012,Sequoia Capital
China, General Atlantic
UiPath,United States,Robotics,35.0,2005,Accel, CapitalG, Sequoia
Capital
Klarna,Sweden,FinTech,46.0,2005,Sequoia Capital, Silver Lake,
Dragoneer
…
#3. SQL Database Setup:
Create a database and a table using the following SQL commands:
CREATE DATABASE unicorn_companies;
USE unicorn_companies;
CREATE TABLE unicorns (
id INT AUTO_INCREMENT PRIMARY KEY,
company VARCHAR(255),
country VARCHAR(100),
sector VARCHAR(100),
valuation DECIMAL(10, 2),
founded_year INT,
investors TEXT
);
insert into unicorns ( id, company, country, sector, valuation, founded_year, investors)
values ( 1, 'SpaceX', 'United States', 'Aerospace', 100.3, '2002', 'Fidelity' 'Founders Fund' 'Baillie Gifford'),
(2, 'Stripe', 'United States', 'FinTech', 95.0, '2010', 'Sequoia Capital, Andreessen,Horowitz, Baillie Gifford'),
(3, 'ByteDance', 'China', 'Artificial Intelligence', 140.0, '2012', 'Sequoia Capital China, General Atlantic'),
(4, 'UiPath', 'United States', 'Robotics', 35.0, '2005', 'Accel, CapitalG, Sequoia Capital'),
(5, 'Klarna', 'Sweden', 'FinTech', 46.0, '2005', 'Sequoia Capital, Silver Lake, Dragoneer');
# 4. Analysis Questions:
# Here are some questions you can answer using SQL queries:
# 1- Top 5 Countries by Number of Unicorn
SELECT country, COUNT(*) AS num_unicorns
FROM unicorns
GROUP BY country
ORDER BY num_unicorns DESC
LIMIT 5;
#2. Top 3 Sectors by Average Valuation
SELECT sector, AVG(valuation) AS avg_valuation
FROM unicorns
GROUP BY sector
ORDER BY avg_valuation DESC
LIMIT 3;
#3- Unicorns Founded After 2010
SELECT *
FROM unicorns
WHERE founded_year > 2010;
#4- Total Valuation of Unicorns in the FinTech Sector
SELECT SUM(valuation) AS total_valuation
FROM unicorns
WHERE sector = 'FinTech';
#5- Most Common Investors
SELECT investors, COUNT(*) AS num_companies
FROM unicorns
GROUP BY investors
ORDER BY num_companies DESC
LIMIT 5;
#5. Challenges:
#● Identify Trends: Explore trends in the data, such as the growth of unicorns in specific
sectors or countries
SELECT country, COUNT(*) AS num_unicorns
FROM unicorns
GROUP BY country
ORDER BY num_unicorns DESC;
#● Investor Analysis: Investors with the Most Unicorns in Their Portfolio
SELECT investors, COUNT(*) AS num_investments
FROM unicorns
GROUP BY investors
ORDER BY num_investments DESC
LIMIT 5;
#● Growth Analysis: Compare Valuations of Companies Founded in Different Decades
SELECT 
    CASE 
        WHEN founded_year BETWEEN 2000 AND 2009 THEN '2000s'
        WHEN founded_year BETWEEN 2010 AND 2019 THEN '2010s'
        ELSE 'Before 2000'
    END AS decade,
    AVG(valuation) AS avg_valuation
FROM unicorns
GROUP BY decade
ORDER BY decade;