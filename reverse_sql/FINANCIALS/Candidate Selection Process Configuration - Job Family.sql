/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=IRC_DESCRIPTIONS_VL

SELECT configPoolsE0.NAME RES_NAME
,configPoolsE0.CODE RES_CODE
,(SELECT JOB_FAMILY_NAME
	FROM PER_JOB_FAMILY_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND JOB_FAMILY_ID = contextsE0.JOB_FAMILY_ID 
	) RES_JOB_FAMILY
,contextsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,contextsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,contextsE0.CREATED_BY RSC_CREATED_BY
,contextsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_PROCESSES_VL configPoolsE0
,IRC_AVAILABILITY_CONTEXT contextsE0
WHERE configPoolsE0.TYPE_CODE = 'CSW'
AND configPoolsE0.USAGE_CODE = 'TEMPLATE'
AND configPoolsE0.PROCESS_ID = contextsE0.OBJECT_ID
AND contextsE0.OBJECT_TYPE_CODE = 'ORA_CSP'
AND contextsE0.DIMENSION_TYPE_CODE = 'ORA_JOB_FAMILY'
ORDER BY configPoolsE0.NAME