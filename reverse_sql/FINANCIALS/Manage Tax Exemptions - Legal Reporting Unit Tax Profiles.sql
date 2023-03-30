/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT (SELECT XleEtbProfiles.Name
	FROM XLE_ETB_PROFILES XleEtbProfiles
	WHERE ZxPartyTaxProfile.PARTY_ID = XleEtbProfiles.PARTY_ID
	) RES_LEGAL_REPORTING_UNIT
,(SELECT XleEntityProfiles.NAME
	FROM XLE_ENTITY_PROFILES XleEntityProfiles
	,XLE_ETB_PROFILES XleEtbProfiles
	WHERE xleetbprofiles.legal_entity_id          = xleentityprofiles.legal_entity_id
	AND xleentityprofiles.transacting_entity_flag = 'Y'
	AND ZxPartyTaxProfile.PARTY_ID                = XleEtbProfiles.PARTY_ID
	) RES_LEGAL_ENTITY
,(SELECT REGISTRATION_NUMBER
	FROM XLE_REGISTRATIONS
	WHERE SOURCE_TABLE = 'XLE_ETB_PROFILES'
	AND IDENTIFYING_FLAG = 'Y'
	AND SOURCE_ID     IN
		(SELECT ESTABLISHMENT_ID
		FROM XLE_ETB_PROFILES XleEtbProfiles
		,fusion.XLE_ENTITY_PROFILES XleEntityProfiles
		WHERE XleEtbProfiles.LEGAL_ENTITY_ID = xleentityprofiles.legal_entity_id
		AND XleEtbProfiles.GEOGRAPHY_ID      = xleentityprofiles.GEOGRAPHY_ID
		AND ZxPartyTaxProfile.PARTY_ID   = XleEtbProfiles.PARTY_ID
		AND MAIN_ESTABLISHMENT_FLAG = 'Y'
		AND SYSDATE < NVL(MAIN_EFFECTIVE_TO,TO_DATE('31-12-4712','DD-MM-YYYY'))
		)
	) RES_TAX_REGISTRATION_NUMBER

,ZxExemptions.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ZxExemptions.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ZxExemptions.CREATED_BY RSC_CREATED_BY
,ZxExemptions.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,(SELECT xleentityprofiles.legal_entity_id
	FROM XLE_ENTITY_PROFILES XleEntityProfiles
	,XLE_ETB_PROFILES XleEtbProfiles
	WHERE xleetbprofiles.legal_entity_id          = xleentityprofiles.legal_entity_id
	AND xleentityprofiles.transacting_entity_flag = 'Y'
	AND ZxPartyTaxProfile.PARTY_ID                = XleEtbProfiles.PARTY_ID
	) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_EXEMPTIONS ZxExemptions
,zx_regimes_vl RegimesVL
,ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
WHERE ZxExemptions.PARTY_TAX_PROFILE_ID     = ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID(+)
AND ZxExemptions.TAX_REGIME_CODE          = RegimesVL.TAX_REGIME_CODE (+)
AND ZxExemptions.RECORD_TYPE_CODE        IN('USER_DEFINED','MIGRATED')
AND REGIME_TYPE_FLAG                      = 'W'
AND ZxPartyTaxProfile.PARTY_TYPE_CODE     = 'LEGAL_ESTABLISHMENT'
ORDER BY RES_LEGAL_REPORTING_UNIT