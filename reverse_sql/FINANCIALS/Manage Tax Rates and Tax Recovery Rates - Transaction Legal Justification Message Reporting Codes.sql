/* ****************************************************************************
* $Revision: 79217 $:
* $Author: tanawat.wongjan $:
* $Date: 2022-08-15 13:18:17 +0700 (Mon, 15 Aug 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Rates%20and%20Tax%20Recovery%20Rates%20-%20Transaction%20Legal%20Justification%20Message%20Reporting%20Codes.sql $:
* $Id: Manage Tax Rates and Tax Recovery Rates - Transaction Legal Justification Message Reporting Codes.sql 79217 2022-08-15 06:18:17Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT HEAD.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,HEAD.PARTY_NAME RES_CONFIGURATION_OWNER
,HEAD.TAX RES_TAX
,HEAD.tax_status_code RES_TAX_STATUS_CODE
,HEAD.tax_jurisdiction_code RES_TAX_JURISDICTION_CODE
,HEAD.tax_rate_code RES_TAX_RATE_CODE
,HEAD.PERCENTAGE_RATE RES_RATE_PERCENTAGE
,HEAD.UOM_CODE RES_UOM_CODE
,HEAD.UNIT_OF_MEASURE RES_UOM_NAME
,HEAD.QUANTITY_RATE RES_RATE_QUANTITY
,to_char(HEAD.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_RATE_PERIODS_EFFECTIVE_STA
,QRSLT.REPORTING_TYPE_CODE RES_TAX_REPORTING_TYPE_CODE
,QRSLT.REPORTING_CODE_CHAR_VALUE RES_TAX_REPORTING_CODE
,TO_CHAR(QRSLT.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(QRSLT.EFFECTIVE_TO,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE

,QRSLT.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY RSC_CREATED_BY
,QRSLT.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE
	WHEN HEAD.PARTY_TYPE_CODE = 'OU' THEN
		HEAD.BU_ID
	END) RSC_BUSINESS_UNIT_ID
,(CASE
	WHEN HEAD.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN
		HEAD.LEGAL_ENTITY_ID
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
	
FROM (select DISTINCT ZxRatesVl.TAX_REGIME_CODE                                   
    ,party.PARTY_NAME 
    ,ZxRatesVl.TAX 
    ,ZxRatesVl.tax_status_code   
    ,ZxRatesVl.tax_jurisdiction_code                                                     
    ,ZxRatesVl.tax_rate_code      
    ,ZxRatesVl.PERCENTAGE_RATE   
    ,ZxRatesVl.UOM_CODE                                                             
    ,ZxRatesVl.QUANTITY_RATE                                                        
    ,ZxRatesVl.EFFECTIVE_FROM                    
    ,ZxRatesVl.tax_rate_id
	,UnitOfMeasurePEO.UNIT_OF_MEASURE
	,ZxRatesVl.CONTENT_OWNER_ID
	,party.PARTY_TYPE_CODE
	,party.BU_ID
	,party.LEGAL_ENTITY_ID
	FROM ZX_RATES_VL ZxRatesVl,
	ZX_FIRST_PARTY_ORGS_MOAC_V party,
	ZX_REGIMES_VL RegimeTLEO, 
	ZX_MCO_CHECK_ACCESS_V ZMCAV,
	ZX_MCO_LV_TAXES_V Tax,
	INV_UNITS_OF_MEASURE_VL UnitOfMeasurePEO
	WHERE RegimeTLEO.TAX_REGIME_CODE           = ZxRatesVl.TAX_REGIME_CODE
    AND party.party_tax_profile_id           = ZxRatesVl.CONTENT_OWNER_ID
    AND ZxRatesVl.ACTIVE_FLAG                = 'Y'
    AND ZMCAV.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
    AND ZMCAV.PARENT_FIRST_PTY_ORG_ID = ZxRatesVl.CONTENT_OWNER_ID
    AND Tax.TAX_REGIME_CODE = ZxRatesVl.TAX_REGIME_CODE
    AND Tax.TAX = ZxRatesVl.TAX
    AND Tax.CONTENT_OWNER_ID = ZxRatesVl.CONTENT_OWNER_ID
    AND ZxRatesVl.rate_type_code <> 'RECOVERY'  
    AND UPPER(NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I')) = UPPER('I')
	AND ZxRatesVl.UOM_CODE = UnitOfMeasurePEO.UOM_CODE(+)
	) HEAD

,(SELECT TaxReportingCodeAssociationE1.REPORTING_CODE_ASSOC_ID, 
	TaxReportingCodeAssociationE1.ENTITY_CODE, 
	TaxReportingCodeAssociationE1.ENTITY_ID, 
	ZxReportingTypesVl.REPORTING_TYPE_CODE, 
	ZxReportingTypesVl.REPORTING_TYPE_DATATYPE_CODE, 
	ZxReportingTypesVl.REPORTING_TYPE_NAME, 
	TaxReportingCodeAssociationE1.REPORTING_CODE_CHAR_VALUE, 
	ZxReportingCodesVl.REPORTING_CODE_NAME, 
	TaxReportingCodeAssociationE1.EFFECTIVE_FROM, 
	TaxReportingCodeAssociationE1.EFFECTIVE_TO, 
	TaxReportingCodeAssociationE1.REPORTING_TYPE_ID, 
	TaxReportingCodeAssociationE1.REPORTING_CODE_ID, 
	ZxReportingTypesVl.LEGAL_MESSAGE_FLAG, 
	ZxReportingTypesVl.TAX, 
	ZxReportingTypesVl.TAX_REGIME_CODE,       
	(SELECT DatatypeLookups.Meaning
		FROM fnd_lookups DatatypeLookups
		WHERE DatatypeLookups.lookup_type = 'ZX_REPORTING_DATA'
		AND DatatypeLookups.lookup_code = ZxReportingTypesVl.REPORTING_TYPE_DATATYPE_CODE
		) AS REPORTING_DATATYPE_CODE_NAME,
	'N' AS NEW_RECORD
	,TaxReportingCodeAssociationE1.LAST_UPDATED_BY 
	,TaxReportingCodeAssociationE1.LAST_UPDATE_DATE 
	,TaxReportingCodeAssociationE1.CREATED_BY 
	,TaxReportingCodeAssociationE1.CREATION_DATE 
	FROM ZX_REPORT_CODES_ASSOC TaxReportingCodeAssociationE1
	, ZX_REPORTING_TYPES_VL ZxReportingTypesVl
	, ZX_REPORTING_CODES_VL ZxReportingCodesVl
	WHERE (TaxReportingCodeAssociationE1.REPORTING_TYPE_ID = ZxReportingTypesVl.REPORTING_TYPE_ID) 
	AND (ZxReportingTypesVl.REPORTING_TYPE_ID = ZxReportingCodesVl.REPORTING_TYPE_ID) 
	AND (TaxReportingCodeAssociationE1.REPORTING_CODE_ID = ZxReportingCodesVl.REPORTING_CODE_ID) 
	AND (ZxReportingTypesVl.LEGAL_MESSAGE_FLAG = 'Y')
	) QRSLT  

WHERE HEAD.tax_rate_id = QRSLT.ENTITY_ID 
ORDER BY (SELECT DECODE(TAX_TYPE_CODE,'OFFSET',1,2) 
	FROM ZX_TAXES_VL 
	WHERE TAX = HEAD.TAX 
	AND CONTENT_OWNER_ID = HEAD.CONTENT_OWNER_ID
	AND TAX_REGIME_CODE = HEAD.TAX_REGIME_CODE
	)
,RES_TAX_REGIME_CODE 