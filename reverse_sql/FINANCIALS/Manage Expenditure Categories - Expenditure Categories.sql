/* ****************************************************************************
 * $Revision: 61016 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-02-10 11:47:39 +0700 (Fri, 10 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Sources%20-%20Manage%20Transaction%20Sources.sql $:
 * $Id: Manage Transaction Sources - Manage Transaction Sources.sql 61016 2017-02-10 04:47:39Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT expCategoriesE0.EXPENDITURE_CATEGORY_NAME RES_NAME
,expCategoriesE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(expCategoriesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(expCategoriesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,expCategoriesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,expCategoriesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,expCategoriesE0.CREATED_BY RSC_CREATED_BY
,expCategoriesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_EXP_CATEGORIES_VL expCategoriesE0
ORDER BY expCategoriesE0.EXPENDITURE_CATEGORY_NAME