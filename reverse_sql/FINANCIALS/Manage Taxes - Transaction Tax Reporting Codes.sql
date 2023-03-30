/* ****************************************************************************
 * $Revision: 53782 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2016-03-31 18:00:16 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: $:
 * $Id: Manage Applications Core Value Sets - Manage Applications Core Value Sets.sql 53782 2016-03-22 11:00:16Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT HEAD.TAX_REGIME_CODE RES_TAX_REGIME_CODE
,HEAD.PARTY_NAME RES_CONFIGURATION_OWNER
,HEAD.TAX RES_TAX
,HEAD.TAX_FULL_NAME RES_TAX_NAME
,Detail.REPORTING_TYPE_CODE RES_TAX_REPORTING_TYPE_CODE
,Detail.Reporting_datatype_code_name RES_DATA_TYPE
,Detail.REPORTING_CODE_CHAR_VALUE RES_TAX_REPORTING_CODE
,Detail.REPORTING_CODE_NAME RES_DESCRIPTION
,TO_CHAR(Detail.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(Detail.EFFECTIVE_TO,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,Detail.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Detail.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Detail.CREATED_BY RSC_CREATED_BY
,Detail.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,(CASE 
	WHEN HEAD.PARTY_TYPE_CODE = 'OU' THEN	
		HEAD.BU_ID
	ELSE
		NULL
	END) RSC_BUSINESS_UNIT_ID
,(CASE 
	WHEN HEAD.PARTY_TYPE_CODE = 'FIRST_PARTY' THEN	
		HEAD.LEGAL_ENTITY_ID
	ELSE
		NULL
	END) RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT TaxTLEO.TAX_REGIME_CODE
	,ZFPOMV.PARTY_NAME
	,ZFPOMV.PARTY_TYPE_CODE
	,ZFPOMV.BU_ID
	,ZFPOMV.LEGAL_ENTITY_ID
	,TaxTLEO.TAX
	,TaxTLEO.TAX_FULL_NAME
	,TaxTLEO.TAX_ID
	FROM ZX_TAXES_VL TaxTLEO
	,ZX_FIRST_PARTY_ORGS_MOAC_V ZFPOMV
	,ZX_REGIMES_VL RegimeTLEO
	WHERE ZFPOMV.PARTY_TAX_PROFILE_ID                = TaxTLEO.CONTENT_OWNER_ID
	AND RegimeTLEO.TAX_REGIME_CODE                   = TaxTLEO.TAX_REGIME_CODE
	AND NVL(RegimeTLEO.REGIME_TYPE_FLAG,'I')         = 'I'
	) HEAD
,(SELECT ZxReportingTypesVl.TAX_REGIME_CODE
	,ZxReportingTypesVl.TAX
	,TaxReportingCodeAssociationE.REPORTING_CODE_ASSOC_ID
	,TaxReportingCodeAssociationE.ENTITY_CODE
	,TaxReportingCodeAssociationE.ENTITY_ID
	,TaxReportingCodeAssociationE.EXCEPTION_CODE
	,TaxReportingCodeAssociationE.EFFECTIVE_FROM
	,TaxReportingCodeAssociationE.EFFECTIVE_TO
	,TaxReportingCodeAssociationE.CREATED_BY
	,TaxReportingCodeAssociationE.CREATION_DATE
	,TaxReportingCodeAssociationE.LAST_UPDATED_BY
	,TaxReportingCodeAssociationE.LAST_UPDATE_DATE
	,TaxReportingCodeAssociationE.REPORTING_CODE_CHAR_VALUE
	,ZxReportingTypesVl.REPORTING_TYPE_CODE
	,NVL(
		(SELECT DatatypeLookups.Meaning
		FROM fnd_lookups DatatypeLookups
		WHERE DatatypeLookups.lookup_type = 'ZX_REPORTING_DATA'
		AND DatatypeLookups.lookup_code   = ZxReportingTypesVl.REPORTING_TYPE_DATATYPE_CODE
		),(SELECT DatatypeLookups.Meaning
		FROM fnd_lookups DatatypeLookups
		WHERE DatatypeLookups.lookup_type = 'ZX_REPORTING_DATA'
		AND DatatypeLookups.lookup_code   = 'YES_NO'
		)) Reporting_datatype_code_name
	,DECODE(ZxReportingTypesVl.REPORTING_TYPE_DATATYPE_CODE,'YES_NO',(SELECT DatatypeLookups.Meaning
		FROM fnd_lookups DatatypeLookups
		WHERE DatatypeLookups.lookup_type = 'ZX_YES_NO'
		AND DatatypeLookups.lookup_code   = TaxReportingCodeAssociationE.REPORTING_CODE_CHAR_VALUE
		),'TEXT',(SELECT ZxReportingCodesVl.reporting_code_name
		FROM ZX_REPORTING_CODES_VL ZxReportingCodesVl
		WHERE ZxReportingCodesVl.reporting_type_id = ZxReportingTypesVl.reporting_type_id
		AND ZxReportingCodesVl.REPORTING_CODE_ID   = TaxReportingCodeAssociationE.REPORTING_CODE_ID
		),'NUMERIC_VALUE',(SELECT ZxReportingCodesVl.reporting_code_name
		FROM ZX_REPORTING_CODES_VL ZxReportingCodesVl
		WHERE ZxReportingCodesVl.reporting_type_id = ZxReportingTypesVl.reporting_type_id
		AND ZxReportingCodesVl.REPORTING_CODE_ID   = TaxReportingCodeAssociationE.REPORTING_CODE_ID
		),NULL) REPORTING_CODE_NAME
	FROM ZX_REPORT_CODES_ASSOC TaxReportingCodeAssociationE
	,ZX_REPORTING_TYPES_VL ZxReportingTypesVl
	WHERE TaxReportingCodeAssociationE.REPORTING_TYPE_ID = ZxReportingTypesVl.REPORTING_TYPE_ID
	) Detail
WHERE HEAD.TAX_ID = Detail.ENTITY_ID
ORDER BY Head.TAX_REGIME_CODE
,Head.TAX
,Detail.EFFECTIVE_FROM