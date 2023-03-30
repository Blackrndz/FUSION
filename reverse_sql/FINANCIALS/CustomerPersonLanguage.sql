/* ****************************************************************************
 * $Revision: 56649 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-07-12 11:20:44 +0700 (Tue, 12 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Currency%20Rates%20Manager%20-%20Rate%20Types.sql $:
 * $Id: Currency Rates Manager - Rate Types.sql 56649 2016-07-12 04:20:44Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- STRICTLY_BATCH_SEQ = RES_PARTY_ORIGINAL_SYSTEM_REFE,RES_LANGUAGE_NAME

SELECT '' RES_BATCH_IDENTIFIER
,'CUSTOMER' RES_PARTY_ORIGINAL_SYSTEM
,HzPartiesE0.PARTY_NUMBER RES_PARTY_ORIGINAL_SYSTEM_REFE
,HzPersonLanguage.LANGUAGE_NAME RES_LANGUAGE_NAME
,HzPersonLanguage.NATIVE_LANGUAGE_FLAG RES_NATIVE_LANGUAGE_INDICATOR
,HzPersonLanguage.PRIMARY_LANGUAGE_INDICATOR RES_PRIMARY_LANGUAGE_INDICATOR
,HzPersonLanguage.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,HzPersonLanguage.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,HzPersonLanguage.CREATED_BY RSC_CREATED_BY
,HzPersonLanguage.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_PARTIES HzPartiesE0
,HZ_PARTY_USG_ASSIGNMENTS HzPartyUsgAssignmentsE0
,HZ_PERSON_LANGUAGE HzPersonLanguage
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartyUsgAssignmentsE0.PARTY_USAGE_CODE  = 'CUSTOMER'
AND HzPartiesE0.PARTY_ID = HzPersonLanguage.PARTY_ID