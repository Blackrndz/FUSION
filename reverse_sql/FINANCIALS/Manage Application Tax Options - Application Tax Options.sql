/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Application%20Tax%20Options%20-%20Application%20Tax%20Options.sql $:
 * $Id: Manage Application Tax Options - Application Tax Options.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT Qrslt.Bu_Name RES_BUSINESS_UNIT
,Qrslt.Application_Name RES_APPLICATION_NAME
,Qrslt.Taxdeterminemethod RES_TAX_DETERMINATION_METHOD
,DECODE(Qrslt.USE_TAX_CLASSIFICATION_FLAG,'Y','Yes','No') RES_ENABLE_DEFAULTING_ORDER
,Qrslt.DEF_OPTION_HIER_1_MEANING RES_DEFAULTING_ORDER_1
,Qrslt.DEF_OPTION_HIER_2_MEANING RES_DEFAULTING_ORDER_2
,Qrslt.DEF_OPTION_HIER_3_MEANING RES_DEFAULTING_ORDER_3
,Qrslt.DEF_OPTION_HIER_4_MEANING RES_DEFAULTING_ORDER_4
,Qrslt.DEF_OPTION_HIER_5_MEANING RES_DEFAULTING_ORDER_5
,Qrslt.DEF_OPTION_HIER_6_MEANING RES_DEFAULTING_ORDER_6
,Qrslt.Tax_Classification_Code RES_FINANCIAL_OPTIONS_TAX_CLAS
,(Select Currencyeo.Currency_Code ||' - ' ||Currencyeo.Name
	From Fusion.Fnd_Currencies_Vl CURRENCYEO
	where CURRENCYEO.CURRENCY_CODE = Qrslt.TAX_CURRENCY_CODE
	) RES_TAX_CURRENCY	
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE = 'ZX_ROUNDING_RULE'
	AND LOOKUP_CODE   = Qrslt.TAX_ROUNDING_RULE
	) As RES_ROUNDING_RULE
,Qrslt.Tax_Minimum_Accountable_Unit RES_MINIMUM_ACCOUNTABLE_UNIT
,Qrslt.Tax_Precision RES_TAX_PRECISION
,Decode(Qrslt.Allow_Tax_Rounding_Ovrd_Flag,'Y','Yes','No') RES_ALLOW_TAX_ROUNDING_OVERRID
,Qrslt.Sales_Tax_Geocode RES_OVERRIDE_GEOCODE_FOR_TAXWA
,Decode(Tax_Use_Customer_Exempt_Flag,'Y','Yes','No') RES_ALLOW_OVERRIDE_AND_ENTRY_O
,Qrslt.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Qrslt.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Qrslt.CREATED_BY RSC_CREATED_BY
,Qrslt.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,Qrslt.BU_ID RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,Null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM
	(SELECT Application_name
	,BusinessUnitPEO.BU_NAME
	,ZxProductOptionsAll.ORG_ID
	,ZxProductOptionsAll.APPLICATION_ID
	,ZxProductOptionsAll.DEF_OPTION_HIER_1_CODE
	,ZxProductOptionsAll.DEF_OPTION_HIER_2_CODE
	,ZxProductOptionsAll.DEF_OPTION_HIER_3_CODE
	,ZxProductOptionsAll.DEF_OPTION_HIER_4_CODE
	,ZxProductOptionsAll.DEF_OPTION_HIER_5_CODE
	,ZxProductOptionsAll.DEF_OPTION_HIER_6_CODE
	,ZxProductOptionsAll.TAX_CLASSIFICATION_CODE
	,ZxProductOptionsAll.TAX_METHOD_CODE
	,ZxProductOptionsAll.INCLUSIVE_TAX_USED_FLAG
	,ZxProductOptionsAll.TAX_USE_CUSTOMER_EXEMPT_FLAG
	,ZxProductOptionsAll.TAX_USE_PRODUCT_EXEMPT_FLAG
	,ZxProductOptionsAll.TAX_USE_LOC_EXC_RATE_FLAG
	,ZxProductOptionsAll.TAX_ALLOW_COMPOUND_FLAG
	,ZxProductOptionsAll.TAX_ROUNDING_RULE
	,ZxProductOptionsAll.TAX_PRECISION
	,ZxProductOptionsAll.TAX_MINIMUM_ACCOUNTABLE_UNIT
	,ZxProductOptionsAll.USE_TAX_CLASSIFICATION_FLAG
	,ZxProductOptionsAll.ALLOW_TAX_ROUNDING_OVRD_FLAG
	,ZxProductOptionsAll.HOME_COUNTRY_DEFAULT_FLAG
	,ZxProductOptionsAll.OBJECT_VERSION_NUMBER
	,ZxProductOptionsAll.RECORD_TYPE_CODE
	,ZxProductOptionsAll.CREATION_DATE
	,ZxProductOptionsAll.CREATED_BY
	,ZxProductOptionsAll.LAST_UPDATE_DATE
	,ZxProductOptionsAll.LAST_UPDATED_BY
	,ZxProductOptionsAll.LAST_UPDATE_LOGIN
	,ZxProductOptionsAll.EVENT_CLASS_MAPPING_ID
	,ZxProductOptionsAll.DEF_OPTION_HIER_7_CODE
	,ZxProductOptionsAll.PRODUCT_OPTIONS_ID
	,ZxProductOptionsAll.SALES_TAX_GEOCODE
	,BusinessUnitPEO.BU_ID
	,(SELECT meaning
		FROM fnd_lookups
		WHERE lookup_type = DECODE(ZxProductOptionsAll.APPLICATION_ID,200,'ZX_AP_DEFAULT_HIERARCHY',222,
			'ZX_AR_DEFAULT_HIERARCHY',201,'ZX_PO_DEFAULT_HIERARCHY',10016,'ZX_AP_DEFAULT_HIERARCHY',275,
			'ZX_PA_DEFAULT_HIERARCHY',10035,'ZX_PA_DEFAULT_HIERARCHY')
		AND LOOKUP_CODE = ZxProductOptionsAll.DEF_OPTION_HIER_1_CODE
		) DEF_OPTION_HIER_1_MEANING
	,(SELECT meaning
		FROM fnd_lookups
		WHERE lookup_type = DECODE(ZxProductOptionsAll.APPLICATION_ID,200,'ZX_AP_DEFAULT_HIERARCHY',222,
			'ZX_AR_DEFAULT_HIERARCHY',201,'ZX_PO_DEFAULT_HIERARCHY',10016,'ZX_AP_DEFAULT_HIERARCHY',275,
			'ZX_PA_DEFAULT_HIERARCHY',10035,'ZX_PA_DEFAULT_HIERARCHY')
		AND LOOKUP_CODE = ZxProductOptionsAll.DEF_OPTION_HIER_2_CODE
		) DEF_OPTION_HIER_2_MEANING
	,(SELECT meaning
		FROM fnd_lookups
		WHERE lookup_type = DECODE(ZxProductOptionsAll.APPLICATION_ID,200,'ZX_AP_DEFAULT_HIERARCHY',222,
			'ZX_AR_DEFAULT_HIERARCHY',201,'ZX_PO_DEFAULT_HIERARCHY',10016,'ZX_AP_DEFAULT_HIERARCHY',275,
			'ZX_PA_DEFAULT_HIERARCHY',10035,'ZX_PA_DEFAULT_HIERARCHY')
		AND LOOKUP_CODE = ZxProductOptionsAll.DEF_OPTION_HIER_3_CODE
		) DEF_OPTION_HIER_3_MEANING
	,(SELECT meaning
		FROM fnd_lookups
		WHERE lookup_type = DECODE(ZxProductOptionsAll.APPLICATION_ID,200,'ZX_AP_DEFAULT_HIERARCHY',222,
			'ZX_AR_DEFAULT_HIERARCHY',201,'ZX_PO_DEFAULT_HIERARCHY',10016,'ZX_AP_DEFAULT_HIERARCHY',275,
			'ZX_PA_DEFAULT_HIERARCHY',10035,'ZX_PA_DEFAULT_HIERARCHY')
		AND LOOKUP_CODE = ZxProductOptionsAll.DEF_OPTION_HIER_4_CODE
		) DEF_OPTION_HIER_4_MEANING
	,(SELECT meaning
		FROM fnd_lookups
		WHERE lookup_type = DECODE(ZxProductOptionsAll.APPLICATION_ID,200,'ZX_AP_DEFAULT_HIERARCHY',222,
			'ZX_AR_DEFAULT_HIERARCHY',201,'ZX_PO_DEFAULT_HIERARCHY',10016,'ZX_AP_DEFAULT_HIERARCHY',275,
			'ZX_PA_DEFAULT_HIERARCHY',10035,'ZX_PA_DEFAULT_HIERARCHY')
		AND LOOKUP_CODE = ZxProductOptionsAll.DEF_OPTION_HIER_5_CODE
		) DEF_OPTION_HIER_5_MEANING
	,(SELECT meaning
		FROM fnd_lookups
		WHERE lookup_type = DECODE(ZxProductOptionsAll.APPLICATION_ID,200,'ZX_AP_DEFAULT_HIERARCHY',222,
			'ZX_AR_DEFAULT_HIERARCHY',201,'ZX_PO_DEFAULT_HIERARCHY',10016,'ZX_AP_DEFAULT_HIERARCHY',275,
			'ZX_PA_DEFAULT_HIERARCHY',10035,'ZX_PA_DEFAULT_HIERARCHY')
		AND LOOKUP_CODE = ZxProductOptionsAll.DEF_OPTION_HIER_6_CODE
		) DEF_OPTION_HIER_6_MEANING
	,DECODE(ZxProductOptionsAll.TAX_METHOD_CODE,'LTE',NULL,FndLookups.Meaning) AS STATUS
	,ZxProductOptionsAll.TAX_CLASSIFICATION_CODE                               AS SYSTEMTAXCODE
	,(SELECT Meaning
		FROM Fnd_Lookups
		WHERE Lookup_Type                 = 'ZX_TAX_METHOD_OPTIONS'
		AND Lookup_Code                   = ZxProductOptionsAll.TAX_METHOD_CODE
		AND START_DATE_ACTIVE            <= SYSDATE
		AND NVL(END_DATE_ACTIVE,SYSDATE) >= SYSDATE
		AND ENABLED_FLAG                  = 'Y'
		)                    AS TAXDETERMINEMETHOD
	,fav.APPLICATION_NAME AS APP_NAME
	,ZxProductOptionsAll.TAX_CURRENCY_CODE
	FROM ZX_PRODUCT_OPTIONS_ALL ZxProductOptionsAll
	,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
	,fnd_application_vl fav
	,FND_LOOKUPS FndLookups
	WHERE ZxProductOptionsAll.org_id             = BusinessUnitPEO.bu_id
	AND fav.application_id                       = ZxProductOptionsAll.Application_id
	AND FndLookups.Lookup_Code                   = ZxProductOptionsAll.USE_TAX_CLASSIFICATION_FLAG
	AND FndLookups.Lookup_Type                   = 'ZX_DEFAULTING_HIERARCHY_STATUS'
	AND FndLookups.START_DATE_ACTIVE            <= SYSDATE
	AND NVL(Fndlookups.End_Date_Active,Sysdate) >= Sysdate
	AND FndLookups.ENABLED_FLAG                  = 'Y'
	) Qrslt
	order by 1,2	