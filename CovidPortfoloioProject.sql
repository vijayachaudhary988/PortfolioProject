
select * from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
order by 3,4


select location, date, total_cases, new_cases, total_deaths, population_density
from [PortfolioProject].[dbo].[CovidDeaths$]
order by location asc

select location, date, total_cases, total_deaths, ((cast(total_deaths as int))/(cast(total_cases as int)))*100 as DeathPercentage
from [PortfolioProject].[dbo].[CovidDeaths$]
order by location asc

--Looking at total cases vs population
--shows what percentage of population got covid

select location, date, total_cases, population_density, (total_cases/population_density)*100 as PercentofPopulationInfected
from [PortfolioProject].[dbo].[CovidDeaths$]
where location like '%states%'
order by 1,2

--Looking at Countries with Highest Infection Rate compared to Population

select location, population_density, max(total_cases) as HighestInfectionCount, max((total_cases/population_density))*100 as PercentofPopulationInfected
from [PortfolioProject].[dbo].[CovidDeaths$]
group by location, population_density
order by PercentofPopulationInfected desc

--Showing the countries with the highest Death Count per Popuulation density



select location, max(cast(total_deaths as int)) as TotalDeathCount
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is null
group by location
order by TotalDeathCount desc



--Let's break things down by continent

select continent, max(cast(total_deaths as int)) as TotalDeathCount
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
group by continent
order by TotalDeathCount desc

--Showing the continents with highest death counts

select continent, max(cast(total_deaths as int)) as TotalDeathCount
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
group by continent
order by TotalDeathCount desc



--Global Numbers

select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
group by date
order by 1,2

/*select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
group by date
order by 1,2
*/
Select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, 
(convert(float,sum(new_deaths))/NULLIF(convert(float,sum(new_cases)),0))*100 as DeathPercentage
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
group by date
order by 1,2


select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
order by 1,2



Select *
From [PortfolioProject].[dbo].[CovidVaccinations$]


Select *
From [PortfolioProject].[dbo].[CovidDeaths$] death
JOIN [PortfolioProject].[dbo].[CovidVaccinations$] vac
	ON death.location = vac.location
	and death.date= vac.date

--Looking at total population density vs Vaccinations

Select death.continent, death.location, death.date, death.population_density, vac.new_vaccinations
From [PortfolioProject].[dbo].[CovidDeaths$] death
JOIN [PortfolioProject].[dbo].[CovidVaccinations$] vac
	ON death.location = vac.location
	and death.date= vac.date
where death.continent is not null
order by 2,3



select * from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
order by 3,4


select location, date, total_cases, new_cases, total_deaths, population_density
from [PortfolioProject].[dbo].[CovidDeaths$]
order by location asc

select location, date, total_cases, total_deaths, ((cast(total_deaths as int))/(cast(total_cases as int)))*100 as DeathPercentage
from [PortfolioProject].[dbo].[CovidDeaths$]
order by location asc

--Looking at total cases vs population
--shows what percentage of population got covid

select location, date, total_cases, population_density, (total_cases/population_density)*100 as PercentofPopulationInfected
from [PortfolioProject].[dbo].[CovidDeaths$]
where location like '%states%'
order by 1,2

--Looking at Countries with Highest Infection Rate compared to Population

select location, population_density, max(total_cases) as HighestInfectionCount, max((total_cases/population_density))*100 as PercentofPopulationInfected
from [PortfolioProject].[dbo].[CovidDeaths$]
group by location, population_density
order by PercentofPopulationInfected desc

--Showing the countries with the highest Death Count per Popuulation density



select location, max(cast(total_deaths as int)) as TotalDeathCount
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is null
group by location
order by TotalDeathCount desc

--Let's break things down by continent

select continent, max(cast(total_deaths as int)) as TotalDeathCount
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
group by continent
order by TotalDeathCount desc

--Showing the continents with highest death counts

select continent, max(cast(total_deaths as int)) as TotalDeathCount
from [PortfolioProject].[dbo].[CovidDeaths$]
where continent is not null
group by continent
order by TotalDeathCount desc



Select *
From [PortfolioProject].[dbo].[CovidVaccinations$]



Select *
From [PortfolioProject].[dbo].[CovidDeaths$] death
JOIN [PortfolioProject].[dbo].[CovidVaccinations$] vac
	ON death.location = vac.location
	and death.date= vac.date

--Looking at total population density vs Vaccinations

Select death.continent, death.location, death.date, death.population_density, vac.new_vaccinations
From [PortfolioProject].[dbo].[CovidDeaths$] death
JOIN [PortfolioProject].[dbo].[CovidVaccinations$] vac
	ON death.location = vac.location
	and death.date= vac.date
where death.continent is not null
order by 2,3

Select death.continent, death.location, death.date, death.population_density, vac.new_vaccinations
, sum(convert(bigint,vac.new_vaccinations )) OVER (Partition by death.location 
Order by death.location, death.date) as RollingPeopleVaccinated
From [PortfolioProject].[dbo].[CovidDeaths$] death
JOIN [PortfolioProject].[dbo].[CovidVaccinations$] vac
	ON death.location = vac.location
	and death.date= vac.date
where death.continent is not null
order by 2,3

--Use CTE

With PopvsVac (Continent, Location, Date, PopulationDensity, New_Vaccinations, RollingPeopleVaccinated)
as 
(
Select death.continent, death.location, death.date, death.population_density, vac.new_vaccinations
, sum(convert(bigint,vac.new_vaccinations )) OVER (Partition by death.location 
Order by death.location, death.date) as RollingPeopleVaccinated
From [PortfolioProject].[dbo].[CovidDeaths$] death
JOIN [PortfolioProject].[dbo].[CovidVaccinations$] vac
	ON death.location = vac.location
	and death.date= vac.date
where death.continent is not null
--order by 2,3
)
select *, (RollingPeopleVaccinated/PopulationDensity)*100
from PopvsVac

--Temp Table

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
PopulationDensity numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select death.continent, death.location, death.date, death.population_density, vac.new_vaccinations
, sum(convert(bigint,vac.new_vaccinations )) OVER (Partition by death.location 
Order by death.location, death.date) as RollingPeopleVaccinated
From [PortfolioProject].[dbo].[CovidDeaths$] death
JOIN [PortfolioProject].[dbo].[CovidVaccinations$] vac
	ON death.location = vac.location
	and death.date= vac.date
where death.continent is not null
--order by 2,3

Select *
from  #PercentPopulationVaccinated

/*select *, (RollingPeopleVaccinated/PopulationDensity)*100
from #PercentPopulationVaccinated  
*/

select *, (convert(float, RollingPeopleVaccinated)/nullif(convert(float, PopulationDensity),0))*100
from #PercentPopulationVaccinated  


--Creating View to store data for visualization

Create view PercentPopulationVaccinated as 
Select death.continent, death.location, death.date, death.population_density, vac.new_vaccinations
, sum(convert(bigint,vac.new_vaccinations )) OVER (Partition by death.location 
Order by death.location, death.date) as RollingPeopleVaccinated
From [PortfolioProject].[dbo].[CovidDeaths$] death
JOIN [PortfolioProject].[dbo].[CovidVaccinations$] vac
	ON death.location = vac.location
	and death.date= vac.date
where death.continent is not null
--order by 2,3

select *
from PercentPopulationVaccinated

