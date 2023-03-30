/* ****************************************************************************
 * $Revision: 62668 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-06-19 18:28:29 +0700 (Mon, 19 Jun 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 62668 2017-06-19 11:28:29Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=MSC_MEASURE_CATALOGS_VL

SELECT MeasureCatalogsE0.NAME RES_MEASURE_CATALOG_NAME
,(SELECT NAME
	FROM MSC_MEASURE_GROUPS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND GROUP_ID = MeasureGroupsE0.GROUP_ID
	) RES_PARENT_SELECTED_MEASURES
,MeasuresE0.NAME RES_SELECTED_MEASURES
,MeasureCatalogsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,MeasureCatalogsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,MeasureCatalogsE0.CREATED_BY  RSC_CREATED_BY
,MeasureCatalogsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM MSC_MEASURE_CATALOGS_VL MeasureCatalogsE0
,MSC_CATALOG_MEASURES MeasureAssignE0
,MSC_MEASURES_VL MeasuresE0
,(SELECT MEASURE_ID
	,GROUP_ID
	,ROW_NUMBER() OVER(PARTITION BY MEASURE_ID ORDER BY MEASURE_ID) X1
	FROM MSC_MEASURE_GROUP_ASSIGN
	) MeasureGroupsE0
WHERE MeasureCatalogsE0.CATALOG_ID = MeasureAssignE0.CATALOG_ID
AND MeasureAssignE0.MEASURE_ID = MeasuresE0.MEASURE_ID
AND MeasuresE0.MEASURE_ID = MeasureGroupsE0.MEASURE_ID
AND MeasureGroupsE0.X1 = 1
ORDER BY 1,2,3