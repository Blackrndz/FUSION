/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT 'Yes' RES_PUBLIC_HOLIDAY
,messagesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,messagesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,messagesE0.CREATED_BY RSC_CREATED_BY
,messagesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,messagesE0.ENTERPRISE_ID RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_PORTRAIT_MESSAGES_VL messagesE0
WHERE messagesE0.SHOW_CAL_EVT_CATEGORY = 'PH'