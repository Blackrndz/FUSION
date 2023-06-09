/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PO_DOC_STYLE_HEADERS

SELECT PoDocStyleHeaders.STYLE_NAME RES_STYLE
,PoDocStyleHeaders.STYLE_DESCRIPTION RES_DESCRIPTION
,PoLookupPEO.DISPLAYED_FIELD RES_STATUS
,(SELECT DECODE(ENABLED_FLAG, 'Y', 'Yes', 'No') 
	FROM PO_DOC_STYLE_VALUES 
	WHERE STYLE_ALLOWED_VALUE = 'GOODS'
	AND STYLE_ID = PoDocStyleHeaders.STYLE_ID) RES_PURCHASE_BASES_GOODS
,(SELECT DECODE(ENABLED_FLAG, 'Y', 'Yes', 'No') 
	FROM PO_DOC_STYLE_VALUES 
	WHERE STYLE_ALLOWED_VALUE = 'SERVICES'
	AND STYLE_ID = PoDocStyleHeaders.STYLE_ID) RES_PURCHASE_BASES_SERVICES
,(SELECT DECODE(ENABLED_FLAG, 'Y', 'Yes', 'No') 
	FROM PO_DOC_STYLE_VALUES 
	WHERE STYLE_ALLOWED_VALUE = 'GOODS'
	AND STYLE_ID = PoDocStyleHeaders.STYLE_ID) RES_PURCHASE_BASES_QUANTITY
,(SELECT DECODE(ENABLED_FLAG, 'Y', 'Yes', 'No') 
	FROM PO_DOC_STYLE_VALUES 
	WHERE STYLE_ALLOWED_VALUE = 'SERVICES'
	AND STYLE_ID = PoDocStyleHeaders.STYLE_ID) RES_PURCHASE_BASES_AMOUNT
,DECODE(PoDocStyleHeaders.CONSIGNED_ITEMS_FLAG, 'Y', 'Yes', 'N', 'No') RES_CONSIGNMENT_TERMS_ENABLED
,DECODE(PoDocStyleHeaders.CONFIGURED_ITEM_FLAG, 'Y', 'Yes', 'N', 'No') RES_CONFIGURATION_ORDERING_ENA
,DECODE(PoDocStyleHeaders.OUTSIDE_PROCESSING_FLAG, 'Y', 'Yes', 'N', 'No') RES_OUTSIDE_PROCESSING_ENABLED
,DECODE(PoDocStyleHeaders.ENABLE_CREDIT_LINE_TYPES, 'Y', 'Yes', 'N', 'No') RES_CREDIT_LINE_TYPES_ENABLED
,DECODE(PoDocStyleHeaders.RETAINAGE_FLAG, 'Y', 'Yes', 'N', 'No') RES_RETAINAGE_ENABLED
,DECODE(PoDocStyleHeaders.PROGRESS_PAYMENT_FLAG, 'Y', 'Yes', 'N', 'No') RES_PROGRESS_PAYMENTS_ENABLED
,DECODE(PoDocStyleHeaders.WC_ENABLED_FLAG, 'Y', 'Yes', 'N', 'No') RES_WORK_CONFIRMATION_ENABLED
,(SELECT DISPLAY_NAME
	FROM PO_DOC_STYLE_LINES_TL 
	WHERE DOCUMENT_SUBTYPE = 'STANDARD'
	AND language  = userenv('LANG')
	AND STYLE_ID = PoDocStyleHeaders.STYLE_ID) RES_PURCHASE_ORDER_DISPLAY_NAM
,DECODE(PoDocStyleLinesTlE0.ENABLED_FLAG, 'Y', 'Yes', 'N', 'No')  RES_BLANKET_PURCHASE_AGREEMENT
,PoDocStyleLinesTlE0.DISPLAY_NAME RES_BLANKET_PURCHASE_AGREEME_0
,DECODE(PoDocStyleHeaders.PRICE_BREAKS_FLAG, 'Y', 'Yes', 'N', 'No') RES_PRICE_BREAKS_ALLOWED
,DECODE(PoDocStyleLinesTlE1.ENABLED_FLAG, 'Y', 'Yes', 'N', 'No') RES_CONTRACT_PURCHASE_AGREEMEN
,PoDocStyleLinesTlE1.DISPLAY_NAME RES_CONTRACT_PURCHASE_AGREEM_1
,(SELECT DISPLAYED_FIELD
	FROM PO_LOOKUP_CODES
	WHERE LOOKUP_TYPE = 'ALL_SPECIFIED'
	AND LOOKUP_CODE = PoDocStyleHeaders.LINE_TYPE_ALLOWED
	) RES_LINE_TYPES_OPTION
,PoDocStyleHeaders.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PoDocStyleHeaders.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PoDocStyleHeaders.CREATED_BY  RSC_CREATED_BY
,PoDocStyleHeaders.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
  
FROM PO_DOC_STYLE_HEADERS PoDocStyleHeaders
,PO_LOOKUP_CODES PoLookupPEO
,(SELECT PoDocStyleLinesTl.STYLE_ID, PoDocStyleLinesTl.DISPLAY_NAME, PoDocStyleLinesB.ENABLED_FLAG
	FROM PO_DOC_STYLE_LINES_TL PoDocStyleLinesTl
	,PO_DOC_STYLE_LINES_B PoDocStyleLinesB
	WHERE PoDocStyleLinesTl.DOCUMENT_SUBTYPE = 'BLANKET'
	AND PoDocStyleLinesTl.LANGUAGE = USERENV('LANG')
	AND PoDocStyleLinesTl.DOCUMENT_SUBTYPE = PoDocStyleLinesB.DOCUMENT_SUBTYPE
	AND PoDocStyleLinesTl.STYLE_ID = PoDocStyleLinesB.STYLE_ID) PoDocStyleLinesTlE0
,(SELECT PoDocStyleLinesTl.STYLE_ID, PoDocStyleLinesTl.DISPLAY_NAME, PoDocStyleLinesB.ENABLED_FLAG
	FROM PO_DOC_STYLE_LINES_TL PoDocStyleLinesTl
	,PO_DOC_STYLE_LINES_B PoDocStyleLinesB
	WHERE PoDocStyleLinesTl.DOCUMENT_SUBTYPE = 'CONTRACT'
	AND PoDocStyleLinesTl.LANGUAGE = USERENV('LANG')
	AND PoDocStyleLinesTl.DOCUMENT_SUBTYPE = PoDocStyleLinesB.DOCUMENT_SUBTYPE
	AND PoDocStyleLinesTl.STYLE_ID = PoDocStyleLinesB.STYLE_ID) PoDocStyleLinesTlE1
WHERE PoLookupPEO.LOOKUP_TYPE = 'ACTIVE_INACTIVE'
AND PoLookupPEO.LOOKUP_CODE   = PoDocStyleHeaders.STATUS
AND PoDocStyleHeaders.STYLE_ID = PoDocStyleLinesTlE0.STYLE_ID
AND PoDocStyleHeaders.STYLE_ID = PoDocStyleLinesTlE1.STYLE_ID
ORDER BY PoDocStyleHeaders.STYLE_NAME