/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-11-16  $:
 * $HeadURL:  $:
 * $Id: Publish Account Hierarchies - Publish Account Hierarchies.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT legisDataGroupsE0.NAME RES_LEGISLATIVE_DATA_GROUP
,gradeRatesE0.NAME RES_NAME

,gradeRatesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,gradeRatesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,gradeRatesE0.CREATED_BY RSC_CREATED_BY
,gradeRatesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,legisDataGroupsE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM PER_RATES_F_VL gradeRatesE0
,(SELECT LEGISLATIVE_DATA_GROUP_ID
    ,NAME
	,LEGISLATION_CODE
    FROM PER_LEGISLATIVE_DATA_GROUPS_VL
    ) legisDataGroupsE0
WHERE SYSDATE BETWEEN gradeRatesE0.EFFECTIVE_START_DATE AND gradeRatesE0.EFFECTIVE_END_DATE
AND gradeRatesE0.RATE_OBJECT_TYPE= 'GRADE'
AND gradeRatesE0.LEGISLATIVE_DATA_GROUP_ID = legisDataGroupsE0.LEGISLATIVE_DATA_GROUP_ID
ORDER BY legisDataGroupsE0.NAME
,gradeRatesE0.NAME,gradeRatesE0.EFFECTIVE_START_DATE