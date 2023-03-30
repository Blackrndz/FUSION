/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=BEN_LER_F

SELECT lifeEventsE0.NAME RES_NAME
,lifeEventsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,lifeEventsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,lifeEventsE0.CREATED_BY RSC_CREATED_BY
,lifeEventsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,lifeEventsE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_LER_F lifeEventsE0
WHERE SYSDATE BETWEEN lifeEventsE0.EFFECTIVE_START_DATE AND lifeEventsE0.EFFECTIVE_END_DATE
ORDER BY lifeEventsE0.NAME
,lifeEventsE0.EFFECTIVE_START_DATE