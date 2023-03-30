/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Standard%20Memo%20Lines%20-%20Reference%20Accounts.sql $:
 * $Id: Manage Standard Memo Lines - Reference Accounts.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- FIELD_TO_APPLY_FUNCTION=RES_REVENUE/GET_CODE_COMBINATION
 
SELECT  
	    (SELECT SET_NAME
		FROM Fusion.FND_SETID_SETS_VL
		WHERE SET_ID = HEAD.SET_ID
		) AS 										RES_MEMO_LINE_SET
       ,HEAD.NAME         							RES_NAME
       ,DETAIL.BusinessUnit    						RES_BUSINESS_UNIT 
	   ,DETAIL.REV_CCID   						RES_REVENUE
	   ,DETAIL.Ledger								RES_LEDGER
	   ,DETAIL.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
	   ,DETAIL.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
	   ,DETAIL.CREATED_BY  RSC_CREATED_BY
	   ,DETAIL.CREATION_DATE  RSC_CREATION_DATE
	   ,DETAIL.LEDGER_ID RSC_LEDGER_ID
	   ,null RSC_CHART_OF_ACCOUNTS_ID
	   ,DETAIL.BU_ID RSC_BUSINESS_UNIT_ID
	   ,null RSC_LEGAL_ENTITY_ID
	   ,null RSC_ORGANIZATION_ID
	   ,null RSC_BUSINESS_GROUP_ID
	   ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
( SELECT armemolinesallvl.memo_line_seq_id
     ,ArMemoLinesAllVl.NAME
	 ,ArMemoLinesAllVl.SET_ID
	 FROM Fusion.AR_MEMO_LINES_ALL_VL ArMemoLinesAllVl
	,Fusion.INV_UNITS_OF_MEASURE_VL UnitOfMeasurePEO
	,Fusion.AR_LOOKUPS ArLookupPEO
	WHERE ArMemoLinesAllVl.uom_code = UnitOfMeasurePEO.uom_code (+)
	AND ArMemoLinesAllVl.Line_Type  = ArLookupPEO.lookup_code(+)
	AND ArLookupPEO.lookup_type     = 'STD_LINE_TYPE'
) HEAD,
(
	SELECT distinct 
	arrefaccountsall.source_ref_account_id
	,ArRefAccountsAll.LAST_UPDATED_BY
	,ArRefAccountsAll.LAST_UPDATE_DATE
	,ArRefAccountsAll.CREATED_BY
	,ArRefAccountsAll.CREATION_DATE
	,ArRefAccountsAll.SOURCE_REF_TABLE
	,ArRefAccountsAll.BU_ID
	,ArRefAccountsAll.LEDGER_ID
	,(BusinessUnitPEO.bu_name)        AS BusinessUnit
	,(GlLedgers.NAME)                 AS Ledger
	,ArRefAccountsAll.REV_CCID
	FROM Fusion.AR_REF_ACCOUNTS_ALL ArRefAccountsAll
	,Fusion.FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
	,Fusion.GL_LEDGERS GlLedgers
	WHERE ArRefAccountsAll.BU_ID               = BusinessUnitPEO.BU_ID
	AND ArRefAccountsAll.LEDGER_ID             = GlLedgers.LEDGER_ID
	AND ArRefAccountsAll.SOURCE_REF_TABLE      = 'AR_MEMO_LINES_ALL_B'
)DETAIL
WHERE HEAD.memo_line_seq_id = DETAIL.source_ref_account_id
ORDER BY name