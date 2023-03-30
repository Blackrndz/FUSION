/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT schedulesE0.SCHEDULE_NAME RES_NAME
,eligibilitiesE0.NAME RES_ELIGIBILITY_PROFILE_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'BEN_ELIG_PRFL_PERS_TYPE'
	AND LOOKUP_CODE = eligibilitiesE0.PROFILE_TYPE 
	) RES_PROFILE_TYPE
,DECODE(eligibilitiesE0.STAT_CD,'A','Active','Inactive') RES_STATUS
,eligibilitiesE0.DESCRIPTION RES_DESCRIPTION
,scheduleEligibilitiesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,scheduleEligibilitiesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,scheduleEligibilitiesE0.CREATED_BY RSC_CREATED_BY
,scheduleEligibilitiesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_SR_SCHEDULES_VL schedulesE0
,PER_SCHEDULE_ELIGIBILITY scheduleEligibilitiesE0
,BEN_ELIGY_PRFL eligibilitiesE0
WHERE schedulesE0.SCHEDULE_ID = scheduleEligibilitiesE0.SCHEDULE_ID
AND scheduleEligibilitiesE0.ELIGIBILITY_PROFILE_ID = eligibilitiesE0.ELIGY_PRFL_ID
AND SYSDATE BETWEEN eligibilitiesE0.START_DATE AND eligibilitiesE0.END_DATE
ORDER BY schedulesE0.SCHEDULE_NAME