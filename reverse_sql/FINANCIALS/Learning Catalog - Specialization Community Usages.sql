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

SELECT learningTlE0.NAME RES_SPECIALIZATION_TITLE
,commsE0.NAME RES_COMMUNITY_TITLE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_COMMUNITY_TYPE_CODE'
    AND LOOKUP_CODE = (SELECT COMMUNITY_TYPE 
		FROM WLF_LI_COMMUNITIES_F
		WHERE SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
		AND LEARNING_ITEM_ID = commsE0.LEARNING_ITEM_ID)
	) RES_COMMUNITY_TYPE
,commsE0.LEARNING_ITEM_NUMBER RES_COMMUNITY_NUMBER
,learningE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,learningE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,learningE0.CREATED_BY  RSC_CREATED_BY
,learningE0.CREATION_DATE  RSC_CREATION_DATE
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
,WLF_LI_SPECIALIZATIONS_F learningDtlsE0

,WLF_LI_HIERARCHIES_F lrnCommsE0
,WLF_LEARNING_ITEMS_F_VL commsE0

WHERE learningE0.LEARNING_ITEM_TYPE = 'ORA_SPECIALIZATION'
AND SYSDATE BETWEEN learningE0.EFFECTIVE_START_DATE AND learningE0.EFFECTIVE_END_DATE

AND learningE0.LEARNING_ITEM_ID = learningTlE0.LEARNING_ITEM_ID
AND learningE0.EFFECTIVE_START_DATE = learningTlE0.EFFECTIVE_START_DATE
AND learningTlE0.LANGUAGE = USERENV('LANG')

AND learningE0.LEARNING_ITEM_ID = learningDtlsE0.LEARNING_ITEM_ID
AND learningE0.EFFECTIVE_END_DATE BETWEEN learningDtlsE0.EFFECTIVE_START_DATE AND learningDtlsE0.EFFECTIVE_END_DATE

AND learningE0.LEARNING_ITEM_ID = lrnCommsE0.CHILD_LEARNING_ITEM_ID
AND learningE0.EFFECTIVE_END_DATE BETWEEN lrnCommsE0.EFFECTIVE_START_DATE AND lrnCommsE0.EFFECTIVE_END_DATE

AND lrnCommsE0.LEARNING_ITEM_ID = commsE0.LEARNING_ITEM_ID
AND learningE0.EFFECTIVE_END_DATE BETWEEN commsE0.EFFECTIVE_START_DATE AND commsE0.EFFECTIVE_END_DATE

ORDER BY learningE0.LEARNING_ITEM_NUMBER