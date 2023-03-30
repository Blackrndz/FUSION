/* ****************************************************************************
 * $Revision: 68520 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2018-08-30 14:13:44 +0700 (Thu, 30 Aug 2018) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.20/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Categories%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Revenue Categories - Lookup Codes.sql 68520 2018-08-30 07:13:44Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT gmsTERMCATE0.TERM_CATEGORY_NAME RES_CATEGORY_NAME
,gmsTERME0.TERM_NAME  RES_NAME
,gmsTERME0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(gmsTERME0.START_DATE_ACTIVE,'DD-Mon-YYYY')  RES_FROM_DATE
,TO_CHAR(gmsTERME0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE

,gmsTERME0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,gmsTERME0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,gmsTERME0.CREATED_BY RSC_CREATED_BY
,gmsTERME0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GMS_TERM_CATEGORIES_VL gmsTERMCATE0
,GMS_TERMS_VL gmsTERME0
WHERE gmsTERMCATE0.TERM_CATEGORY_ID  = gmsTERME0.TERM_CATEGORY_ID 
ORDER BY gmsTERMCATE0.TERM_CATEGORY_NAME,gmsTERME0.TERM_NAME