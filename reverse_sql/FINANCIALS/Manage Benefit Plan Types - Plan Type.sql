/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT planTypesE0.NAME RES_PLAN_TYPE_NAME
,planTypesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,planTypesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,planTypesE0.CREATED_BY RSC_CREATED_BY
,planTypesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,planTypesE0.LEGISLATION_CODE RSC_COUNTRY_ID
FROM BEN_PL_TYP_F planTypesE0
WHERE SYSDATE BETWEEN planTypesE0.EFFECTIVE_START_DATE AND planTypesE0.EFFECTIVE_END_DATE
ORDER BY planTypesE0.NAME