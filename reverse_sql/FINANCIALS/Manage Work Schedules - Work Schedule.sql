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
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ZMM_SR_SCHEDULE_TYPE'
    AND LOOKUP_CODE = schedulesE0.SCHEDULE_TYPE_CODE
    ) RES_TYPE
,TO_CHAR(schedulesE0.EFFECTIVE_FROM_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_FROM_DATE
,TO_CHAR(schedulesE0.EFFECTIVE_TO_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_TO_DATE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ZMM_SR_SCHEDULE_CATEGORY'
    AND LOOKUP_CODE = schedulesE0.CATEGORY_CODE
    ) RES_CATEGORY
,schedulesE0.SCHEDULE_DESC RES_DESCRIPTION
,schedulesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,schedulesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,schedulesE0.CREATED_BY RSC_CREATED_BY
,schedulesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_SR_SCHEDULES_VL schedulesE0
ORDER BY schedulesE0.SCHEDULE_NAME