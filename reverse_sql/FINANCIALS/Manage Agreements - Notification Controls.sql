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
,(SELECT DISPLAYED_FIELD
	FROM PO_LOOKUP_CODES
	WHERE LOOKUP_TYPE = 'NOTIFICATION CONTROL'
	AND LOOKUP_CODE = poNotificationsE0.NOTIFICATION_CONDITION_CODE
	) RES_CONDITION
,(CASE
	WHEN poNotificationsE0.NOTIFICATION_CONDITION_CODE = 'EXPIRATION' THEN
		poNotificationsE0.END_DATE_ACTIVE - poNotificationsE0.START_DATE_ACTIVE
	END) RES_REMINDER_DAYS
,poNotificationsE0.NOTIFICATION_QTY_PERCENTAGE RES_PERCENT
,(CASE
	WHEN INSTR(TO_CHAR(ROUND(poNotificationsE0.NOTIFICATION_AMOUNT,2)),'.',1) = 0 THEN
		TO_CHAR(ROUND(poNotificationsE0.NOTIFICATION_AMOUNT,2))||'.00'
	ELSE
		TO_CHAR(ROUND(poNotificationsE0.NOTIFICATION_AMOUNT,2))
	END) RES_AMOUNT
,TO_CHAR(poNotificationsE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(poNotificationsE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_END_DATE
,poNotificationsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,poNotificationsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,poNotificationsE0.CREATED_BY RSC_CREATED_BY
,poNotificationsE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,poHeadersE0.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM PO_HEADERS_ALL poHeadersE0
,PO_NOTIFICATION_CONTROLS poNotificationsE0
WHERE poHeadersE0.TYPE_LOOKUP_CODE IN ('BLANKET','CONTRACT')
AND poHeadersE0.PO_HEADER_ID = poNotificationsE0.PO_HEADER_ID
ORDER BY 1,poHeadersE0.SEGMENT1