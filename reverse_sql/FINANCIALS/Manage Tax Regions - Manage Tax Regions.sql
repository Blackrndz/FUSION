/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT ApIncomeTaxRegions.REGION_SHORT_NAME AS RES_STATE,
  ApIncomeTaxRegions.REGION_CODE            AS RES_CODE,
  ApIncomeTaxRegions.REGION_LONG_NAME       AS RES_DESCRIPTION,
  ApIncomeTaxRegions.REPORTING_LIMIT        AS RES_AMOUNT_USD,
  (SELECT PayablesLookupPEO.DISPLAYED_FIELD
  FROM AP_LOOKUP_CODES PayablesLookupPEO
  WHERE sysdate                         >= NVL(start_date_active, sysdate)
  AND sysdate                            < NVL(end_date_active, sysdate+1)
  AND ( ( (PayablesLookupPEO.LOOKUP_TYPE = 'REPORTING LIMIT METHOD' ) ) )
  AND PayablesLookupPEO.LOOKUP_CODE      = ApIncomeTaxRegions.REPORTING_LIMIT_METHOD_CODE
  )                                AS RES_METHOD,
  TO_CHAR(ApIncomeTaxRegions.ACTIVE_DATE,'DD-Mon-YYYY')   AS RES_FROM_DATE,
  TO_CHAR(ApIncomeTaxRegions.INACTIVE_DATE,'DD-Mon-YYYY') AS RES_TO_DATE,
  ApIncomeTaxRegions.LAST_UPDATED_BY RSC_LAST_UPDATED_BY ,
  ApIncomeTaxRegions.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE ,
  ApIncomeTaxRegions.CREATED_BY RSC_CREATED_BY ,
  ApIncomeTaxRegions.CREATION_DATE RSC_CREATION_DATE ,
  NULL RSC_LEDGER_ID ,
  NULL RSC_CHART_OF_ACCOUNTS_ID ,
  NULL RSC_BUSINESS_UNIT_ID ,
  NULL RSC_LEGAL_ENTITY_ID ,
  NULL RSC_ORGANIZATION_ID ,
  NULL RSC_BUSINESS_GROUP_ID ,
  NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_INCOME_TAX_REGIONS ApIncomeTaxRegions
ORDER BY ApIncomeTaxRegions.REGION_SHORT_NAME