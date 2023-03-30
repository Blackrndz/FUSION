/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Tax%20Reporting%20Types%20-%20Reporting%20Type%20Uses.sql $:
 * $Id: Manage Tax Reporting Types - Reporting Type Uses.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT Zxreportingtypesvl.Reporting_Type_Code 				RES_TAX_REPORTING_TYPE_CODE
,ZxReportingTypesVl.TAX_REGIME_CODE  						RES_TAX_REGIME_CODE
,ZxReportingTypesVl.TAX    									RES_TAX
,Lookuppeo.Meaning 											RES_REPORTING_TYPE_USE
,DECODE(ZxReportTypesUsages.ENABLED_FLAG,'Y','Yes','No') 	RES_ENABLED
,ZxReportTypesUsages.LAST_UPDATED_BY 	RSC_LAST_UPDATED_BY
,ZxReportTypesUsages.LAST_UPDATE_DATE 	RSC_LAST_UPDATE_DATE
,ZxReportTypesUsages.CREATED_BY 		RSC_CREATED_BY
,ZxReportTypesUsages.CREATION_DATE 		RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM Zx_Reporting_Types_Vl Zxreportingtypesvl
,ZX_REPORT_TYPES_USAGES ZxReportTypesUsages
,Fnd_Lookups Lookuppeo
WHERE ZxReportingTypesVl.REPORTING_TYPE_ID = ZxReportTypesUsages.REPORTING_TYPE_ID
AND ZxReportTypesUsages.ENTITY_CODE        = LookupPEO.lookup_code
And Lookuppeo.Lookup_Type                  = 'ZX_REPORTING_TABLE_USE'
order by Zxreportingtypesvl.Reporting_Type_Code,Lookuppeo.Meaning