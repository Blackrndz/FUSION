/* ****************************************************************************
 * $Revision: 55453 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2016-05-25 18:43:01 +0700 (Wed, 25 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoInvoice%20Line%20Ordering%20Rules%20-%20AutoInvoice%20Line%20Ordering%20Rules.sql $:
 * $Id: Manage AutoInvoice Line Ordering Rules - AutoInvoice Line Ordering Rules.sql 55453 2016-05-25 11:43:01Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=EGP_ITEM_KEYWORD_ATTRS

SELECT DECODE(EgpItemKeywordAttrs.OBJECT_TYPE,'EGO_ITEM_DL','Item','TRADING_PARTNER_ITEM','Trading partner item','ITEM_RELATIONSHIP','Item relationship') RES_OBJECT
,NVL(EgpItemAttributes.ATTR_GROUP_DISP_NAME,KeywordGroupE0.MEANING) RES_KEYWORD_GROUPS
,NVL(EgpItemAttributes.ATTR_DISP_NAME,KeywordARRTE0.MEANING) RES_KEYWORD_ATTRIBUTES
,'Immediately' RES_SCHEDULE_OPTIONS
,'' RES_SCHEDULE_TIME
,EgpItemKeywordAttrs.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,EgpItemKeywordAttrs.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,EgpItemKeywordAttrs.CREATED_BY RSC_CREATED_BY
,EgpItemKeywordAttrs.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_KEYWORD_ATTRS EgpItemKeywordAttrs
,EGP_ITEM_ATTRIBUTES_VL EgpItemAttributes
,(SELECT LOOKUP_CODE	
	,MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_EGP_KEYWORD_ATTRIBUTES'
	)KeywordARRTE0
,(SELECT LOOKUP_CODE	
	,MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ORA_EGP_KEYWORD_GROUPS'
	)KeywordGroupE0 
WHERE EgpItemKeywordAttrs.ATTR_GROUP = EgpItemAttributes.ATTR_GROUP_NAME(+)
AND EgpItemKeywordAttrs.ATTR_CODE = EgpItemAttributes.ATTR_NAME(+)
AND EgpItemKeywordAttrs.ATTR_CODE = KeywordARRTE0.LOOKUP_CODE(+)
AND EgpItemKeywordAttrs.ATTR_GROUP = KeywordGroupE0.LOOKUP_CODE(+)