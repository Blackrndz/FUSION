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

SELECT cxSitesE0.SITE_NAME RES_SITE_NAME
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'JOB_FUNCTION_CODE'
    AND LOOKUP_CODE = contextsE0.JOB_FUNCTION_CODE
    ) RES_JOB_FUNCTIONS
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

FROM IRC_CX_SITES_VL cxSitesE0
,IRC_AVAILABILITY_CONTEXT contextsE0
WHERE cxSitesE0.SITE_ID = contextsE0.OBJECT_ID
AND contextsE0.OBJECT_TYPE_CODE = 'ORA_CE_SITES'
AND contextsE0.DIMENSION_TYPE_CODE = 'ORA_JOB_FUNCTION'
ORDER BY cxSitesE0.SEQUENCE_NUMBER