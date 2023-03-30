/* ****************************************************************************
 * $Revision: 49069 $:
 * $Author: Pisan.Jariyasettachok $:
 * $Date: 2015-09-01 17:23:38 +0700 (Tue, 01 Sep 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Facility%20Shifts%20-%20Manage%20Shifts.sql $:
 * $Id: Manage Facility Shifts - Manage Shifts.sql 49069 2015-09-01 10:23:38Z Pisan.Jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
SELECT CeilingTypeEO.CEILING_NAME AS RES_NAME,
  (SELECT SetIdSetPE.SET_NAME
  FROM FND_SETID_SETS_VL SetIdSetPE
  WHERE SetIdSetPE.SET_ID = CeilingTypeEO.SET_ID
  )                                                                                                          AS RES_REFERENCE_DATA_SET,
  DECODE(CeilingTypeEO.CEILING_TYPE, 'RECOVERABLE COST CEILING', 'Cost', 'DEPRN EXPENSE CEILING', 'Expense') AS RES_CEILING_TYPE,
  TO_CHAR(CeilingAmount.start_date,'DD-Mon-YYYY') AS RES_FROM_DATE_PLACED_IN_SERVIC,
  TO_CHAR(CeilingAmount.end_date,'DD-Mon-YYYY') AS RES_TO_DATE_PLACED_IN_SERVICE,
  CeilingAmount.year_of_life AS RES_YEAR_OF_LIFE,
  CeilingAmount.limit        AS RES_AMOUNT
  ,CeilingAmount.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,CeilingAmount.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,CeilingAmount.CREATED_BY  RSC_CREATED_BY
  ,CeilingAmount.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FA_CEILING_TYPES CeilingTypeEO,
  FA_CEILINGS CeilingAmount
WHERE ceiling_type!               ='ITC CEILING'
AND ceilingtypeeo.ceiling_type_id = CeilingAmount.ceiling_type_id
ORDER BY CeilingTypeEO.CEILING_NAME