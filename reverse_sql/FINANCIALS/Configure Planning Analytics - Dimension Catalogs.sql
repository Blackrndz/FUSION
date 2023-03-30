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
,DimensionCatE0.DESCRIPTION RES_DESCRIPTION
,'' RES_STATUS
,DECODE(DimensionCatE0.IS_DEFAULT,1,'Yes','No') RES_DEFAULT
,(SELECT (CASE
		WHEN CatalogHierarchiesE0.IS_ATTRIBUTE = 0 THEN
			(SELECT NAME
				FROM MSC_HIERARCHIES_TL
				WHERE HIERARCHY_ID = CatalogHierarchiesE0.HIERARCHY_ID
				AND LANGUAGE = USERENV('LANG'))
		ELSE
			(SELECT ATTRIBUTE_NAME
				FROM MSC_LEVEL_ATTRIBUTES_B
				WHERE ATTRIBUTE_ID = CatalogHierarchiesE0.HIERARCHY_ID)
		END)
	FROM MSC_CATALOG_HIERARCHIES CatalogHierarchiesE0
	WHERE DimensionCatE0.CATALOG_ID = CatalogHierarchiesE0.CATALOG_ID
	AND CatalogHierarchiesE0.DIMENSION_ID = 1
	AND CatalogHierarchiesE0.IS_DEFAULT = 1
	) RES_PRODUCT_HIERARCHY
,(SELECT (CASE
		WHEN CatalogHierarchiesE0.IS_ATTRIBUTE = 0 THEN
			(SELECT NAME
				FROM MSC_HIERARCHIES_TL
				WHERE HIERARCHY_ID = CatalogHierarchiesE0.HIERARCHY_ID
				AND LANGUAGE = USERENV('LANG'))
		ELSE
			(SELECT ATTRIBUTE_NAME
				FROM MSC_LEVEL_ATTRIBUTES_B
				WHERE ATTRIBUTE_ID = CatalogHierarchiesE0.HIERARCHY_ID)
		END)
	FROM MSC_CATALOG_HIERARCHIES CatalogHierarchiesE0
	WHERE DimensionCatE0.CATALOG_ID = CatalogHierarchiesE0.CATALOG_ID
	AND CatalogHierarchiesE0.DIMENSION_ID = 7
	AND CatalogHierarchiesE0.IS_DEFAULT = 1
	) RES_MANUFACTURING_CALENDAR
,DimensionCatE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DimensionCatE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DimensionCatE0.CREATED_BY RSC_CREATED_BY
,DimensionCatE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_DIMENSION_CATALOGS_VL DimensionCatE0
ORDER BY DimensionCatE0.NAME