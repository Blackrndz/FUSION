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
-- RSC_PREREQUISITE_OBJECTS=WLF_LI_COMMUNITIES_F
-- RSC_PREREQUISITE_OBJECTS=WLF_LEARNING_ITEMS_F_TL

SELECT learningTlE0.NAME RES_COMMUNITY_TITLE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_COMMUNITY_TYPE_CODE'
    AND LOOKUP_CODE = communitiesE0.COMMUNITY_TYPE 
	) RES_COMMUNITY_TYPE
,learningE0.LEARNING_ITEM_NUMBER RES_COMMUNITY_NUMBER
,learningTlE0.DESCRIPTION RES_DESCRIPTION
,'' RES_BRANDING_IMAGE
,'' RES_TRAILER
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_SS_CMNTY_VISIBILITY'
    AND LOOKUP_CODE = learningE0.VISIBILITY 
	) RES_PRIVACY
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_SS_CMNTY_AMU'
    AND LOOKUP_CODE = communitiesE0.ALLOW_MEMBER_UPLOADS 
	) RES_MEMBER_CONTRIBUTIONS
,DECODE(communitiesE0.IS_FORUM_DEFAULT_OVERRIDDEN,'Y','Yes','No') RES_OVERRIDE_CONVERSATION_SYST
,DECODE(communitiesE0.CONVERSATIONS_FLAG,'Y','Yes','No') RES_ENABLE_CONVERSATIONS_FOR_S
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
,WLF_LI_COMMUNITIES_F communitiesE0

WHERE learningE0.LEARNING_ITEM_TYPE = 'ORA_COMMUNITY'

AND learningE0.LEARNING_ITEM_ID = learningTlE0.LEARNING_ITEM_ID
AND learningE0.EFFECTIVE_START_DATE = learningTlE0.EFFECTIVE_START_DATE
AND learningTlE0.LANGUAGE = USERENV('LANG')

AND learningE0.LEARNING_ITEM_ID = communitiesE0.LEARNING_ITEM_ID
AND learningE0.EFFECTIVE_END_DATE BETWEEN communitiesE0.EFFECTIVE_START_DATE AND communitiesE0.EFFECTIVE_END_DATE

ORDER BY learningE0.LEARNING_ITEM_NUMBER