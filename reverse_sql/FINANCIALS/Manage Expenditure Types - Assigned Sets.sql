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
,setsE0.SET_CODE RES_CODE
,setsE0.SET_NAME RES_NAME
,setsE0.DESCRIPTION RES_DESCRIPTION
,assignSetsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,assignSetsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,assignSetsE0.CREATED_BY RSC_CREATED_BY
,assignSetsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_EXP_TYPES_VL expTypesE0
,PJF_EXP_TYPES_B_ST assignSetsE0
,FND_SETID_SETS setsE0
WHERE expTypesE0.EXPENDITURE_TYPE_ID = assignSetsE0.EXPENDITURE_TYPE_ID
AND assignSetsE0.SET_ID = setsE0.SET_ID
AND setsE0.LANGUAGE = USERENV('LANG')
ORDER BY expTypesE0.EXPENDITURE_TYPE_NAME
,setsE0.SET_CODE