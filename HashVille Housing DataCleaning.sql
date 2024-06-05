----------------------------------------------------------------------------------------------------------------------------------------------
/*                                                                                                                                           |
Cleaning DATA with SQL                                                                                                                       |
*/--                                                                                                                                         |
---------------------------------------------------------------------------------------------------------------------------------------------|

SELECT * FROM PortfolioProject.dbo.NashVilleHousing


----------------------------------------------------------------------------------------------------------------------------------------------
/*
Change the SaleDate format from 2013-04-09 00:00:00.000 to  2013-04-09
*/

SELECT SaleDate, CONVERT(Date, SaleDate)
FROM PortfolioProject.dbo.NashVilleHousing


UPDATE NashVilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

--if this last one does not work then do the following that will add onother column with the converted date

--add a column to the table
ALTER TABLE NashVilleHousing
Add SaleDateConvertedFormat Date

--update that column with converted last saledate
UPDATE NashVilleHousing
SET SaleDateConvertedFormat = CONVERT(Date, SaleDate)

--just select the converted format
SELECT SaleDateConvertedFormat, CONVERT(Date, SaleDate)
FROM PortfolioProject.dbo.NashVilleHousing

----------------------------------------------------------------------------------------------------------------------------------------------
/*                                                                                                                                           |
Property Adress                                                                                                                              |
*/--                                                                                                                                         |
---------------------------------------------------------------------------------------------------------------------------------------------|

SELECT PropertyAddress
FROM NashVilleHousing

SELECT *
FROM PortfolioProject.dbo.NashVilleHousing
where PropertyAddress is null

--all property with the same parcel id will be grouped (like delete duplication)
--que propertyaddress de b est là et celui de 1 n'est pas là on va verifier si celui de a est null

--1 voir les parties null
SELECT a.ParcelID, a.PropertyAddress, b.parcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.NashVilleHousing a
JOIN PortfolioProject.dbo.NashVilleHousing b
ON a.ParcelID = b.parcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

--2 update ces partie par celle de b
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.NashVilleHousing a
JOIN PortfolioProject.dbo.NashVilleHousing b
ON a.ParcelID = b.parcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

/*
Breakin address into individual Column (Address, City, State)
Separer les address en trois partie sui seront : l'address, la ville
*/

SELECT PropertyAddress
FROM PortfolioProject.dbo.NashVilleHousing
order by ParcelID

--on commence par la position 1 de la str pour aller a la position de la virgule -1(qui va contenir la premier chaine, 
--ensuite on commence par la position de la virgule pour aller a la position strlen (qui va contenir la second chaine
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
SUBSTRING(PropertyAddress, (CHARINDEX(',', PropertyAddress) + 1),  LEN(PropertyAddress)) AS Address
FROM PortfolioProject.dbo.NashVilleHousing

--la requete precedente a ete pour voir le resultat ceux ci serons pour ajouter 

--1 pour l'address
ALTER TABLE PortfolioProject.dbo.NashVilleHousing
Add PropertySplitAddress nvarchar(255)

UPDATE PortfolioProject.dbo.NashVilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

--2 pour la city
ALTER TABLE PortfolioProject.dbo.NashVilleHousing
Add PropertySplitCity nvarchar(255)

UPDATE PortfolioProject.dbo.NashVilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, (CHARINDEX(',', PropertyAddress) + 1),  LEN(PropertyAddress))

--voir les resultats
SELECT *
FROM PortfolioProject.dbo.NashVilleHousing


--Pour Owner address . Parsername dans notre cas pour 1 est la dernier partie (from backword), la premiere partie contiendra le dernier mot avant
--la virgule en comment dans le sens inverse de lecture
SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'),  3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),  2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),  1)
FROM PortfolioProject.dbo.NashVilleHousing

--ajouter des colonnes puis inserer les données decouper avec parsername

---------------------------------------------
--1 pour l'address donc index 3 a compter de la droite vers la gauche (maintenant le 3)

ALTER TABLE PortfolioProject.dbo.NashVilleHousing
Add OwnerSplitAddress nvarchar(255)

UPDATE PortfolioProject.dbo.NashVilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),  3)

---------------------------------------------
--2 pour la city donc index 2 a compter de la droite vers la gauche (maintenant le 2)

ALTER TABLE PortfolioProject.dbo.NashVilleHousing
Add  OwnerSplitCity nvarchar(255)

UPDATE PortfolioProject.dbo.NashVilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),  2)

---------------------------------------------
--3 pour la address donc index 3 a compter de la droite vers la gauche (maintenant le 1)

ALTER TABLE PortfolioProject.dbo.NashVilleHousing
Add OwnerSplitState nvarchar(255)

UPDATE PortfolioProject.dbo.NashVilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),  1)

--
--voir le resultats
SELECT *
FROM PortfolioProject.dbo.NashVilleHousing

----------------------------------------------------------------------------------------------------------------------------------------------
/*                                                                                                                                           |
Change Y and N to Yes and No in 'SoldAsVacant'                                                                                                                              |
*/--                                                                                                                                         |
---------------------------------------------------------------------------------------------------------------------------------------------|

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject.dbo.NashVilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END AS UpdatedStatement
FROM PortfolioProject.dbo.NashVilleHousing


----------------------------------------------------------------------------------------------------------------------------------------------
/*                                                                                                                                           |
remove duplicated                                                                                                                              |
*/--                                                                                                                                         |
---------------------------------------------------------------------------------------------------------------------------------------------|

SELECT *
FROM PortfolioProject.dbo.NashVilleHousing


--partitionner plusieurs colonnes ensemble, si tout son exact alors on verra les nombres des duplicates
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY UniqueID
				) as row_num
FROM PortfolioProject.dbo.NashVilleHousing
ORDER BY ParcelID

--la precedente est bonne mais je veux ajouter la condition de voir que la ou le resultat est superieur a 1

SELECT *
FROM (
	SELECT *,
		ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
					PropertyAddress,
					SalePrice,
					SaleDate,
					LegalReference
				ORDER BY UniqueID
			) as row_num
		FROM PortfolioProject.dbo.NashVilleHousing
) AS subquery
WHERE subquery.row_num > 1

-- autre maniere aussi de le faire qui sera un peu comme une table temporaire et va contennir une field appelé row_num
WITH RowNumCTE AS (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY UniqueID
				) as row_num
FROM PortfolioProject.dbo.NashVilleHousing
)

--Select * FROM RowNumCTE

SELECT * FROM RowNumCTE
WHERE row_num > 1

DELETE 
FROM RowNumCTE
WHERE row_num > 1



----------------------------------------------------------------------------------------------------------------------------------------------
/*                                                                                                                                           |
delete unused columns, ici on va supprimer par exemple les colonne dont on a eu a separer, like       PropertyAddress, Saledate, owneraddress|
*/--                                                                                                                                         |
---------------------------------------------------------------------------------------------------------------------------------------------|

SELECT *
FROM PortfolioProject.dbo.NashVilleHousing

ALTER TABLE PortfolioProject.dbo.NashVilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject.dbo.NashVilleHousing
DROP COLUMN SaleDate

