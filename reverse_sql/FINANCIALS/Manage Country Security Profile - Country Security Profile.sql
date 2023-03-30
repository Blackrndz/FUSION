/* ****************************************************************************
 * $Revision: 72808 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-11-01 10:55:49 +0700 (Fri, 01 Nov 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Workforce%20Profile%20Lookups%20-%20Lookup%20Codes.sql $:
 * $Id: Manage Workforce Profile Lookups - Lookup Codes.sql 72808 2019-11-01 03:55:49Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT countrySecProfsE0.NAME RES_NAME
,DECODE(countrySecProfsE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,DECODE(countrySecProfsE0.VIEW_ALL,'Y','Yes','No') RES_VIEW_ALL
,countrySecProfsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,countrySecProfsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,countrySecProfsE0.CREATED_BY RSC_CREATED_BY
,countrySecProfsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_COUNTRY_SECURITY_PROFILES countrySecProfsE0
ORDER BY countrySecProfsE0.NAME