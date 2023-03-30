/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=JG_ZZ_VAT_REP_ENTITIES

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
/*'Legal Reporting Unit Tax Profiles' RES_SEARCH_FOR
,(SELECT XleEntityProfiles.LEGAL_ENTITY_IDENTIFIER
	FROM XLE_ENTITY_PROFILES XleEntityProfiles
	,XLE_ETB_PROFILES XleEtbProfiles
	WHERE xleetbprofiles.legal_entity_id          = xleentityprofiles.legal_entity_id
	AND xleentityprofiles.transacting_entity_flag = 'Y'
	AND ZxPartyTaxProfile.PARTY_ID                = XleEtbProfiles.PARTY_ID
	) RES_LEGAL_ENTITY_IDENTIFIER*/
--,ZxPartyTaxProfile.REP_REGISTRATION_NUMBER RES_TAX_REGISTRATION_NUMBER
,ZxPartyTaxRegistration.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,ZxPartyTaxRegistration.TAX RES_TAX
,ZxPartyTaxRegistration.TAX_JURISDICTION_CODE RES_TAX_JURISDICTION_CODE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_TAX_POINT_BASIS'
	AND LOOKUP_CODE = ZxPartyTaxRegistration.TAX_POINT_BASIS
	) RES_TAX_POINT_BASIS
,ZxPartyTaxRegistration.TAX_REGIME_CODE RES_TAX_REGIME_NAME
,ZxPartyTaxRegistration.TAX RES_TAX_NAME
,ZxPartyTaxRegistration.TAX_JURISDICTION_CODE RES_TAX_JURISDICTION_NAME

,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'ZX_REGISTRATIONS_TYPE'
	AND LookupPEO.LOOKUP_CODE   = ZxPartyTaxRegistration.REGISTRATION_TYPE_CODE
	) RES_TAX_REGISTRATION_TYPE
,ZxPartyTaxRegistration.REP_PARTY_TAX_NAME RES_COMPANY_REPORTING_NAME
,hz_format_pub.format_address(ZxPartyTaxRegistration.LEGAL_LOCATION_ID,NULL,NULL,'/',NULL,NULL,NULL,NULL)
	RES_LEGAL_REGISTRATION_ADDRESS
,ZxPartyTaxRegistration.VALIDATION_TYPE RES_VALIDATION_TYPE
,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'ZX_VALIDATION_LEVEL'
	AND LookupPEO.LOOKUP_CODE   = ZxPartyTaxRegistration.VALIDATION_LEVEL
	) RES_VALIDATION_LEVEL
,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'ZX_UNIQUENESS_VALIDATION_LVL'
	AND LookupPEO.LOOKUP_CODE   = ZxPartyTaxRegistration.UNIQUENESS_VALIDATION_LEVEL
	) RES_DUPLICATE_VALIDATION_LEVEL
,ZxPartyTaxRegistration.REGISTRATION_NUMBER RES_REGISTRATION_NUMBER
,IssuingTaxAuthority.PARTY_NAME RES_ISSUING_TAX_AUTHORITY
,DECODE(ZxPartyTaxRegistration.DEFAULT_REGISTRATION_FLAG,'Y','Yes','No') RES_SET_AS_DEFAULT_REGISTRATIO
,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'ZX_REGISTRATIONS_STATUS'
	AND LookupPEO.LOOKUP_CODE   = ZxPartyTaxRegistration.REGISTRATION_STATUS_CODE
	) RES_TAX_REGISTRATION_STATUS
,(SELECT LookupPEO.MEANING
	FROM FND_LOOKUPS LookupPEO
	WHERE LookupPEO.LOOKUP_TYPE = 'ZX_REGISTRATIONS_REASON'
	AND LookupPEO.LOOKUP_CODE   = ZxPartyTaxRegistration.REGISTRATION_REASON_CODE
	) RES_TAX_REGISTRATION_REASON
,TO_CHAR(ZxPartyTaxRegistration.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(ZxPartyTaxRegistration.EFFECTIVE_TO,'DD-Mon-YYYY') RES_END_DATE
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_REGISTRATIONS_SOURCE'
	AND lookup_code   = ZxPartyTaxRegistration.REGISTRATION_SOURCE_CODE
	AND LANGUAGE = USERENV('LANG')
	) RES_SOURCE
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_ROUNDING_RULE'
	AND lookup_code   = zxpartytaxregistration.ROUNDING_RULE_CODE
	AND LANGUAGE = USERENV('LANG')
	) RES_ROUNDING_RULE
,DECODE(zxpartytaxregistration.SELF_ASSESS_FLAG,'Y','Yes','No') RES_SET_AS_SELF_ASSESSMENT_REV
,DECODE(zxpartytaxregistration.INCLUSIVE_TAX_FLAG,'Y','Yes','No') RES_SET_INVOICE_VALUES_AS_TAX_
,(SELECT CollTaxAuthorities.PARTY_NAME
	FROM HZ_PARTIES CollTaxAuthorities
	,ZX_PARTY_TAX_PROFILE ZxPartyTaxProfileColl
	WHERE ZxPartyTaxProfileColl.PARTY_ID             = CollTaxAuthorities.PARTY_ID
	AND zxpartytaxregistration.COLL_TAX_AUTHORITY_ID = ZxPartyTaxProfileColl.PARTY_TAX_PROFILE_ID
	AND ZxPartyTaxProfileColl.PARTY_ID               = CollTaxAuthorities.PARTY_ID
	) RES_COLLECTING_TAX_AUTHORITY
,(SELECT RepTaxAuthorities.PARTY_NAME
	FROM HZ_PARTIES RepTaxAuthorities
	,ZX_PARTY_TAX_PROFILE ZxPartyTaxProfileRep
	WHERE zxpartytaxregistration.REP_TAX_AUTHORITY_ID = ZxPartyTaxProfileRep.PARTY_TAX_PROFILE_ID
	AND ZxPartyTaxProfileRep.PARTY_ID                 = RepTaxAuthorities.PARTY_ID
	) RES_REPORTING_TAX_AUTHORITY
,(SELECT bank_name
	FROM CE_BANKS_V
	WHERE bank_party_id = zxpartytaxregistration.BANK_ID
	) RES_BANK_NAME
/*,(SELECT COUNTRY_NAME
	FROM CE_BANKS_V
	WHERE bank_party_id = zxpartytaxregistration.BANK_ID
	) RES_BANK_COUNTRY*/
,(SELECT bank_branch_name
	FROM CE_BANK_BRANCHES_V
	WHERE branch_party_id = zxpartytaxregistration.BANK_BRANCH_ID
	) RES_BANK_BRANCH_NAME
,(SELECT bank_account_name
	FROM CE_BANK_ACCOUNTS
	WHERE bank_account_id = zxpartytaxregistration.ACCOUNT_ID
	) RES_BANK_ACCOUNT_NAME
,(SELECT DISTINCT TAX_CURRENCY_CODE FROM ZX_TAXES_VL WHERE TAX_REGIME_CODE = zxpartytaxregistration.TAX_REGIME_CODE 
	AND TAX = zxpartytaxregistration.TAX AND SYSDATE BETWEEN EFFECTIVE_FROM AND NVL(EFFECTIVE_TO,TO_DATE('4712/12/31','YYYY/MM/DD'))) RES_TAX_CURRENCY
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_SELF_ASSESS_DIFF_TAX_OPTION'
	AND lookup_code   = zxpartytaxregistration.SELF_ASSESS_FLAG
	--AND SYSDATE BETWEEN EFFECTIVE_FROM AND NVL(EFFECTIVE_TO,TO_DATE('4712/12/31','YYYY/MM/DD'))
	AND LANGUAGE = USERENV('LANG')
	) RES_SELF_ASSESSED_DIFFERENTIAL
,(SELECT DISTINCT SELF_ASSESS_DIFF_TAX FROM ZX_TAXES_VL WHERE TAX_REGIME_CODE = zxpartytaxregistration.TAX_REGIME_CODE 
	AND TAX = zxpartytaxregistration.TAX AND SYSDATE BETWEEN EFFECTIVE_FROM AND NVL(EFFECTIVE_TO,TO_DATE('4712/12/31','YYYY/MM/DD'))) RES_SELF_ASSESSED_DIFFERENTI_0
,(SELECT meaning
	FROM fnd_lookup_values_tl
	WHERE lookup_type = 'ZX_SELF_ASSESS_DIFF_TOL_TYPE'
	AND lookup_code   = zxpartytaxregistration.SELF_ASSESS_DIFF_TOL_LMT_FLAG 
	AND LANGUAGE = USERENV('LANG')
	) RES_DELTA_TOLERANCE_LIMIT_TYPE
,zxpartytaxregistration.MIN_SELF_ASSESS_DIFF_TOL_LIMIT  RES_MINIMUM_DELTA_TOLERANCE_LI
,zxpartytaxregistration.MAX_SELF_ASSESS_DIFF_TOL_LIMIT  RES_MAXIMUM_DELTA_TOLERANCE_LI
,ZxPartyTaxRegistration.TAX_REGIME_CODE RES_REGIME_CODE
,TO_CHAR(CommonConf.START_DATE,'DD-Mon-YYYY')  RES_TAX_REPORTING_CONFIGURATIO
,TO_CHAR(CommonConf.END_DATE,'DD-Mon-YYYY')  RES_TAX_REPORTING_CONFIGURAT_1
,CommonConf.TAX_CALENDAR_NAME RES_TAX_CALENDAR
,CommonConf.THRESHOLD_AMOUNT RES_THRESHOLD_AMOUNT
,DECODE(CommonConf.ENABLE_REGISTERS_FLAG,'Y','Yes','No') RES_ENABLE_TAX_REGISTERS
,DECODE(CommonConf.ENABLE_REPORT_SEQUENCE_FLAG,'Y','Yes','No') RES_ENABLE_REPORTING_SEQUENCE
,DECODE(CommonConf.ENABLE_ALLOCATIONS_FLAG,'Y','Yes','No') RES_ENABLE_ALLOCATION
,DECODE(CommonConf.ENABLE_FINAL_DATA_VALIDATION,'Y','Yes','No') RES_ENABLE_FINAL_DATA_VALIDATI
,DECODE(CommonConf.ENABLE_SWEEP_PROCESS_FLAG,'Y','Yes','No') RES_ENABLE_SWEEP_PROCESS


,zxpartytaxregistration.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,zxpartytaxregistration.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,zxpartytaxregistration.CREATED_BY RSC_CREATED_BY
,zxpartytaxregistration.CREATION_DATE RSC_CREATION_DATE
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
,HZ_PARTIES PartyPEO
,(SELECT ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID
	,PTY.PARTY_NAME
	FROM ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
	,HZ_PARTIES PTY
	,FND_LOOKUPS Lkup
	WHERE ZxPartyTaxProfile.PARTY_TYPE_CODE = 'TAX_AUTHORITY'
	AND ZxPartyTaxProfile.PARTY_ID          = PTY.PARTY_ID
	AND Lkup.LOOKUP_TYPE                    = 'ZX_AUTH_CLASSIF'
	AND Lkup.LOOKUP_CODE                    =(DECODE(ZxPartyTaxProfile.COLLECTING_AUTHORITY_FLAG,'Y','C') || DECODE(
		ZxPartyTaxProfile.REPORTING_AUTHORITY_FLAG,'Y','R'))
	) IssuingTaxAuthority
,(SELECT ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID
	,PTY.PARTY_NAME
	FROM ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
	,HZ_PARTIES PTY
	,FND_LOOKUPS Lkup
	WHERE ZxPartyTaxProfile.PARTY_TYPE_CODE = 'TAX_AUTHORITY'
	AND ZxPartyTaxProfile.PARTY_ID          = PTY.PARTY_ID
	AND Lkup.LOOKUP_TYPE                    = 'ZX_AUTH_CLASSIF'
	AND Lkup.LOOKUP_CODE                    =(DECODE(ZxPartyTaxProfile.COLLECTING_AUTHORITY_FLAG,'Y','C') || DECODE(
		ZxPartyTaxProfile.REPORTING_AUTHORITY_FLAG,'Y','R'))
	) ReportingTaxAuthority
,(SELECT ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID
	,PTY.PARTY_NAME
	FROM ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
	,HZ_PARTIES PTY
	,FND_LOOKUPS Lkup
	WHERE ZxPartyTaxProfile.PARTY_TYPE_CODE = 'TAX_AUTHORITY'
	AND ZxPartyTaxProfile.PARTY_ID          = PTY.PARTY_ID
	AND Lkup.LOOKUP_TYPE                    = 'ZX_AUTH_CLASSIF'
	AND Lkup.LOOKUP_CODE                    =(DECODE(ZxPartyTaxProfile.COLLECTING_AUTHORITY_FLAG,'Y','C') || DECODE(
		ZxPartyTaxProfile.REPORTING_AUTHORITY_FLAG,'Y','R'))
	) CollectingTaxAuthority
,JG_ZZ_VAT_REP_ENTITIES CommonConf
WHERE ZxPartyTaxProfile.PARTY_TYPE_CODE          = 'LEGAL_ESTABLISHMENT'
AND ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID       = ZxPartyTaxRegistration.PARTY_TAX_PROFILE_ID
AND zxpartytaxregistration.TAX_AUTHORITY_ID      = IssuingTaxAuthority.PARTY_TAX_PROFILE_ID(+)
AND zxpartytaxregistration.REP_TAX_AUTHORITY_ID  = ReportingTaxAuthority.PARTY_TAX_PROFILE_ID(+)
AND zxpartytaxregistration.COLL_TAX_AUTHORITY_ID = CollectingTaxAuthority.PARTY_TAX_PROFILE_ID(+)
AND ZxPartyTaxProfile.PARTY_ID                   = PartyPEO.PARTY_ID
AND(((((SELECT NVL(ZxRegimesVl.Regime_type_flag,'I')
	FROM ZX_REGIMES_VL ZxRegimesVl
	WHERE ZxPartyTaxRegistration.TAX_REGIME_CODE = ZxRegimesVl.TAX_REGIME_CODE
	AND rownum                                   = 1)) = 'I')))
AND ZxPartyTaxProfile.PARTY_ID = CommonConf.PARTY_ID(+)
AND ZxPartyTaxRegistration.TAX_REGIME_CODE = CommonConf.TAX_REGIME_CODE(+)
ORDER BY RES_LEGAL_REPORTING_UNIT