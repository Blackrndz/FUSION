/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=ZX_PARTY_TAX_PROFILE

SELECT XleEntityProfiles.NAME RES_LEGAL_ENTITY
,DECODE(LegalEntityTaxProfileEO.TAX_GROSS_NET_FLAG,'G','Yes','No')  RES_USE_GROSS_AMOUNT_FOR_PAYAB
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_ROUNDING_LEVEL'
	AND LOOKUP_CODE   = LegalEntityTaxProfileEO.ROUNDING_LEVEL_CODE
	) RES_ROUNDING_LEVEL
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_ROUNDING_RULE'
	AND LOOKUP_CODE   = LegalEntityTaxProfileEO.ROUNDING_RULE_CODE
	) RES_ROUNDING_RULE
,DECODE(LegalEntityTaxProfileEO.INCLUSIVE_TAX_FLAG,'Y','Yes','N','No') RES_SET_INVOICE_VALUES_AS_TAX_
,LegalEntityTaxProfileEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,LegalEntityTaxProfileEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,LegalEntityTaxProfileEO.CREATED_BY RSC_CREATED_BY
,LegalEntityTaxProfileEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,XleEntityProfiles.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM XLE_REGISTRATIONS XleRegistrations
,XLE_ENTITY_PROFILES XleEntityProfiles
,ZX_PARTY_TAX_PROFILE LegalEntityTaxProfileEO
,XLE_LOCATIONS_V LocationDPEO
WHERE XleEntityProfiles.legal_entity_id = XleRegistrations.source_id
AND XleRegistrations.source_table       = 'XLE_ENTITY_PROFILES'
AND XleRegistrations.identifying_flag   = 'Y'
AND XleEntityProfiles.PARTY_ID          = LegalEntityTaxProfileEO.PARTY_ID
AND xleregistrations.location_id        = locationdpeo.location_id
AND (LegalEntityTaxProfileEO.TAX_GROSS_NET_FLAG IS NOT NULL
OR LegalEntityTaxProfileEO.ROUNDING_LEVEL_CODE IS NOT NULL
OR LegalEntityTaxProfileEO.ROUNDING_RULE_CODE IS NOT NULL
OR LegalEntityTaxProfileEO.INCLUSIVE_TAX_FLAG IS NOT NULL)
ORDER BY UPPER(XleEntityProfiles.NAME)