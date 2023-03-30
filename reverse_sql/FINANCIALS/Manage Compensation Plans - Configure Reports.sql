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
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES 
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = actionsE0.ATTRIBUTE_NAME
	AND LOOKUP_CODE = actionsE0.ATTRIBUTE_VALUE 
	) RES_REPORT_NAME
,DECODE(actionsE0.ENABLED_FLAG,'Y','Yes','N','No') RES_ENABLE
,actionsE0.ORDER_NUM RES_DISPLAY_ORDER
,actionsE0.DISPLAY_NAME RES_DISPLAY_NAME
,actionsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,actionsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,actionsE0.CREATED_BY RSC_CREATED_BY
,actionsE0.CREATION_DATE RSC_CREATION_DATE
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
	AND ATTRIBUTE_NAME IN (SELECT LOOKUP_CODE FROM FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CMP_ANALYTICAL_REP_TYPE')
	) actionsE0
WHERE cmpPLANEO.COMP_TYPE = 'CWB'
AND cmpPLANEO.PLAN_ID = actionsE0.KEY_VALUE
ORDER BY cmpPLANEO.PLAN_NAME
,actionsE0.ORDER_NUM
,actionsE0.ATTRIBUTE_NAME