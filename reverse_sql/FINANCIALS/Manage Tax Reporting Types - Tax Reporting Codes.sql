/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20Types%20-%20Tax%20Reporting%20Codes.sql $:
 * $Id: Manage Tax Reporting Types - Tax Reporting Codes.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT Zxreportingtypesvl.Reporting_Type_Code RES_TAX_REPORTING_TYPE_CODE
, ZxReportingTypesVl.TAX_REGIME_CODE  RES_TAX_REGIME_CODE
, ZxReportingTypesVl.TAX    RES_TAX
--g,ZxReportingTypesVl.REPORTING_TYPE_NAME
,Zxreportingcodesvl.Reporting_Code_Char_Value RES_TAX_REPORTING_CODE
,DECODE(Zxreportingtypesvl.LEGAL_MESSAGE_FLAG,'Y',Zxreportingcodesvl.Reporting_Code_Name,NULL)
	RES_LEGAL_JUSTIFICATION_TEXT
,DECODE(Zxreportingtypesvl.LEGAL_MESSAGE_FLAG,'Y',null,Zxreportingcodesvl.Reporting_Code_Name) RES_DESCRIPTION
,DECODE(Zxreportingcodesvl.Sign_Flag,'P','Plus','M','Minus',Zxreportingcodesvl.Sign_Flag) RES_AMOUNT_SIGN
,(SELECT Lookuppeo.Meaning
	FROM Fnd_Lookups Lookuppeo
	WHERE Lookuppeo.Lookup_Type = 'ZX_TAX_BOX_VALUE'
	AND LookupPEO.LOOKUP_CODE   = Zxreportingcodesvl.value_type_code
	) RES_BOX_TYPE
,TO_CHAR(Zxreportingcodesvl.Effective_From,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(ZxReportingCodesVl.EFFECTIVE_TO,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,Zxreportingcodesvl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,Zxreportingcodesvl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,Zxreportingcodesvl.CREATED_BY RSC_CREATED_BY
,Zxreportingcodesvl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,Null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Zx_Reporting_Types_Vl Zxreportingtypesvl
,Zx_Reporting_Codes_Vl Zxreportingcodesvl
Where Zxreportingtypesvl.Reporting_Type_Id = Zxreportingcodesvl.Reporting_Type_Id
order by Zxreportingtypesvl.Reporting_Type_Code,RES_AMOUNT_SIGN desc,reporting_code_id