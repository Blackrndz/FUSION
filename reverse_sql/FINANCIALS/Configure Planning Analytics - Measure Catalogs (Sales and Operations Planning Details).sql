/* ****************************************************************************
 * $Revision$:
 * $Author$:
 * $Date$:
 * $HeadURL$:
 * $Id$:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_DIMENSION_CATALOGS_VL

SELECT MeasureCatalogsE0.NAME RES_MEASURE_CATALOG_NAME
,(SELECT NAME
	FROM MSC_MEASURE_GROUPS_TL
	WHERE GROUP_ID  = MeasureGroupAssignE0.GROUP_ID 
	AND LANGUAGE = USERENV('LANG')
	) RES_PARENT_SELECTED_MEASURES
,(SELECT NAME
	FROM MSC_MEASURES_TL
	WHERE MEASURE_ID  = CatalogMeasureE0.MEASURE_ID 
	AND LANGUAGE = USERENV('LANG')
	) RES_SELECTED_MEASURES
,CatalogMeasureE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CatalogMeasureE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CatalogMeasureE0.CREATED_BY RSC_CREATED_BY
,CatalogMeasureE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_MEASURE_CATALOGS_VL MeasureCatalogsE0
,MSC_CATALOG_MEASURES CatalogMeasureE0
,MSC_MEASURE_GROUP_ASSIGN MeasureGroupAssignE0
WHERE MeasureCatalogsE0.CATALOG_ID = CatalogMeasureE0.CATALOG_ID
AND CatalogMeasureE0.MEASURE_ID = MeasureGroupAssignE0.MEASURE_ID
ORDER BY 1,2,3