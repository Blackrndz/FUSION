/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCD_EXP_DATA_DEF_VL

SELECT expsE0.NAME RES_NAME
,expsE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(expsE0.TCD_EXP_START_DATE,'DD-Mon-YYYY') RES_START_DATE
,expsE0.TCD_EXP_DURATION RES_NUMBER_OF_DAYS_IN_PERIOD
,expsE0.TCD_EXPORT_BATCH_SIZE RES_NUMBER_OF_OBJECTS_IN_BATCH

--Person Information
,DECODE(expsE0.FIRST_NAME,'Y','Yes','No') RES_PERSON_FIRST_NAME
,DECODE(expsE0.LAST_NAME,'Y','Yes','No') RES_PERSON_LAST_NAME
,DECODE(expsE0.PERSON_BADGE_ID,'Y','Yes','No') RES_PERSON_BADGE_ID

--Other Information
,DECODE(expsE0.PAY_TIME_TYPES,'Y','Yes','No') RES_OTHER_PAYROLL_TIME_TYPES
,DECODE(expsE0.SCHEDULE,'Y','Yes','No') RES_OTHER_SCHEDULE

,expsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,expsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,expsE0.CREATED_BY RSC_CREATED_BY
,expsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,expsE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_TCD_EXP_DATA_DEF_VL expsE0
ORDER BY expsE0.NAME