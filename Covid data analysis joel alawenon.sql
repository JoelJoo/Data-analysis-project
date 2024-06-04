--select data i'm gonna use

SELECT location, total_cases, new_cases, total_deaths, population_density
From PortfolioProject..CovidDeath
where continent IS NOT NULL
Order by 1, 2

-- Looking all total cases vs total deaths
--shows likehood of dying if you contract covid in your country
SELECT
    location,
    date,
    total_cases,
    total_deaths,
    CAST(total_deaths AS FLOAT) / total_cases * 100  AS death_rate_percent
FROM PortfolioProject..CovidDeath
where location IN ('Argentina','Benin', 'Cote d''Ivoire')
OR location LIKE '%states%'
GROUP BY location
ORDER BY death_rate_percent desc;

-- looking total vs population
-- shows what percentage of population got covid
SELECT
    location,
    date,
    total_cases,
    population_density,
    (CAST(total_cases AS FLOAT) / (CAST(population_density AS FLOAT) * 9631419)) * 100  AS population_got_covid_percent
FROM PortfolioProject..CovidDeath
--where location LIKE '%states%'
ORDER BY 1, 2;


-- looking at country with the highest infection rate compared to population
SELECT
    location,
    population_density,
	MAX(total_cases) AS highest_Infection_Count,
    MAX((CAST(total_cases AS FLOAT) / (CAST(population_density AS FLOAT) * 9631419))) * 100  AS percent_population_infected
FROM PortfolioProject..CovidDeath
where location <> 'World'
GROUP BY location, population_density
--where location LIKE '%states%'
ORDER BY percent_population_infected desc;

--showing countries with highest death per population
SELECT
    location,
	MAX(cast(total_deaths as float)) AS TotalDeathCount
FROM PortfolioProject..CovidDeath
where continent IS NULL
GROUP BY location
--where location LIKE '%states%'
ORDER BY TotalDeathCount desc;

--showing the continent with the highest death count per population
SELECT
    continent,
	MAX(cast(total_deaths as float)) AS TotalDeathCount
FROM PortfolioProject..CovidDeath
where continent IS NOT NULL
GROUP BY continent
--where location LIKE '%states%'
ORDER BY TotalDeathCount desc;


--looking at total population vs vaccination

SELECT death_table.continent, death_table.location, 
death_table.date, death_table.population_density, death_table.new_vaccinations,
SUM(CONVERT(float, death_table.new_vaccinations)) 
OVER (PARTITION BY death_table.location Order by death_table.location, death_table.date)
AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeath death_table
where death_table.continent is not null
order by 2, 3

--temp table
DROP TABLE if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
PopulationDensity numeric,
NewVaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT death_table.continent,
death_table.location, 
death_table.date, 
death_table.population_density, 
death_table.new_vaccinations,
SUM(CONVERT(float, death_table.new_vaccinations)) 
OVER (PARTITION BY death_table.location Order by death_table.location, death_table.date)
AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeath death_table
--where death_table.continent is not null
order by 2, 3


SELECT *, (RollingPeopleVaccinated / NULLIF(PopulationDensity * 800000, 0)) * 100 as percentPopulation_Vaccinated
From #PercentPopulationVaccinated
where PopulationDensity is not null
and RollingPeopleVaccinated is not null

--creating view to store data for later visualization

--SELECT
--continent,
--MAX(cast(total_deaths as float)) AS TotalDeathCount
--FROM PortfolioProject..CovidDeath
--where continent IS NOT NULL
--GROUP BY continent
--ORDER BY TotalDeathCount desc;

CREATE VIEW PercentagePopulationVaccinated 
AS SELECT death_table.continent,
death_table.location, 
death_table.date, 
death_table.population_density, 
death_table.new_vaccinations,
SUM(CONVERT(float, death_table.new_vaccinations)) 
OVER (PARTITION BY death_table.location Order by death_table.location, death_table.date)
AS RollingPeopleVaccinated
FROM PortfolioProject..CovidDeath death_table
where death_table.continent is not null
--order by 2, 3

-- Sélectionnez les données de la vue
SELECT *
FROM PercentagePopulationVaccinated; 
