/* ****************************************************************************
 * $Revision: 78958 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-07-08 10:47:52 +0700 (Fri, 08 Jul 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Bank%20Statement%20Transaction%20Codes%20-%20Bank%20Statement%20Transaction%20Codes.sql $:
 * $Id: Manage Bank Statement Transaction Codes - Bank Statement Transaction Codes.sql 78958 2022-07-08 03:47:52Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


SELECT BANKTRANSACTIONCODESEO.TRX_CODE RES_TRANSACTION_CODE
,regexp_replace(BANKTRANSACTIONCODESEO.DESCRIPTION,'[[:space:]]',' ') RES_DESCRIPTION
,CeLookupPEO.MEANING RES_TRANSACTION_TYPE
,BankTransactionCodesEO.DOMAIN||' '||DomainCeLookupPEO.MEANING RES_DOMAIN
,BankTransactionCodesEO.FAMILY||' '||FAMILYCELOOKUPPEO.MEANING RES_FAMILY
,BankTransactionCodesEO.SUB_FAMILY||' '||SubFamilyCeLookupPEO.MEANING RES_SUB_FAMILY
,BANKTRANSACTIONCODESEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,BANKTRANSACTIONCODESEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,BANKTRANSACTIONCODESEO.CREATED_BY RSC_CREATED_BY
,BANKTRANSACTIONCODESEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_TRANSACTION_CODES BankTransactionCodesEO
,CE_LOOKUPS CeLookupPEO
,CE_LOOKUPS DomainCeLookupPEO
,CE_LOOKUPS FamilyCeLookupPEO
,CE_LOOKUPS SubFamilyCeLookupPEO
WHERE BankTransactionCodesEO.TRX_TYPE   = CeLookupPEO.LOOKUP_CODE(+)
AND CeLookupPEO.LOOKUP_TYPE             = 'CE_TRX_TYPE'
AND BankTransactionCodesEO.DOMAIN       = DomainCeLookupPEO.LOOKUP_CODE(+)
AND DomainCeLookupPEO.LOOKUP_TYPE(+)    = 'CE_DOMAIN'
AND BankTransactionCodesEO.FAMILY       = FamilyCeLookupPEO.LOOKUP_CODE(+)
AND FamilyCeLookupPEO.LOOKUP_TYPE(+)    = 'CE_FAMILY'
AND BankTransactionCodesEO.SUB_FAMILY   = SubFamilyCeLookupPEO.LOOKUP_CODE(+)
AND SubFamilyCeLookupPEO.LOOKUP_TYPE(+) = 'CE_SUBFAMILY'
ORDER BY TRX_CODE