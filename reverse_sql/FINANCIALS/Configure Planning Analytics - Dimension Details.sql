/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Lot Grades - Lot Grades.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_DIMENSION_CATALOGS_VL

SELECT DimensionCatE0.NAME RES_DIMENSION_CATALOG_NAME
,(SELECT NAME
	FROM MSC_DIMENSIONS_TL
	WHERE DIMENSION_ID = CatalogHierarchiesE0.DIMENSION_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_PARENT_SELECTED_HIERARCHIE
,(CASE
	WHEN CatalogHierarchiesE0.IS_ATTRIBUTE = 0 THEN
		(SELECT NAME
			FROM MSC_HIERARCHIES_TL
			WHERE HIERARCHY_ID = CatalogHierarchiesE0.HIERARCHY_ID
			AND LANGUAGE = USERENV('LANG'))
	ELSE
		(SELECT ATTRIBUTE_NAME
			FROM MSC_LEVEL_ATTRIBUTES_B
			WHERE ATTRIBUTE_ID = CatalogHierarchiesE0.HIERARCHY_ID)
	END) RES_SELECTED_HIERARCHIES
,CatalogHierarchiesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CatalogHierarchiesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CatalogHierarchiesE0.CREATED_BY RSC_CREATED_BY
,CatalogHierarchiesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_DIMENSION_CATALOGS_VL DimensionCatE0
,MSC_CATALOG_HIERARCHIES CatalogHierarchiesE0
WHERE DimensionCatE0.CATALOG_ID = CatalogHierarchiesE0.CATALOG_ID
ORDER BY 1,2,3