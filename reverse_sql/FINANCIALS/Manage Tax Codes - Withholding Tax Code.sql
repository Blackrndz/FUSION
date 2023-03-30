/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Codes%20-%20Withholding%20Tax%20Code.sql $:
 * $Id: Manage Tax Codes - Withholding Tax Code.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

Select Qrslt.Party_Name Res_Business_Unit
,Qrslt.Territory_Short_Name Res_Country
,Qrslt.Tax_Regime_Code1 RES_TAX_REGIME_CODE
,Qrslt.Tax1 Res_Tax
,Qrslt.Tax_Status_Name Res_Tax_Status_Code
,Qrslt.Tax_Rate_Code1 RES_TAX_RATE_CODE
,Qrslt.Meaning Res_Tax_Rate_Type
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZX_RATE_SCHEDULE_GRP_LVL'
	AND LOOKUP_CODE   =
		(SELECT DISTINCT THRSHLD_SCHEDULE_GRP_LVL_FLAG
		FROM ZX_THREHLDS_SCHDL_CNTRLS_F SCH
		WHERE Sch.Tax                          = Qrslt.Tax1
		AND sch.tax_regime_code                = Qrslt.tax_regime_code1
		AND sch.content_owner_id               = Qrslt.content_owner_id
		and Sch.Tax_Threhlds_Schdl_Cntrl_Code = 'S'
		)
	) Res_Schedule_Basis
,(CASE
	WHEN Qrslt.RATE_TYPE_CODE <> 'PERCENTAGE' THEN
		(SELECT CALENDAR_NAME ||' ' || DESCRIPTION
		FROM AP_OTHER_PERIOD_TYPES
		WHERE CALENDAR_NAME =
			(SELECT DISTINCT calendar_name
			FROM Zx_Threhlds_Schdl_Cntrls_F Sch
			WHERE sch.tax            = Qrslt.tax1
			AND sch.tax_regime_code  = Qrslt.tax_regime_code1
			And Sch.Content_Owner_Id = Qrslt.Content_Owner_Id
			and Sch.Tax_Threhlds_Schdl_Cntrl_Code = 'S'
			)
		AND CALENDAR_TYPE = 'GENERAL')
	END
	) RES_WITHHOLDING_TAX_CALENDAR
,'No' RES_CREATE_TAX_CLASSIFICATION_
,Qrslt.LAST_UPDATED_BY RSC_LAST_UPDATED_BY 
,Qrslt.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Qrslt.CREATED_BY RSC_CREATED_BY
,Qrslt.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT DISTINCT PartyTaxProfileMoacvPEO.PARTY_NAME
	,TerritoryPEO.TERRITORY_SHORT_NAME
	,ZxRatesVl.TAX_REGIME_CODE AS TAX_REGIME_CODE1
	,ZxRatesVl.TAX             AS TAX1
	,ZxRatesVl.TAX_STATUS_CODE
	,ZxRatesVl.RATE_TYPE_CODE
	,ZxRatesVl.TAX_RATE_CODE AS TAX_RATE_CODE1
	,ZxTaxesVl.TAX_ID
	,status.tax_status_name
	,Partytaxprofilemoacvpeo.Bu_Id
	,Lookuppeo.Meaning
	,Zxratesvl.Content_Owner_Id
	,Zxratesvl.Last_Updated_By 
	,Zxratesvl.LAST_UPDATE_DATE
	,Zxratesvl.Created_By
	,Zxratesvl.CREATION_DATE
	FROM ZX_RATES_VL ZxRatesVl
	,ZX_REGIMES_VL ZxRegimesVl
	,ZX_TAXES_VL ZxTaxesVl
	,FND_TERRITORIES_VL TerritoryPEO
	,ZX_FIRST_PARTY_ORGS_MOAC_V
	,FUN_BU_USAGES_V BuUsage
	,ZX_EVNT_CLS_OPTIONS ZxEvntClsOptions
	,ZX_FIRST_PARTY_ORGS_MOAC_V PartyTaxProfileMoacvPEO
	,ZX_JURISDICTIONS_VL ZxJurisdictionsVl
	,Zx_Status_Vl Status
	,Fnd_Lookups Lookuppeo
	WHERE(ZxRatesVl.TAX_REGIME_CODE                  = ZxRegimesVl.TAX_REGIME_CODE(+))
	AND(ZxRatesVl.TAX_REGIME_CODE                    = ZxTaxesVl.TAX_REGIME_CODE(+))
	AND(ZxRatesVl.TAX                                = ZxTaxesVl.TAX(+))
	AND(ZxRatesVl.CONTENT_OWNER_ID                   = ZxTaxesVl.CONTENT_OWNER_ID(+))
	AND(ZxRatesVl.TAX_REGIME_CODE                    = ZxJurisdictionsVl.TAX_REGIME_CODE(+))
	AND(ZxRatesVl.TAX                                = ZxJurisdictionsVl.TAX(+))
	AND(ZxRatesVl.TAX_JURISDICTION_CODE              = ZxJurisdictionsVl.TAX_JURISDICTION_CODE(+))
	AND ZxRegimesVl.REGIME_TYPE_FLAG                 = 'W'
	AND PartyTaxProfileMoacvPEO.PARTY_TAX_PROFILE_ID = ZxRatesVl.CONTENT_OWNER_ID
	AND ZxRegimesVl.COUNTRY_CODE                     = TerritoryPEO.TERRITORY_CODE
	AND ZxRatesVl.ACTIVE_FLAG                        = 'Y'
	AND PartyTaxProfileMoacvPEO.BU_ID               <> - 99
	AND PartyTaxProfileMoacvPEO.BU_ID               <> - 9999
	AND ZxRatesVl.TAX_JURISDICTION_CODE             IS NULL
	AND BuUsage.business_unit_id                     = PartyTaxProfileMoacvPEO.BU_ID
	AND BuUsage.module_key                           = 'PAYABLES_INVOICING_BF'
	AND PartyTaxProfileMoacvPEO.PARTY_TYPE_CODE      = 'OU'
	AND ZxEvntClsOptions.FIRST_PTY_ORG_ID            = PartyTaxProfileMoacvPEO.party_tax_profile_id
	AND ZxEvntClsOptions.EVENT_CLASS_CODE            = 'STANDARD INVOICES'
	AND ZxEvntClsOptions.APPLICATION_ID              = 200
	AND ZxEvntClsOptions.ENTITY_CODE                 = 'AP_INVOICES'
	AND ZxEvntClsOptions.INDIRECT_TAX_OR_WHT_FLAG    = 'W'
	AND ZxEvntClsOptions.ENABLED_FLAG                = 'Y'
	AND ZxEvntClsOptions.DET_FACTOR_TEMPL_CODE       = 'WHTSTCC'
	AND ZxRatesVl.tax_status_code                    = status.tax_status_code
	AND ZxRatesVl.tax                                = status.tax
	AND Zxratesvl.Tax_Regime_Code                    = Status.Tax_Regime_Code
	AND Lookuppeo.Lookup_Type                        = 'ZX_RATE_TYPE'
	And Lookuppeo.Lookup_Code                        = Zxratesvl.Rate_Type_Code
	AND (SYSDATE > ZxRatesVl.EFFECTIVE_FROM
	AND (SYSDATE < ZxRatesVl.EFFECTIVE_TO OR ZxRatesVl.EFFECTIVE_TO IS NULL))
	) Qrslt
order by 1,2,3,4,5,6