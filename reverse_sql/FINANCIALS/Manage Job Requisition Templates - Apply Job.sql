
/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL

SELECT jobReqTemplatesE0.NAME RES_NAME
,jobReqTemplatesE0.REQUISITION_NUMBER RES_CODE
,jobsE0.NAME RES_SELECT_A_JOB
,jobReqTemplatesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,jobReqTemplatesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,jobReqTemplatesE0.CREATED_BY RSC_CREATED_BY
,jobReqTemplatesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_REQUISITIONS_VL jobReqTemplatesE0
,(SELECT JOB_ID
	,NAME
	FROM PER_JOBS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	) jobsE0
WHERE jobReqTemplatesE0.REQ_USAGE_CODE = 'ORA_TEMPLATE'
AND jobReqTemplatesE0.JOB_ID = jobsE0.JOB_ID
ORDER BY jobReqTemplatesE0.REQUISITION_NUMBER