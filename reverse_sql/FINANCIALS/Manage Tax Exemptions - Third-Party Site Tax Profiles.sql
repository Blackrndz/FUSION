/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT PartySitePEO.PARTY_SITE_NAME RES_PARTY_SITE_NAME
,PartySitePEO.PARTY_SITE_NUMBER RES_PARTY_SITE_NUMBER
,(SELECT PartyPEO.PARTY_NAME
	FROM HZ_PARTIES PartyPEO
	WHERE ZxPartyTaxProfile.party_id = PartySitePEO.party_site_id
	AND PartySitePEO.PARTY_ID        = PartyPEO.PARTY_ID
	) RES_PARTY_NAME
,(SELECT PartyPEO.PARTY_NUMBER
	FROM HZ_PARTIES PartyPEO
	WHERE ZxPartyTaxProfile.party_id = PartySitePEO.party_site_id
	AND PartySitePEO.PARTY_ID        = PartyPEO.PARTY_ID
	AND rownum                       = 1
	) RES_PARTY_NUMBER
,(SELECT PartyPEO.PARTY_TYPE
	FROM HZ_PARTIES PartyPEO
	WHERE ZxPartyTaxProfile.party_id = PartySitePEO.party_site_id
	AND PartySitePEO.PARTY_ID        = PartyPEO.PARTY_ID
	AND rownum                       = 1
	) RES_TYPE
,(SELECT ZxPartyTaxProfile.REP_REGISTRATION_NUMBER
	FROM ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile 
    WHERE ZxPartyTaxProfile.party_id = PartySitePEO.PARTY_SITE_ID
   ) RES_TAX_REGISTRATION_NUMBER
,(SELECT TerritoriesPEO.TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_VL TerritoriesPEO
	,HZ_LOCATIONS LocationPEO
	WHERE LocationPEO.Country      = TerritoriesPEO.TERRITORY_CODE
	AND PartySitePEO.LOCATION_ID   = LocationPEO.LOCATION_ID
	)  RES_COUNTRY

,ZxExemptions.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxExemptions.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxExemptions.CREATED_BY RSC_CREATED_BY
,ZxExemptions.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_EXEMPTIONS ZxExemptions
,ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
,HZ_PARTY_SITES PartySitePEO
,ZX_PARTY_TAXPAYER_IDNTFS TaxPayerIdentifierEO
WHERE ZxExemptions.PARTY_TAX_PROFILE_ID  = ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID
AND ZxPartyTaxProfile.PARTY_ID = PartySitePEO.party_site_id
AND ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID = TaxPayerIdentifierEO.ENTITY_ID (+)
AND ZxExemptions.RECORD_TYPE_CODE IN ('USER_DEFINED','MIGRATED')
AND ZxPartyTaxProfile.PARTY_TYPE_CODE     = 'THIRD_PARTY_SITE'
ORDER BY RES_PARTY_NAME