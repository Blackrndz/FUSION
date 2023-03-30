/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PartySitePEO.PARTY_SITE_NUMBER RES_PARTY_SITE_NUMBER
,DECODE(ZxPartyTaxProfile.PROCESS_FOR_APPLICABILITY_FLAG,'Y','Yes','No') RES_ALLOW_TAX_APPLICABILITY
,DECODE(ZxPartyTaxProfile.ALLOW_OFFSET_TAX_FLAG,'Y','Yes','No') RES_ALLOW_OFFSET_TAXES
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_ROUNDING_LEVEL'
	AND LOOKUP_CODE   = ZxPartyTaxProfile.ROUNDING_LEVEL_CODE
	) RES_ROUNDING_LEVEL
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_ROUNDING_RULE'
	AND LOOKUP_CODE   = ZxPartyTaxProfile.ROUNDING_RULE_CODE
	) RES_ROUNDING_RULE
,DECODE(ZxPartyTaxProfile.INCLUSIVE_TAX_FLAG,'Y','Yes','N','No') RES_SET_INVOICE_VALUES_AS_TAX_
,ZxPartyTaxProfile.TAX_CLASSIFICATION_CODE RES_TAX_CLASSIFICATION_CODE
,ZxPartyTaxProfile.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxPartyTaxProfile.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxPartyTaxProfile.CREATED_BY RSC_CREATED_BY
,ZxPartyTaxProfile.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
,HZ_PARTIES PartyPEO
,HZ_PARTY_SITES PartySitePEO
WHERE ZxPartyTaxProfile.PARTY_ID      = PartySitePEO.PARTY_SITE_ID
AND PartySitePEO.PARTY_ID             = PartyPEO.PARTY_ID
AND ZxPartyTaxProfile.PARTY_TYPE_CODE = 'THIRD_PARTY_SITE'
AND DECODE(ZxPartyTaxProfile.CUSTOMER_FLAG,'Y',DECODE(ZxPartyTaxProfile.SUPPLIER_FLAG,'Y','SC','C'),DECODE(
	ZxPartyTaxProfile.SUPPLIER_FLAG,'Y','S',NULL)) IS NOT NULL
ORDER BY PartySitePEO.PARTY_SITE_NAME
,PartyPEO.PARTY_NAME