/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PartySitePEO.PARTY_SITE_NAME RES_PARTY_SITE_NAME
,PartySitePEO.PARTY_SITE_NUMBER RES_PARTY_SITE_NUMBER
,PartyPEO.PARTY_NAME RES_PARTY_NAME
,PartyPEO.PARTY_NUMBER RES_PARTY_NUMBER
,SUBSTR(DECODE(NVL(ZxPartyTaxProfile.SUPPLIER_FLAG,''),'Y',' and Supplier','',(SELECT ' and Supplier'
	FROM HZ_PARTY_USG_ASSIGNMENTS hpua
	WHERE hpua.party_id       = ZxPartyTaxProfile.party_id
	AND hpua.party_usage_code = 'SUPPLIER'
	AND TRUNC(SYSDATE) BETWEEN hpua.effective_start_date AND NVL(hpua.effective_end_date,TRUNC(SYSDATE) + 1)
	AND hpua.status_flag = 'A'
	AND rownum           = 1
	)) || DECODE(NVL(ZxPartyTaxProfile.CUSTOMER_FLAG,''),'Y',' and Customer','',(SELECT ' and Customer'
	FROM HZ_PARTY_USG_ASSIGNMENTS hpua
	WHERE hpua.party_id       = ZxPartyTaxProfile.party_id
	AND hpua.party_usage_code = 'CUSTOMER'
	AND TRUNC(SYSDATE) BETWEEN hpua.effective_start_date AND NVL(hpua.effective_end_date,TRUNC(SYSDATE) + 1)
	AND hpua.status_flag = 'A'
	AND rownum           = 1
	)) ||
	(SELECT ' and Bank'
	FROM HZ_PARTY_USG_ASSIGNMENTS hpua
	WHERE hpua.party_id       = ZxPartyTaxProfile.party_id
	AND hpua.party_usage_code = 'BANK'
	AND TRUNC(SYSDATE) BETWEEN hpua.effective_start_date AND NVL(hpua.effective_end_date,TRUNC(SYSDATE) + 1)
	AND hpua.status_flag = 'A'
	AND rownum           = 1
	),6) RES_PARTY_USAGE
,LocationPEO.ADDRESS1 || ',' || LocationPEO.ADDRESS2 || ',' || LocationPEO.ADDRESS3 || ',' ||LocationPEO.CITY || ',' ||
	LocationPEO.postal_code || ',' ||
	(SELECT TerritoriesPEO.TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_VL TerritoriesPEO
	WHERE LocationPEO.Country = TerritoriesPEO.TERRITORY_CODE
	) RES_ADDRESS
,(SELECT TerritoriesPEO.TERRITORY_SHORT_NAME
	FROM FND_TERRITORIES_VL TerritoriesPEO
	WHERE LocationPEO.Country = TerritoriesPEO.TERRITORY_CODE
	) RES_COUNTRY
,PartySitePEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PartySitePEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PartySitePEO.CREATED_BY RSC_CREATED_BY
,PartySitePEO.CREATION_DATE RSC_CREATION_DATE
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
,HZ_LOCATIONS LocationPEO
WHERE ZxPartyTaxProfile.party_id      = PartySitePEO.party_site_id
AND PartySitePEO.PARTY_ID             = PartyPEO.PARTY_ID
AND PartySitePEO.LOCATION_ID          = LocationPEO.LOCATION_ID
AND ZxPartyTaxProfile.party_type_code = 'THIRD_PARTY_SITE'
AND DECODE(ZxPartyTaxProfile.CUSTOMER_FLAG,'Y',DECODE(ZxPartyTaxProfile.SUPPLIER_FLAG,'Y','SC','C'),DECODE(
	ZxPartyTaxProfile.SUPPLIER_FLAG,'Y','S',NULL)) IS NOT NULL
ORDER BY PartySitePEO.PARTY_SITE_NAME
,PartyPEO.PARTY_NAME
,RES_COUNTRY