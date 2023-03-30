/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-04-25 $:
 * $HeadURL: $:
 * $Id: Manage Lot Grades - Lot Grades.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PaymentSystemsE0.NAME RES_PAYMENT_SYSTEM_NAME
,(SELECT TRANSMIT_PROTOCOL_NAME
	FROM IBY_TRANSMIT_PROTOCOLS_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND TRANSMIT_PROTOCOL_CODE = PaymentSystemTransmissionE0.TRANSMIT_PROTOCOL_CODE
	) RES_NAME
,PaymentSystemTransmissionE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PaymentSystemTransmissionE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PaymentSystemTransmissionE0.CREATED_BY RSC_CREATED_BY
,PaymentSystemTransmissionE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_BEPINFO PaymentSystemsE0
,IBY_PMT_SYS_TRANSMISSIONS PaymentSystemTransmissionE0
WHERE PaymentSystemsE0.BEPID = PaymentSystemTransmissionE0.BEPID
ORDER BY PaymentSystemsE0.NAME
,RES_NAME