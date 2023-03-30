/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Codes%20-%20Rate%20Schedules.sql $:
 * $Id: Manage Tax Codes - Rate Schedules.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
 
SELECT TAX_C.Party_Name RES_BUSINESS_UNIT
,Tax_C.Territory_Short_Name RES_COUNTRY
,TAX_C.Tax_Regime_Code1 RES_TAX_REGIME_CODE
,Tax_C.Tax1 RES_TAX
,Tax_C.Tax_Rate_Code1 RES_TAX_RATE_CODE
,Zxratesvl.Percentage_Rate RES_RATE_PERCENTAGE
,TO_CHAR(Zxratesvl.Default_Flg_Effective_From,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,Taxratescheduleseo.Start_Taxable_Amt RES_FROM_AMOUNT
,Taxratescheduleseo.End_Taxable_Amt RES_TO_AMOUNT
,TaxRateSchedulesEO.PERCENTAGE_RATE RES_RATE_SCHEDULES_RATE_PERCEN
,TaxRateSchedulesEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,TaxRateSchedulesEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,TaxRateSchedulesEO.CREATED_BY RSC_CREATED_BY
,TaxRateSchedulesEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Zx_Rates_Vl Zxratesvl
,ZX_RATE_SCHEDULES_F TaxRateSchedulesEO
,(SELECT DISTINCT PartyTaxProfileMoacvPEO.PARTY_NAME
	,TerritoryPEO.TERRITORY_SHORT_NAME
	,ZxRatesVl.TAX_REGIME_CODE AS TAX_REGIME_CODE1
	,Zxratesvl.Tax             AS Tax1
	,ZxRatesVl.TAX_RATE_CODE   AS TAX_RATE_CODE1
	,Zxratesvl.Content_Owner_Id
	,PartyTaxProfileMoacvPEO.BU_ID
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
	WHERE ZxRatesVl.RATE_TYPE_CODE                  IN('GROSS_AMT_SCHEDULE_RATE','WITHHELD_AMT_SCHEDULE_RATE')
	AND(ZxRatesVl.TAX_REGIME_CODE                    = ZxRegimesVl.TAX_REGIME_CODE(+))
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
	AND Lookuppeo.LOOKUP_CODE                        = ZxRatesVl.RATE_TYPE_CODE
	) TAX_C
WHERE(((ZxRatesVl.CONTENT_OWNER_ID          = TAX_C.Content_Owner_Id)
AND(UPPER(ZxRatesVl.TAX)                    = UPPER(TAX_C.TAX1))
AND(UPPER(ZxRatesVl.TAX_JURISDICTION_CODE) IS NULL)
AND(Upper(Zxratesvl.Tax_Rate_Code)          = Upper(Tax_C.Tax_Rate_Code1)))
AND Zxratesvl.TAX_RATE_ID                   = TaxRateSchedulesEO.TAX_RATE_ID)
ORDER BY 1,2,3,4,5,6