/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT (SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = poHeadersE0.PRC_BU_ID
	) RES_PROCUREMENT_BU
,poHeadersE0.SEGMENT1 RES_AGREEMENT
,poLinesE0.LINE_NUM RES_LINE
,priceBreaksE0.SHIPMENT_NUM RES_PRICE_BREAK
,(SELECT ORGANIZATION_CODE
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = priceBreaksE0.SHIP_TO_ORGANIZATION_ID
	) RES_SHIP_TO_ORGANIZATION
,locationsE0.LOCATION_NAME RES_LOCATION_NAME
,locationsE0.INTERNAL_LOCATION_CODE RES_LOCATION_CODE
,priceBreaksE0.QUANTITY RES_QUANTITY
,(SELECT UNIT_OF_MEASURE
	FROM INV_UNITS_OF_MEASURE
	WHERE UOM_CODE = priceBreaksE0.UOM_CODE
	) RES_UOM
,priceBreaksE0.PRICE_OVERRIDE RES_PRICE
,priceBreaksE0.PRICE_DISCOUNT RES_DISCOUNT_PERCENT
,TO_CHAR(priceBreaksE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(priceBreaksE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,priceBreaksE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,priceBreaksE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,priceBreaksE0.CREATED_BY RSC_CREATED_BY
,priceBreaksE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,poHeadersE0.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM PO_HEADERS_ALL poHeadersE0
,PO_LINES_ALL poLinesE0
,PO_LINE_LOCATIONS_ALL priceBreaksE0
,HR_LOCATIONS_ALL locationsE0
WHERE poHeadersE0.TYPE_LOOKUP_CODE IN ('BLANKET','CONTRACT')
AND poHeadersE0.PO_HEADER_ID = poLinesE0.PO_HEADER_ID
AND poLinesE0.PO_HEADER_ID = priceBreaksE0.PO_HEADER_ID
AND poLinesE0.PO_LINE_ID = priceBreaksE0.PO_LINE_ID
AND priceBreaksE0.SHIPMENT_TYPE = 'PRICE BREAK'
AND priceBreaksE0.SHIP_TO_LOCATION_ID = locationsE0.LOCATION_ID(+)
ORDER BY 1,poHeadersE0.SEGMENT1
,poLinesE0.LINE_NUM
,priceBreaksE0.SHIPMENT_NUM