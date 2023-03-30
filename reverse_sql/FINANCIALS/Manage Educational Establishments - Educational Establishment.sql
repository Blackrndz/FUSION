/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT edusE0.SCHOOL_CODE RES_CODE
,edusE0.NAME RES_NAME
,edusE0.DESCRIPTION RES_DESCRIPTION
,(SELECT GEOGRAPHY_NAME 
	FROM HZ_GEOGRAPHIES
	WHERE SYSDATE BETWEEN START_DATE AND END_DATE 
	AND GEOGRAPHY_ID = edusE0.COUNTRY_ID 
	) RES_COUNTRY
,(SELECT GEOGRAPHY_NAME 
	FROM HZ_GEOGRAPHIES
	WHERE SYSDATE BETWEEN START_DATE AND END_DATE 
	AND GEOGRAPHY_ID = edusE0.STATE_PROVINCE_ID 
	) RES_STATE_OR_PROVINCE
,edusE0.LOCATION RES_LOCATION
,edusE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,edusE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,edusE0.CREATED_BY RSC_CREATED_BY
,edusE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,edusE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_ESTABLISHMENTS_VL edusE0
ORDER BY edusE0.SCHOOL_CODE