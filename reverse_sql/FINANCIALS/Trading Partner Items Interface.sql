/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Units%20of%20Measure%20Profiles%20-%20Profile%20Values.sql $:
 * $Id: Manage Units of Measure Profiles - Profile Values.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=EGP_SYSTEM_ITEMS_B
-- STRICTLY_BATCH_SEQ = RES_TRADING_PARTNER_ITEM_NUMBE

SELECT /*+ PARALLEL(8) */ 'CREATE' RES_TRANSACTION_TYPE
,'' RES_BATCH_ID
,'' RES_BATCH_NUMBER
,tradingPartnersE0.TP_ITEM_NUMBER RES_TRADING_PARTNER_ITEM_NUMBE
,tradingPartnersE0.TP_ITEM_DESC RES_TRADING_PARTNER_ITEM_DESCR
,tradingPartnersE0.TP_TYPE RES_TRADING_PARTNER_TYPE
,ptyE0.PARTY_NUMBER RES_TRADING_PARTNER_NUMBER
,TO_CHAR(tradingPartnersE0.START_DATE,'YYYY/MM/DD') RES_START_DATE
,TO_CHAR(tradingPartnersE0.END_DATE,'YYYY/MM/DD') RES_END_DATE
,(SELECT UNIT_OF_MEASURE 
	FROM INV_UNITS_OF_MEASURE_VL
	WHERE UOM_CODE = tradingPartnersE0.TP_ITEM_UOM_CODE
	) RES_UNIT_OF_MEASURE
,tradingPartnersE0.UNIT_PRICE_AMT RES_UNIT_PRICE
,tradingPartnersE0.UNIT_PRICE_CURRENCY_CODE RES_CURRENCY
,tradingPartnersE0.AVERAGE_RATING_NUMBER RES_RATING
,tradingPartnersE0.ATTRIBUTE_CATEGORY RES_ATTRIBUTE_CATEGORY
,tradingPartnersE0.ATTRIBUTE1 RES_ATTRIBUTE1
,tradingPartnersE0.ATTRIBUTE2 RES_ATTRIBUTE2
,tradingPartnersE0.ATTRIBUTE3 RES_ATTRIBUTE3
,tradingPartnersE0.ATTRIBUTE4 RES_ATTRIBUTE4
,tradingPartnersE0.ATTRIBUTE5 RES_ATTRIBUTE5
,tradingPartnersE0.ATTRIBUTE6 RES_ATTRIBUTE6
,tradingPartnersE0.ATTRIBUTE7 RES_ATTRIBUTE7
,tradingPartnersE0.ATTRIBUTE8 RES_ATTRIBUTE8
,tradingPartnersE0.ATTRIBUTE9 RES_ATTRIBUTE9
,tradingPartnersE0.ATTRIBUTE10 RES_ATTRIBUTE10
,tradingPartnersE0.ATTRIBUTE11 RES_ATTRIBUTE11
,tradingPartnersE0.ATTRIBUTE12 RES_ATTRIBUTE12
,tradingPartnersE0.ATTRIBUTE13 RES_ATTRIBUTE13
,tradingPartnersE0.ATTRIBUTE14 RES_ATTRIBUTE14
,tradingPartnersE0.ATTRIBUTE15 RES_ATTRIBUTE15
,tradingPartnersE0.ATTRIBUTE16 RES_ATTRIBUTE16 --> NEW
,tradingPartnersE0.ATTRIBUTE17 RES_ATTRIBUTE17 --> NEW
,tradingPartnersE0.ATTRIBUTE18 RES_ATTRIBUTE18 --> NEW
,tradingPartnersE0.ATTRIBUTE19 RES_ATTRIBUTE19 --> NEW
,tradingPartnersE0.ATTRIBUTE20 RES_ATTRIBUTE20 --> NEW
,tradingPartnersE0.ATTRIBUTE21 RES_ATTRIBUTE21 --> NEW
,tradingPartnersE0.ATTRIBUTE22 RES_ATTRIBUTE22 --> NEW
,tradingPartnersE0.ATTRIBUTE23 RES_ATTRIBUTE23 --> NEW
,tradingPartnersE0.ATTRIBUTE24 RES_ATTRIBUTE24 --> NEW
,tradingPartnersE0.ATTRIBUTE25 RES_ATTRIBUTE25 --> NEW
,tradingPartnersE0.ATTRIBUTE26 RES_ATTRIBUTE26 --> NEW
,tradingPartnersE0.ATTRIBUTE27 RES_ATTRIBUTE27 --> NEW
,tradingPartnersE0.ATTRIBUTE28 RES_ATTRIBUTE28 --> NEW
,tradingPartnersE0.ATTRIBUTE29 RES_ATTRIBUTE29 --> NEW
,tradingPartnersE0.ATTRIBUTE30 RES_ATTRIBUTE30 --> NEW
,tradingPartnersE0.ATTRIBUTE_NUMBER1 RES_ATTRIBUTE_NUMBER1
,tradingPartnersE0.ATTRIBUTE_NUMBER2 RES_ATTRIBUTE_NUMBER2
,tradingPartnersE0.ATTRIBUTE_NUMBER3 RES_ATTRIBUTE_NUMBER3
,tradingPartnersE0.ATTRIBUTE_NUMBER4 RES_ATTRIBUTE_NUMBER4
,tradingPartnersE0.ATTRIBUTE_NUMBER5 RES_ATTRIBUTE_NUMBER5
,tradingPartnersE0.ATTRIBUTE_NUMBER6 RES_ATTRIBUTE_NUMBER6
,tradingPartnersE0.ATTRIBUTE_NUMBER7 RES_ATTRIBUTE_NUMBER7
,tradingPartnersE0.ATTRIBUTE_NUMBER8 RES_ATTRIBUTE_NUMBER8
,tradingPartnersE0.ATTRIBUTE_NUMBER9 RES_ATTRIBUTE_NUMBER9
,tradingPartnersE0.ATTRIBUTE_NUMBER10 RES_ATTRIBUTE_NUMBER10
,TO_CHAR(tradingPartnersE0.ATTRIBUTE_DATE1,'YYYY/MM/DD') RES_ATTRIBUTE_DATE1
,TO_CHAR(tradingPartnersE0.ATTRIBUTE_DATE2,'YYYY/MM/DD') RES_ATTRIBUTE_DATE2
,TO_CHAR(tradingPartnersE0.ATTRIBUTE_DATE3,'YYYY/MM/DD') RES_ATTRIBUTE_DATE3
,TO_CHAR(tradingPartnersE0.ATTRIBUTE_DATE4,'YYYY/MM/DD') RES_ATTRIBUTE_DATE4
,TO_CHAR(tradingPartnersE0.ATTRIBUTE_DATE5,'YYYY/MM/DD') RES_ATTRIBUTE_DATE5
,tradingPartnersE0.ATTRIBUTE_TIMESTAMP1 RES_ATTRIBUTE_TIMESTAMP1
,tradingPartnersE0.ATTRIBUTE_TIMESTAMP2 RES_ATTRIBUTE_TIMESTAMP2
,tradingPartnersE0.ATTRIBUTE_TIMESTAMP3 RES_ATTRIBUTE_TIMESTAMP3
,tradingPartnersE0.ATTRIBUTE_TIMESTAMP4 RES_ATTRIBUTE_TIMESTAMP4
,tradingPartnersE0.ATTRIBUTE_TIMESTAMP5 RES_ATTRIBUTE_TIMESTAMP5
,tradingPartnersE0.PART_STATUS_CODE RES_TRADING_PARTNER_ITEM_STATU --> NEW TRADING PARTNER ITEM STATUS
,'' RES_NEW_TRADING_PARTNER_ITEM_N
,tradingPartnersE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,tradingPartnersE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,tradingPartnersE0.CREATED_BY  RSC_CREATED_BY
,tradingPartnersE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_TRADING_PARTNER_ITEMS tradingPartnersE0
,HZ_PARTIES ptyE0
WHERE tradingPartnersE0.TRADING_PARTNER_ID = ptyE0.PARTY_ID