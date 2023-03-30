/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PartyPEO.PARTY_NAME RES_PARTY_NAME
,PartyPEO.PARTY_NUMBER RES_PARTY_NUMBER
,DECODE(ThirdPartyTaxProfileEO.PROCESS_FOR_APPLICABILITY_FLAG,'Y','Yes','No') RES_ALLOW_TAX_APPLICABILITY
,DECODE(ThirdPartyTaxProfileEO.ALLOW_OFFSET_TAX_FLAG,'Y','Yes','No') RES_ALLOW_OFFSET_TAXES
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_ROUNDING_LEVEL'
	AND LOOKUP_CODE   = ThirdPartyTaxProfileEO.ROUNDING_LEVEL_CODE
	) RES_ROUNDING_LEVEL
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_ROUNDING_RULE'
	AND LOOKUP_CODE   = ThirdPartyTaxProfileEO.ROUNDING_RULE_CODE
	) RES_ROUNDING_RULE
,DECODE(ThirdPartyTaxProfileEO.INCLUSIVE_TAX_FLAG,'Y','Yes','N','No') RES_SET_INVOICE_VALUES_AS_TAX_
,ThirdPartyTaxProfileEO.TAX_CLASSIFICATION_CODE RES_TAX_CLASSIFICATION_CODE
,ThirdPartyTaxProfileEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ThirdPartyTaxProfileEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ThirdPartyTaxProfileEO.CREATED_BY RSC_CREATED_BY
,ThirdPartyTaxProfileEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAX_PROFILE ThirdPartyTaxProfileEO
,HZ_PARTIES PartyPEO
WHERE ThirdPartyTaxProfileEO.PARTY_ID      = PartyPEO.PARTY_ID
AND ThirdPartyTaxProfileEO.PARTY_TYPE_CODE = 'THIRD_PARTY'
ORDER BY PartyPEO.PARTY_NAME