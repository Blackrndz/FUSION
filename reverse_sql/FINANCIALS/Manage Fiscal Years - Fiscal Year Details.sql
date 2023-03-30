/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Fiscal%20Years%20-%20Fiscal%20Year%20Details.sql $:
 * $Id: Manage Fiscal Years - Fiscal Year Details.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

select QRSLT.FISCAL_YEAR_NAME RES_NAME
, QRSLT.FISCAL_YEAR RES_FISCAL_YEAR
, TO_CHAR(QRSLT.START_DATE,'DD-Mon-YYYY') RES_START_DATE
, TO_CHAR(QRSLT.END_DATE,'DD-Mon-YYYY') RES_END_DATE
, TO_CHAR(QRSLT.MID_YEAR_DATE,'DD-Mon-YYYY') RES_MID_YEAR_START_DATE
,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,QRSLT.CREATED_BY  RSC_CREATED_BY
,QRSLT.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT FiscalYearEO.FISCAL_YEAR_NAME
	,FiscalYearEO.FISCAL_YEAR
	,FiscalYearEO.START_DATE
	,FiscalYearEO.ATTRIBUTE1
	,FiscalYearEO.ATTRIBUTE_CATEGORY_CODE
	,FiscalYearEO.MID_YEAR_DATE
	,FiscalYearEO.END_DATE
	,FiscalYearEO.CREATED_BY
	,FiscalYearEO.CREATION_DATE
	,FiscalYearEO.LAST_UPDATED_BY
	,FiscalYearEO.LAST_UPDATE_LOGIN	
	,FiscalYearEO.LAST_UPDATE_DATE
	,FiscalYearEO.ATTRIBUTE2
	,FiscalYearEO.ATTRIBUTE3
	,FiscalYearEO.ATTRIBUTE4
	,FiscalYearEO.ATTRIBUTE5
	,FiscalYearEO.ATTRIBUTE6
	,FiscalYearEO.ATTRIBUTE7
	,FiscalYearEO.ATTRIBUTE8
	,FiscalYearEO.ATTRIBUTE9
	,FiscalYearEO.ATTRIBUTE10
	,FiscalYearEO.ATTRIBUTE11
	,FiscalYearEO.ATTRIBUTE12
	,FiscalYearEO.ATTRIBUTE13
	,FiscalYearEO.ATTRIBUTE14
	,FiscalYearEO.ATTRIBUTE15
	,FISCALYEAREO.OBJECT_VERSION_NUMBER
	from FA_FISCAL_YEAR_TYPES_VL FISCALYEARTY
	,FA_FISCAL_YEAR FISCALYEAREO
	where FISCALYEARTY.FISCAL_YEAR_NAME = FISCALYEAREO.FISCAL_YEAR_NAME
	) QRSLT
ORDER BY QRSLT.FISCAL_YEAR_NAME,QRSLT.FISCAL_YEAR 