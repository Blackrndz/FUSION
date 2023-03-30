/* ****************************************************************************
 * $Revision: 61016 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-02-10 11:47:39 +0700 (Fri, 10 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Sources%20-%20Manage%20Transaction%20Sources.sql $:
 * $Id: Manage Transaction Sources - Manage Transaction Sources.sql 61016 2017-02-10 04:47:39Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT expTypesE0.EXPENDITURE_TYPE_NAME RES_EXPENDITURE_TYPE
,buE0.BU_NAME RES_BUSINESS_UNIT
,taxClassCodesE0.OUTPUT_TAX_CLASSIFICATION_CODE RES_TAX_CLASSIFICATION_CODE
,taxClassCodesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,taxClassCodesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,taxClassCodesE0.CREATED_BY RSC_CREATED_BY
,taxClassCodesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,taxClassCodesE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_EXP_TYPES_VL expTypesE0
,PJF_EXP_TYPE_OUS_ALL taxClassCodesE0
,FUN_ALL_BUSINESS_UNITS_V buE0
WHERE expTypesE0.EXPENDITURE_TYPE_ID = taxClassCodesE0.EXPENDITURE_TYPE_ID
AND taxClassCodesE0.ORG_ID = buE0.BU_ID
ORDER BY expTypesE0.EXPENDITURE_TYPE_NAME
,buE0.BU_NAME