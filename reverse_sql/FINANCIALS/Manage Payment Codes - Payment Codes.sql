/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PaymentCodeEO.MEANING RES_NAME
,PaymentCodeEO.PAYMENT_CODE RES_CODE
,DECODE(PaymentCodeEO.PAYMENT_CODE_TYPE,'BANK_INSTRUCTION','Bank instruction','DELIVERY_CHANNEL','Delivery channel',
	'LOCAL_INSTRUMENT','Local instrument','PAYMENT_REASON','Payment reason','SERVICE_LEVEL','Service Level') RES_TYPE
,TO_CHAR(
	CASE
		WHEN SYSDATE BETWEEN PaymentCodeEO.START_DATE AND NVL(TO_CHAR(PaymentCodeEO.End_Date),'31-Dec-4712')
		THEN 'Active'
		ELSE 'Inactive'
	END) RES_STATUS
,PaymentCodeEO.FORMAT_VALUE RES_ALIAS
,TerritoryPEO.TERRITORY_SHORT_NAME RES_COUNTRY
,PaymentCodeEO.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(PaymentCodeEO.START_DATE,'DD-Mon-YYYY') RES_FROM_DATE
,DECODE(Extract(YEAR FROM PaymentCodeEO.End_Date),'4712',NULL,TO_CHAR(PaymentCodeEO.End_Date,'DD-Mon-YYYY'))
	RES_TO_DATE
,PaymentCodeEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PaymentCodeEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PaymentCodeEO.CREATED_BY RSC_CREATED_BY
,PaymentCodeEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IBY_PAYMENT_CODES_VL PaymentCodeEO
,FND_TERRITORIES_VL TerritoryPEO
WHERE PaymentCodeEO.TERRITORY_CODE = TerritoryPEO.TERRITORY_CODE(+)
ORDER BY TerritoryPEO.TERRITORY_SHORT_NAME
,PaymentCodeEO.PAYMENT_CODE