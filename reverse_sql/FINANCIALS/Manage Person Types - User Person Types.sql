/* ****************************************************************************
 * $Revision: 72962 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-11-27 16:43:41 +0700 (Wed, 27 Nov 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Map%20Third-Party%20Compensation%20Plans%20-%20Map%20Third-Party%20Plans.sql $:
 * $Id: Map Third-Party Compensation Plans - Map Third-Party Plans.sql 72962 2019-11-27 09:43:41Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
  
SELECT lookupsE0.MEANING  RES_SYSTEM_PERSON_TYPE
,userTypesE0.USER_PERSON_TYPE RES_ASSIGNMENT_PERSON_TYPE
,DECODE(userTypesE0.ACTIVE_FLAG,'Y','Active','N','Inactive') RES_STATUS
,DECODE(userTypesE0.DEFAULT_FLAG,'Y','Yes','N','No') RES_DEFAULT
,userTypesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,userTypesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,userTypesE0.CREATED_BY RSC_CREATED_BY
,userTypesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,userTypesE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_VALUES lookupsE0
,PER_PERSON_TYPES_VL userTypesE0
WHERE lookupsE0.LANGUAGE = USERENV('LANG')
AND lookupsE0.LOOKUP_TYPE = 'SYSTEM_PERSON_TYPE'
AND lookupsE0.LOOKUP_CODE = userTypesE0.SYSTEM_PERSON_TYPE
ORDER BY lookupsE0.LOOKUP_CODE