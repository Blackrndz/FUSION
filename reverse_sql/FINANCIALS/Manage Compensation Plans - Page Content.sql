/* ****************************************************************************
 * $Revision: 72749 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-10-23 15:22:46 +0700 (Wed, 23 Oct 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Availability%20Lookups%20-%20Lookup%20Types.sql $:
 * $Id: Manage Availability Lookups - Lookup Types.sql 72749 2019-10-23 08:22:46Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT cmpPLANEO.PLAN_NAME RES_PLAN
,'Page Content' RES_TASK
,actionsE0.DISPLAY_NAME RES_TILE_NAME
,pageCOntentsE0.DISPLAY_NAME RES_SECTION_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES 
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ORA_CMP_IW_SEC_CONTENT_TYPE'
	AND LOOKUP_CODE = pageCOntentsE0.TEXT_VALUE4 
	) RES_CONTENT_TYPE
,pageCOntentsE0.NUMBER_VALUE1 RES_SEQUENCE
,pageCOntentsE0.ORDER_NUM RES_SUMMARY_POSITION
,DECODE(pageCOntentsE0.ENABLED_FLAG,'Y','Yes','N','No') RES_ENABLE
,pageCOntentsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,pageCOntentsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,pageCOntentsE0.CREATED_BY RSC_CREATED_BY
,pageCOntentsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_PLANS_VL cmpPLANEO
,(SELECT * 
	FROM CMP_LOOKUP_USAGES_VL
	WHERE KEY_TYPE = 'PLAN'
	AND ATTRIBUTE_NAME = 'ORA_CMP_CWB_IW_PAGE_TILES'
	AND (DISPLAY_NAME IS NOT NULL
		OR ORDER_NUM IS NOT NULL
		OR TEXT_VALUE1 IS NOT NULL)
	) actionsE0
,(SELECT * 
	FROM CMP_LOOKUP_USAGES_VL
	WHERE KEY_TYPE = 'SECTION'
	AND DISPLAY_NAME IS NOT NULL
	) pageCOntentsE0
WHERE cmpPLANEO.COMP_TYPE = 'CWB'
AND cmpPLANEO.PLAN_ID = actionsE0.KEY_VALUE
AND cmpPLANEO.PLAN_ID = pageCOntentsE0.KEY_VALUE
AND actionsE0.ATTRIBUTE_VALUE = pageCOntentsE0.ATTRIBUTE_NAME
ORDER BY cmpPLANEO.PLAN_NAME
,actionsE0.ORDER_NUM
,actionsE0.ATTRIBUTE_NAME
,pageCOntentsE0.NUMBER_VALUE1