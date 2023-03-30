/* ****************************************************************************
 * $Revision: 59683 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-11-22 10:55:17 +0700 (Tue, 22 Nov 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Mapping%20Sets%20-%20Cost%20Management%20(Chart%20of%20Accounts%20Mappings).sql $:
 * $Id: Manage Mapping Sets - Cost Management (Chart of Accounts Mappings).sql 59683 2016-11-22 03:55:17Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT XleEtbProfiles.NAME RES_LEGAL_REPORTING_UNIT
,XleEntityProfiles.NAME RES_LEGAL_ENTITY
,PartyTaxProfileEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PartyTaxProfileEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PartyTaxProfileEO.CREATED_BY RSC_CREATED_BY
,PartyTaxProfileEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,XleEntityProfiles.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAX_PROFILE PartyTaxProfileEO
,XLE_ETB_PROFILES XleEtbProfiles
,XLE_ENTITY_PROFILES XleEntityProfiles
,XLE_REGISTRATIONS XleRegistrations
,XLE_LOCATIONS_V LocationDPEO
WHERE xleetbprofiles.legal_entity_id           = xleentityprofiles.legal_entity_id
AND xleentityprofiles.transacting_entity_flag = 'Y'
AND xleetbprofiles.establishment_id           = xleregistrations.source_id
AND xleregistrations.source_table             = 'XLE_ETB_PROFILES'
AND xleregistrations.identifying_flag         = 'Y'
AND xleregistrations.location_id              = locationdpeo.location_id
AND PartyTaxProfileEO.PARTY_ID                = XleEtbProfiles.PARTY_ID
AND PartyTaxProfileEO.PARTY_TYPE_CODE         = 'LEGAL_ESTABLISHMENT'
AND (EXISTS (SELECT 1 
		FROM ZX_REPORT_CODES_ASSOC 
		WHERE ENTITY_ID = PartyTaxProfileEO.PARTY_TAX_PROFILE_ID)
	OR EXISTS (SELECT 1 
		FROM HZ_CODE_ASSIGNMENTS 
		WHERE OWNER_TABLE_NAME = 'ZX_PARTY_TAX_PROFILE'
		AND OWNER_TABLE_ID = PartyTaxProfileEO.PARTY_TAX_PROFILE_ID)
	OR (PartyTaxProfileEO.ROUNDING_LEVEL_CODE IS NOT NULL
		OR PartyTaxProfileEO.ROUNDING_RULE_CODE IS NOT NULL
		OR PartyTaxProfileEO.INCLUSIVE_TAX_FLAG IS NOT NULL
		OR PartyTaxProfileEO.TAX_CLASSIFICATION_CODE IS NOT NULL))
ORDER BY UPPER(XleEtbProfiles.NAME)