/* ****************************************************************************
 * $Revision: 78340 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-04-20 09:07:02 +0700 (Wed, 20 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Work%20Definition%20Names%20-%20Work%20Definition%20Names.sql $:
 * $Id: Manage Work Definition Names - Work Definition Names.sql 78340 2022-04-20 02:07:02Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=WIS_WORK_DEFINITION_NAMES_VL

SELECT WORK_DEF_NAME RES_DISPLAY_NAME
,WORK_DEFINITION_CODE RES_INTERNAL_NAME
,WORK_DEF_NAME_DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = WORK_DEFINITION_TYPE 
	AND LOOKUP_TYPE = 'ORA_WIS_WORK_DEFINITION_TYPE' AND LANGUAGE = USERENV('LANG'))RES_TYPE
,DECODE(USED_IN_PLANNING_FLAG,'Y','Yes','No') RES_USED_IN_PLANNING
,TO_CHAR(EFFECTIVE_FROM_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(EFFECTIVE_TO_DATE,'DD-Mon-YYYY') RES_END_DATE
,LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CREATED_BY RSC_CREATED_BY
,CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM WIS_WORK_DEFINITION_NAMES_VL
ORDER BY WORK_DEF_NAME