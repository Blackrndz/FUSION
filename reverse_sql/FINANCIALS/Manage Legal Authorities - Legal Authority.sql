/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PartyPEO.PARTY_NAME RES_NAME
,PartyPEO.PARTY_NUMBER RES_ORGANIZATION_NUMBER
,(
	CASE
		WHEN ZxPartyTaxProfile.REPORTING_AUTHORITY_FLAG = 'Y'
		AND ZxPartyTaxProfile.COLLECTING_AUTHORITY_FLAG = 'Y'
		THEN 'Collecting and reporting'
		WHEN ZxPartyTaxProfile.REPORTING_AUTHORITY_FLAG = 'Y'
		AND ZxPartyTaxProfile.COLLECTING_AUTHORITY_FLAG = 'N'
		THEN 'Reporting'
		WHEN ZxPartyTaxProfile.REPORTING_AUTHORITY_FLAG = 'N'
		AND ZxPartyTaxProfile.COLLECTING_AUTHORITY_FLAG = 'Y'
		THEN 'Collecting'
	END) RES_TAX_AUTHORITY_TYPE
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

FROM HZ_PARTY_SITES PartySitePEO
,HZ_ORGANIZATION_PROFILES OrganizationPEO
,HZ_GEOGRAPHIES GeographyPEO
,HZ_PARTIES PartyPEO
,FND_TERRITORIES_VL TerritoryPEO
,HZ_PARTY_USG_ASSIGNMENTS PartyUsageAssignmentPEO
,HZ_LOCATIONS LocationPEO
,ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
WHERE((PartyUsageAssignmentPEO.PARTY_ID                               = partypeo.party_id)
AND(PartyUsageAssignmentPEO.party_usage_code                          = 'LEGAL_AUTHORITY')
AND(locationpeo.location_id(+)                                        = partysitepeo.location_id)
AND(partypeo.party_id                                                 = partysitepeo.party_id(+))
AND(partypeo.party_id                                                 = organizationpeo.party_id)
AND(organizationpeo.effective_start_date                             <= sysdate
AND organizationpeo.effective_end_date                                > sysdate)
AND(geographypeo.geography_code                                       = territorypeo.territory_code(+))
AND(geographypeo.geography_code(+)                                    = locationpeo.country)
AND(geographypeo.geography_type(+)                                    = 'COUNTRY')
AND(PartySitePEO.IDENTIFYING_ADDRESS_FLAG(+)                          = 'Y')
AND NVL(PartySitePEO.STATUS(+),'A')                                   = 'A'
AND NVL(TRUNC(PartySitePEO.START_DATE_ACTIVE(+)),TRUNC(SYSDATE))     <= TRUNC(SYSDATE)
AND NVL(TRUNC(PartySitePEO.END_DATE_ACTIVE(+)),TRUNC(SYSDATE) + 1)    > TRUNC(SYSDATE)
AND NVL(organizationpeo.STATUS,'A')                                   = 'A'
AND NVL(TRUNC(organizationpeo.EFFECTIVE_START_DATE),TRUNC(SYSDATE))  <= TRUNC(SYSDATE)
AND NVL(TRUNC(organizationpeo.EFFECTIVE_END_DATE),TRUNC(SYSDATE) + 1) > TRUNC(SYSDATE))
AND PartyPEO.PARTY_ID                                                 = ZxPartyTaxProfile.PARTY_ID
--AND LocationPEO.COUNTRY                                               = 'US'
ORDER BY PartyPEO.PARTY_NAME