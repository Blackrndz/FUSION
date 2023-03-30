/* ****************************************************************************
 * $Revision: 53756 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-22 15:41:28 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 53756 2016-03-22 08:41:28Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=PO_LINE_TYPES_VL

SELECT PurchasingLineTypeEO.LINE_TYPE RES_LINE_TYPE
,PurchasingLineTypeEO.DESCRIPTION RES_DESCRIPTION
,PurchasingLineTypeEO.LINE_TYPE_CODE RES_CODE
,(SELECT PoLookupPEO.DISPLAYED_FIELD 
	FROM PO_LOOKUP_CODES PoLookupPEO 
	WHERE PoLookupPEO.LOOKUP_TYPE = 'PURCHASE BASIS' 
	AND PoLookupPEO.LOOKUP_CODE = PurchasingLineTypeEO.PURCHASE_BASIS) RES_PURCHASE_BASIS
,(SELECT MEANING FROM FND_LOOKUP_VALUES WHERE LOOKUP_CODE = PurchasingLineTypeEO.PRODUCT_TYPE
	AND LOOKUP_TYPE = 'ZX_PRODUCT_TYPE' AND LANGUAGE = USERENV('LANG'))  RES_PRODUCT_TYPE
,CategoryPEO.CATEGORY_NAME RES_CATEGORY_NAME
,UnitOfMeasurePEO.UNIT_OF_MEASURE RES_UOM
,(CASE 
	WHEN PurchasingLineTypeEO.RECEIVING_FLAG = 'N' AND PurchasingLineTypeEO.INSPECTION_REQUIRED_FLAG = 'N' THEN
		'2 Way'
	WHEN PurchasingLineTypeEO.RECEIVING_FLAG = 'Y' AND PurchasingLineTypeEO.INSPECTION_REQUIRED_FLAG = 'N' THEN
		'3 Way'
	WHEN PurchasingLineTypeEO.RECEIVING_FLAG = 'Y' AND PurchasingLineTypeEO.INSPECTION_REQUIRED_FLAG = 'Y' THEN
		'4 Way'
	END
	) RES_MATCH_APPROVAL_LEVEL
,(SELECT PoLookupPE1.DISPLAYED_FIELD
	FROM PO_LOOKUP_CODES PoLookupPE1 
	WHERE PoLookupPE1.LOOKUP_TYPE = 'PO INVOICE MATCH OPTION' 
	AND PoLookupPE1.LOOKUP_CODE = PurchasingLineTypeEO.MATCH_OPTION) RES_INVOICE_MATCH_OPTION
,PurchasingLineTypeEO.RECEIVE_CLOSE_TOLERANCE RES_RECEIPT_CLOSE_TOLERANCE_PE
,TO_CHAR(PurchasingLineTypeEO.INACTIVE_DATE, 'DD-Mon-YYYY') RES_END_DATE
,PurchasingLineTypeEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PurchasingLineTypeEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PurchasingLineTypeEO.CREATED_BY  RSC_CREATED_BY
,PurchasingLineTypeEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PO_LINE_TYPES_VL PurchasingLineTypeEO
,INV_UNITS_OF_MEASURE_VL UnitOfMeasurePEO
,EGP_CATEGORIES_VL CategoryPEO
WHERE PurchasingLineTypeEO.UOM_CODE  = UnitOfMeasurePEO.UOM_CODE(+)
AND PurchasingLineTypeEO.CATEGORY_ID = CategoryPEO.CATEGORY_ID(+)
ORDER BY PurchasingLineTypeEO.LINE_TYPE