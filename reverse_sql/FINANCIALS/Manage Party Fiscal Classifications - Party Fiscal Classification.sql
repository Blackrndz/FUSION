/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT fcTypesE0.OWNER_ID_CHAR RES_PARTY_CLASSIFICATION
,fcTypesE0.CLASSIFICATION_TYPE_LEVEL_CODE RES_NUMBER_OF_LEVELS
,fcTypesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,fcTypesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,fcTypesE0.CREATED_BY RSC_CREATED_BY
,fcTypesE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_FC_TYPES_VL fcTypesE0
WHERE fcTypesE0.CLASSIFICATION_TYPE_CATEG_CODE = 'PARTY_FISCAL_CLASS'
ORDER BY fcTypesE0.OWNER_ID_CHAR
,fcTypesE0.CLASSIFICATION_TYPE_LEVEL_CODE