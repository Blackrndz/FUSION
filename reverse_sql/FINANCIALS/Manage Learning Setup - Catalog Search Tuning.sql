/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=WLF_PROPERTIES

SELECT (SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'STOP_WORDS_LEARNING_ITEM_SEEDED'
	) RES_ENABLE_SEEDED_LEARNING_ITE -- Enable Seeded Learning Item Title Stop Words
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'STOP_WORDS_LEARNING_ITEM_TITLE'
	) RES_AUTOMATICALLY_APPEND_THE_W -- Automatically append the wildcard to the end of the search term when searching against the title.
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'KEYWORD_SEARCH_ENABLE_END_WILD_CARD'
	) RES_ENABLE_USER_DEFINED_LEARNI -- Enable User Defined Learning Item Title Stop Words
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'STOP_WORDS_LEARNING_ITEM_DESCRIPTION'
	) RES_ENABLE_USER_DEFINED_LEAR_0 -- Enable User Defined Learning Item Description Stop Words
,setupsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,setupsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,setupsE0.CREATED_BY  RSC_CREATED_BY
,setupsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT LAST_UPDATED_BY
	,LAST_UPDATE_DATE
	,CREATED_BY
	,CREATION_DATE 
	,ROW_NUMBER() OVER (ORDER BY LAST_UPDATE_DATE DESC) R1
	FROM WLF_PROPERTIES 
	) setupsE0
WHERE R1 = 1