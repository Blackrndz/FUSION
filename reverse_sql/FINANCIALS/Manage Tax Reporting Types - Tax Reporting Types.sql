/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20Types%20-%20Tax%20Reporting%20Types.sql $:
 * $Id: Manage Tax Reporting Types - Tax Reporting Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT QRSLT.Reporting_Type_Code Res_Tax_Reporting_Type_Code
,Qrslt.Reporting_Type_Name Res_Tax_Reporting_Type_Name
,QRSLT.Legal_Message_Name Res_Tax_Reporting_Type_Purpose
,QRSLT.Reporting_datatype_meaning Res_Data_Type
,QRSLT.COUNTRY_NAME Res_Country
,QRSLT.Tax_Regime_Code Res_Tax_Regime_Code
,QRSLT.Tax Res_Tax
,QRSLT.Min_Length RES_MINIMUM_LENGTH_OF_REPORTIN
,QRSLT.Max_Length Res_Maximum_Length_Of_Reportin
,TO_CHAR(QRSLT.Effective_From,'DD-Mon-YYYY') Res_Start_Date
,TO_CHAR(Qrslt.Effective_To,'DD-Mon-YYYY') Res_End_Date
, ( select meaning from FND_LOOKUPS   
       where  Lookup_Type   = 'ZX_VALIDATION_LEVEL'
       and lookup_code =  QRSLT.validation_level   )   RES_VALIDATION_LEVEL
, ( select meaning from FND_LOOKUPS   
       where  Lookup_Type   = 'ZX_UNIQUENESS_VALIDATION_LVL'
       and lookup_code =  QRSLT.uniqueness_validation_level    ) RES_DUPLICATE_VALIDATION_LEVEL
,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT ZxReportingTypesVl.REPORTING_TYPE_ID
	,ZxReportingTypesVl.REPORTING_TYPE_CODE
	,Zxreportingtypesvl.Reporting_Type_Datatype_Code
	,TypeLookuppeo.meaning Reporting_datatype_meaning
	,ZxReportingTypesVl.TAX_REGIME_CODE
	,ZxReportingTypesVl.TAX
	,ZxReportingTypesVl.FORMAT_MASK
	,ZxReportingTypesVl.MIN_LENGTH
	,ZxReportingTypesVl.MAX_LENGTH
	,ZxReportingTypesVl.EFFECTIVE_FROM
	,ZxReportingTypesVl.EFFECTIVE_TO
	,ZxReportingTypesVl.HAS_REPORTING_CODES_FLAG
	,ZxReportingTypesVl.OBJECT_VERSION_NUMBER
	,ZxReportingTypesVl.RECORD_TYPE_CODE
	,ZxReportingTypesVl.CREATED_BY
	,ZxReportingTypesVl.CREATION_DATE
	,ZxReportingTypesVl.LAST_UPDATED_BY
	,ZxReportingTypesVl.LAST_UPDATE_DATE
	,ZxReportingTypesVl.LAST_UPDATE_LOGIN
	,ZxReportingTypesVl.REQUEST_ID
	,ZxReportingTypesVl.PROGRAM_APP_NAME
	,ZxReportingTypesVl.PROGRAM_NAME
	,ZxReportingTypesVl.PROGRAM_LOGIN_ID
	,ZxReportingTypesVl.REPORTING_TYPE_NAME
	,LookupPEO.LOOKUP_TYPE
	,LookupPEO.LOOKUP_CODE REPORTING_TYPE_USE
	,ZxReportingTypesVl.REPORTING_TYPE_CODE REPORTING_TYPE_CODE_srch
	,ZxReportingTypesVl.REPORTING_TYPE_NAME REPORTING_TYPE_NAME_srch
	,ZxReportingTypesVl.LEGAL_MESSAGE_FLAG
	,TerritoryPEO.TERRITORY_SHORT_NAME AS COUNTRY_NAME
	,ZxReportingTypesVl.COUNTRY_CODE
	,ZxReportingTypesVl.TAX_REGIME_CODE TAX_REGIME_CODE_srch
	,ZxReportingTypesVl.TAX TAX_srch
	,LookupPEO.MEANING AS ENTITY_NAME
	,LookupPEO.MEANING REPORTING_TYPE_USE_SRCH
	,LegalLookupPEO.MEANING LEGAL_MESSAGE_NAME
	,DECODE(ZxReportingTypesVl.LEGAL_MESSAGE_FLAG,'W','W','I') AS regime_type_flag
	,ZxReportingTypesVl.validation_level
	,ZxReportingTypesVl.uniqueness_validation_level
	FROM ZX_REPORTING_TYPES_VL ZxReportingTypesVl
	,ZX_REPORT_TYPES_USAGES ZxReportTypesUsages
	,FND_LOOKUPS LookupPEO
	,Fnd_Lookups Legallookuppeo
	,Fnd_Lookups TypeLookuppeo
	,FND_TERRITORIES_VL TerritoryPEO
	WHERE ZxReportingTypesVl.REPORTING_TYPE_ID          = ZxReportTypesUsages.REPORTING_TYPE_ID(+)
	AND ZxReportTypesUsages.ENTITY_CODE                 = LookupPEO.lookup_code
	AND LookupPEO.lookup_type                           = 'ZX_REPORTING_TABLE_USE'
	AND Legallookuppeo.Lookup_Type                      = 'ZX_LEGAL_MESSAGE'
	AND Typelookuppeo.Lookup_Type                       = 'ZX_REPORTING_DATA'
	AND ZxReportingTypesVl.REPORTING_TYPE_DATATYPE_CODE = TypeLookuppeo.LOOKUP_CODE
	AND NVL(ZxReportingTypesVl.LEGAL_MESSAGE_FLAG,'N')  = LegalLookupPEO.LOOKUP_CODE
	AND(ZxReportingTypesVl.Country_Code                 = TerritoryPEO.territory_Code(+))
	AND ZxReportTypesUsages.enabled_flag                = 'Y'
	UNION
	SELECT ZxReportingTypesVl.REPORTING_TYPE_ID
	,ZxReportingTypesVl.REPORTING_TYPE_CODE
	,Zxreportingtypesvl.Reporting_Type_Datatype_Code
	,TypeLookuppeo.meaning Reporting_datatype_meaning
	,ZxReportingTypesVl.TAX_REGIME_CODE
	,ZxReportingTypesVl.TAX
	,ZxReportingTypesVl.FORMAT_MASK
	,ZxReportingTypesVl.MIN_LENGTH
	,ZxReportingTypesVl.MAX_LENGTH
	,ZxReportingTypesVl.EFFECTIVE_FROM
	,ZxReportingTypesVl.EFFECTIVE_TO
	,ZxReportingTypesVl.HAS_REPORTING_CODES_FLAG
	,ZxReportingTypesVl.OBJECT_VERSION_NUMBER
	,ZxReportingTypesVl.RECORD_TYPE_CODE
	,ZxReportingTypesVl.CREATED_BY
	,ZxReportingTypesVl.CREATION_DATE
	,ZxReportingTypesVl.LAST_UPDATED_BY
	,ZxReportingTypesVl.LAST_UPDATE_DATE
	,ZxReportingTypesVl.LAST_UPDATE_LOGIN
	,ZxReportingTypesVl.REQUEST_ID
	,ZxReportingTypesVl.PROGRAM_APP_NAME
	,ZxReportingTypesVl.PROGRAM_NAME
	,ZxReportingTypesVl.PROGRAM_LOGIN_ID
	,ZxReportingTypesVl.REPORTING_TYPE_NAME
	,NULL AS LOOKUP_TYPE
	,'HZ_CLASS_CATEGORIES' || ',' || 'ZX_FC_CODES_B' || ',' || 'ZX_FORMULAS' || ',' || 'ZX_JURISDICTIONS' || ',' ||
		'ZX_PARTY_TAX_PROFILE' || ' '|| 'ZX_PROCESS_RESULTS' || ',' || 'ZX_RATES' || ',' || 'ZX_REGISTRATIONS' || ',' ||
		'ZX_STATUS' || ',' || 'ZX_TAXES' AS REPORTING_TYPE_USE
	,ZxReportingTypesVl.REPORTING_TYPE_CODE REPORTING_TYPE_CODE_srch
	,ZxReportingTypesVl.REPORTING_TYPE_NAME REPORTING_TYPE_NAME_srch
	,ZxReportingTypesVl.LEGAL_MESSAGE_FLAG
	,TerritoryPEO.TERRITORY_SHORT_NAME AS COUNTRY_NAME
	,ZxReportingTypesVl.COUNTRY_CODE
	,ZxReportingTypesVl.TAX_REGIME_CODE TAX_REGIME_CODE_srch
	,ZxReportingTypesVl.TAX TAX_srch
	,NULL AS ENTITY_NAME
	,NULL AS REPORTING_TYPE_USE_SRCH
	,LegalLookupPEO.MEANING LEGAL_MESSAGE_NAME
	,DECODE(ZxReportingTypesVl.LEGAL_MESSAGE_FLAG,'W','W','I') AS regime_type_flag
	,ZxReportingTypesVl.validation_level
	,ZxReportingTypesVl.uniqueness_validation_level
	FROM ZX_REPORTING_TYPES_VL ZxReportingTypesVl
	,Fnd_Lookups Legallookuppeo
	,Fnd_Lookups TypeLookuppeo
	,FND_TERRITORIES_VL TerritoryPEO
	WHERE Legallookuppeo.Lookup_Type                    = 'ZX_LEGAL_MESSAGE'
	AND Typelookuppeo.Lookup_Type                       = 'ZX_REPORTING_DATA'
	AND ZxReportingTypesVl.REPORTING_TYPE_DATATYPE_CODE = TypeLookuppeo.LOOKUP_CODE
	AND NVL(ZxReportingTypesVl.LEGAL_MESSAGE_FLAG,'N')  = LegalLookupPEO.LOOKUP_CODE
	AND(Zxreportingtypesvl.Country_Code                 = Territorypeo.Territory_Code(+))
	ORDER BY 2,4
	) QRSLT
Where(Reporting_Type_Use_Srch Is Null)
order by QRSLT.Reporting_Type_Code