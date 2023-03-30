/* ****************************************************************************
 * $Revision: 54470 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-04-19 10:52:05 +0700 (Tue, 19 Apr 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Contact%20Point%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Contact Point Lookups - Lookup Codes.sql 54470 2016-04-19 03:52:05Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_HIERARCHY_LEVELS
 
SELECT (SELECT NAME
	FROM MSC_DIMENSIONS_TL
	WHERE DIMENSION_ID = HierarchiesE0.DIMENSION_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_DIMENSION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_MSC_LEVEL_TYPE'
	AND LOOKUP_CODe = LevelsE0.LEVEL_POS_NUM
	) RES_LEVEL
,HierarchiesE0.NAME RES_HIERARCHY_NAME
,LevelsE0.NAME RES_DEFAULT_LEVEL_NAME
,LevelsE0.USER_SPECIFIED_NAME RES_DISPLAY_OVERRIDE
,LevelsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LevelsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LevelsE0.CREATED_BY RSC_CREATED_BY
,LevelsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_HIERARCHIES_VL HierarchiesE0
,MSC_HIERARCHY_LEVELS HierarchieLevelsE0
,MSC_LEVELS_VL LevelsE0
WHERE HierarchiesE0.HIERARCHY_ID = HierarchieLevelsE0.HIERARCHY_ID
AND HierarchieLevelsE0.LEVEL_ID = LevelsE0.LEVEL_ID
ORDER BY 1,2 DESC