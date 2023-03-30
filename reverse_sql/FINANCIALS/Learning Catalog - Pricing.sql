/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WLF_LEARNING_ITEMS_F

SELECT learningTlE0.NAME RES_COURSE_TITLE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_PRICING_TYPE'
    AND LOOKUP_CODE = pricingLinesE0.PRICING_TYPE
	) RES_LINE_ITEM
,pricingLinesE0.PRICE RES_PRICE
,DECODE(pricingLinesE0.IS_REQUIRED,'Y','Yes','No') RES_REQUIRED
,DECODE(pricingLinesE0.USED_IN_CALC,'Y','Yes','No') RES_USE_TO_CALCULATE_CATALOG_I -- Use to Calculate Catalog Item Price in Self-Service
,pricingE0.CURRENCY RES_CURRENCY
,pricingLinesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pricingLinesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pricingLinesE0.CREATED_BY  RSC_CREATED_BY
,pricingLinesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WLF_LEARNING_ITEMS_F_TL learningTlE0
,WLF_LEARNING_ITEMS_F learningE0
,(SELECT * 
	FROM WLF_PRICING_RULES_F 
	WHERE USAGE = 'ORA_COURSE'
	) pricingE0
	
,WLF_PRICING_COMPONENTS_F pricingLinesE0

WHERE learningE0.LEARNING_ITEM_TYPE = 'ORA_COURSE'
AND SYSDATE BETWEEN learningE0.EFFECTIVE_START_DATE AND learningE0.EFFECTIVE_END_DATE

AND learningE0.LEARNING_ITEM_ID = learningTlE0.LEARNING_ITEM_ID
AND learningE0.EFFECTIVE_START_DATE = learningTlE0.EFFECTIVE_START_DATE
AND learningTlE0.LANGUAGE = USERENV('LANG')

AND learningE0.PRICING_RULE_ID = pricingE0.PRICING_RULE_ID
AND pricingE0.PRICING_RULE_ID = pricingLinesE0.PRICING_RULE_ID
ORDER BY learningE0.LEARNING_ITEM_NUMBER