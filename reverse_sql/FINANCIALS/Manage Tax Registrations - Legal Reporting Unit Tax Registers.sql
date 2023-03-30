/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT (SELECT XleEntityProfiles.NAME
	FROM XLE_ENTITY_PROFILES XleEntityProfiles
	,XLE_ETB_PROFILES XleEtbProfiles
	WHERE xleetbprofiles.legal_entity_id          = xleentityprofiles.legal_entity_id
	AND xleentityprofiles.transacting_entity_flag = 'Y'
	AND ZxPartyTaxProfile.PARTY_ID                = XleEtbProfiles.PARTY_ID
	) RES_LEGAL_ENTITY
,(SELECT XleEtbProfiles.Name
	FROM XLE_ETB_PROFILES XleEtbProfiles
	WHERE ZxPartyTaxProfile.PARTY_ID = XleEtbProfiles.PARTY_ID
	) RES_LEGAL_REPORTING_UNIT
/*,ZxPartyTaxProfile.REP_REGISTRATION_NUMBER RES_TAX_REGISTRATION_NUMBER
,ZxPartyTaxRegistration.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,ZxPartyTaxRegistration.REGISTRATION_NUMBER RES_REGISTRATION_NUMBER*/
,(SELECT MEANING
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'JGZZ_VAT_REGISTER_TYPES'
	AND lookup_code   = VATRegister.REGISTER_TYPE
	AND LANGUAGE = USERENV('LANG')
	) RES_REGISTER_TYPE
,VATRegisterName.REGISTER_NAME RES_NAME
,TO_CHAR(VATRegister.EFFECTIVE_FROM_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(VATRegister.EFFECTIVE_TO_DATE,'DD-Mon-YYYY') RES_END_DATE
,VATRegister.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,VATRegister.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,VATRegister.CREATED_BY RSC_CREATED_BY
,VATRegister.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,(SELECT LEGAL_ENTITY_ID
	FROM XLE_ETB_PROFILES
	WHERE PARTY_ID = ZxPartyTaxProfile.PARTY_ID
	) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
,ZX_REGISTRATIONS ZxPartyTaxRegistration
,JG_ZZ_VAT_REP_ENTITIES CommonConf
,JG_ZZ_VAT_REGISTERS_TL VATRegisterName
,JG_ZZ_VAT_REGISTERS_B VATRegister
,HZ_PARTIES PartyPEO
WHERE ZxPartyTaxProfile.PARTY_TYPE_CODE        = 'LEGAL_ESTABLISHMENT'
AND ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID     = ZxPartyTaxRegistration.PARTY_TAX_PROFILE_ID
AND ZxPartyTaxProfile.PARTY_ID                 = PartyPEO.PARTY_ID
AND ZxPartyTaxProfile.PARTY_ID                 = CommonConf.PARTY_ID
AND ZxPartyTaxRegistration.TAX_REGIME_CODE     = CommonConf.TAX_REGIME_CODE
AND ZxPartyTaxRegistration.REGISTRATION_NUMBER = CommonConf.TAX_REGISTRATION_NUMBER
AND CommonConf.VAT_REPORTING_ENTITY_ID         = VATRegister.VAT_REPORTING_ENTITY_ID
AND VATRegister.VAT_REGISTER_ID                = VATRegisterName.VAT_REGISTER_ID
ORDER BY RES_LEGAL_REPORTING_UNIT