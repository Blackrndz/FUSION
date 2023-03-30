/* ****************************************************************************
 * $Revision: 79432 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-09-29 16:44:46 +0700 (Thu, 29 Sep 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Standard%20Memo%20Lines%20-%20Standard%20Memo%20Lines.sql $:
 * $Id: Manage Standard Memo Lines - Standard Memo Lines.sql 79432 2022-09-29 09:44:46Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT (SELECT SET_NAME
	FROM Fusion.FND_SETID_SETS_VL
	WHERE SET_ID = ArMemoLinesAllVl.SET_ID
	) AS RES_MEMO_LINE_SET
,ArMemoLinesAllVl.NAME RES_NAME
,ArMemoLinesAllVl.DESCRIPTION RES_DESCRIPTION
,ArLookupPEO.MEANING RES_TYPE
,(SELECT  DISTINCT  TaxClassificationPEO.MEANING
	FROM Fusion.ZX_TAX_CLASSIFICATIONS_V TaxClassificationPEO
	Where TaxClassificationPEO.LOOKUP_TYPE = 'ZX_OUTPUT_CLASSIFICATIONS'
	AND TaxClassificationPEO.LOOKUP_CODE =  ArMemoLinesAllVl.TAX_CODE 
	)  	RES_TAX_CLASSIFICATION
,(SELECT CONCAT_LEAF_NAME 
	FROM Fusion.ZX_FC_PRODUCT_CATEGORIES_V
	WHERE CLASSIFICATION_CODE = ArMemoLinesAllVl.TAX_PRODUCT_CATEGORY
	) RES_TAX_PRODUCT_CATEGORY_NAME
,(SELECT CONCAT_LEAF_CODE 
	FROM Fusion.ZX_FC_PRODUCT_CATEGORIES_V
	WHERE CLASSIFICATION_CODE = ArMemoLinesAllVl.TAX_PRODUCT_CATEGORY
	) RES_TAX_PRODUCT_CATEGORY_CODE
,ArMemoLinesAllVl.TAX_PRODUCT_CATEGORY RES_TAX_PRODUCT_CATEGORY_CODE_
,TO_CHAR(ArMemoLinesAllVl.UNIT_STD_PRICE,'9,999,999,999,999,999')	RES_UNIT_LIST_PRICE
,UnitOfMeasurePEO.UNIT_OF_MEASURE RES_UNIT_OF_MEASURE
,(SELECT  RaRules.DESCRIPTION
	FROM Fusion.RA_RULES RaRules
	WHERE  RaRules.rule_id =  ArMemoLinesAllVl.INVOICING_RULE_ID 
	) RES_INVOICING_RULE
,(SELECT name
	FROM Fusion.ra_rules
	WHERE rule_id = ArMemoLinesAllVl.accounting_rule_id
	) AS RES_RULE
,TO_CHAR(ArMemoLinesAllVl.EFFECTIVE_START_DATE,'DD-Mon-YYYY') 				RES_FROM_DATE
,TO_CHAR(ArMemoLinesAllVl.EFFECTIVE_END_DATE,'DD-Mon-YYYY') 				RES_TO_DATE
,ArMemoLinesAllVl.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ArMemoLinesAllVl.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ArMemoLinesAllVl.CREATED_BY  RSC_CREATED_BY
,ArMemoLinesAllVl.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
FROM Fusion.AR_MEMO_LINES_ALL_VL ArMemoLinesAllVl
,Fusion.INV_UNITS_OF_MEASURE_VL UnitOfMeasurePEO
,Fusion.AR_LOOKUPS ArLookupPEO
WHERE ArMemoLinesAllVl.uom_code = UnitOfMeasurePEO.uom_code (+)
AND ArMemoLinesAllVl.Line_Type  = ArLookupPEO.lookup_code(+)
AND ArLookupPEO.lookup_type     = 'STD_LINE_TYPE'
ORDER BY name