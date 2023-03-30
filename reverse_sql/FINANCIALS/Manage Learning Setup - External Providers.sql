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

SELECT 'YouTube Video Search' RES_PROVIDER
,'' RES_DESCRIPTION
,DECODE(setupsE0.VALUE,'true','Active','Inactive') RES_STATUS

,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'mediasearch.youtube.key'
	) RES_YOUTUBE_API_KEY
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'mediasearch.youtube.maxResults'
	) RES_RESULT_SET_LIMIT
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_PROVIDER_SS_MODE'
    AND LOOKUP_CODE = (SELECT VALUE
		FROM WLF_PROPERTIES
		WHERE NAME = 'mediasearch.youtube.safeSearch')
	) RES_SAFE_SEARCH_MODE
,(SELECT MEANING
    FROM FND_LOOKUP_VALUES
    WHERE LANGUAGE = USERENV('LANG')
    AND LOOKUP_TYPE = 'ORA_WLF_PROVIDER_LIC_TYPE'
    AND LOOKUP_CODE = (SELECT VALUE
		FROM WLF_PROPERTIES
		WHERE NAME = 'mediasearch.youtube.license')
	) RES_VIDEO_LICENSE_TYPE
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'mediasearch.youtube.channelId'
	) RES_PUBLISHER_ID_FILTER
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'mediasearch.youtube.regionCode'
	) RES_REGION_CODE_FILTER

,'' RES_LINKEDIN_LEARNING_PROVIDER -- LinkedIn Learning - Provider Account Number
,'' RES_LINKEDIN_LEARNING_STATUS
,'' RES_LINKEDIN_LEARNING_CLIENT_I -- LinkedIn Learning - Client ID
,'' RES_LINKEDIN_LEARNING_CLIENT_S -- LinkedIn Learning - Client Secret
,'' RES_LINKEDIN_LEARNING_LAST_SYN -- LinkedIn Learning - Last Synced
,'' RES_LINKEDIN_LEARNING_AUTOMATI -- LinkedIn Learning - Automatically import new assets to the learning catalog
,'' RES_LINKEDIN_LEARNING_AUTOMA_0 -- LinkedIn Learning - Automatically import modified assets to the learning catalog
,'' RES_LINKEDIN_LEARNING_AUTOMA_1 -- LinkedIn Learning - Automatically retire assets from the learning catalog

,'' RES_SKILLSOFT_PROVIDER_ACCOUNT -- Skillsoft - Provider Account Number
,'' RES_SKILLSOFT_STATUS
,'' RES_SKILLSOFT_PROVIDER_URL
,'' RES_SKILLSOFT_COMPANY_ID
,'' RES_SKILLSOFT_SHARED_KEY
,'' RES_SKILLSOFT_LAST_SYNCED
,'' RES_SKILLSOFT_ADMINISTRATOR_AC -- Skillsoft - Administrator Account
,'' RES_SKILLSOFT_AUTOMATICALLY_IM -- Skillsoft - Automatically import new assets to the learning catalog
,'' RES_SKILLSOFT_AUTOMATICALLY__2 -- Skillsoft - Automatically import modified assets to the learning catalog
,'' RES_SKILLSOFT_AUTOMATICALLY_RE -- Skillsoft - Automatically retire assets from the learning catalog

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
	,VALUE
	FROM WLF_PROPERTIES 
	WHERE NAME = 'mediasearch.youtube.enabled'
	) setupsE0

UNION

SELECT 'Skillsoft' RES_PROVIDER
,NULL RES_DESCRIPTION
,NULL RES_STATUS
,NULL RES_YOUTUBE_API_KEY
,NULL RES_RESULT_SET_LIMIT
,NULL RES_SAFE_SEARCH_MODE
,NULL RES_VIDEO_LICENSE_TYPE
,NULL RES_PUBLISHER_ID_FILTER
,NULL RES_REGION_CODE_FILTER

,'' RES_LINKEDIN_LEARNING_PROVIDER -- LinkedIn Learning - Provider Account Number
,'' RES_LINKEDIN_LEARNING_STATUS
,'' RES_LINKEDIN_LEARNING_CLIENT_I -- LinkedIn Learning - Client ID
,'' RES_LINKEDIN_LEARNING_CLIENT_S -- LinkedIn Learning - Client Secret
,'' RES_LINKEDIN_LEARNING_LAST_SYN -- LinkedIn Learning - Last Synced
,'' RES_LINKEDIN_LEARNING_AUTOMATI -- LinkedIn Learning - Automatically import new assets to the learning catalog
,'' RES_LINKEDIN_LEARNING_AUTOMA_0 -- LinkedIn Learning - Automatically import modified assets to the learning catalog
,'' RES_LINKEDIN_LEARNING_AUTOMA_1 -- LinkedIn Learning - Automatically retire assets from the learning catalog

,'' RES_SKILLSOFT_PROVIDER_ACCOUNT -- Skillsoft - Provider Account Number
,DECODE(setupsE0.VALUE,'true','Active','Inactive') RES_SKILLSOFT_STATUS
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'mediasearch.skillsoft.url'
	) RES_SKILLSOFT_PROVIDER_URL
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'mediasearch.skillsoft.companyid'
	) RES_SKILLSOFT_COMPANY_ID
,'' RES_SKILLSOFT_SHARED_KEY
,'' RES_SKILLSOFT_LAST_SYNCED
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'mediasearch.skillsoft.userGrpId'
	) RES_SKILLSOFT_ADMINISTRATOR_AC -- Skillsoft - Administrator Account
,'' RES_SKILLSOFT_AUTOMATICALLY_IM -- Skillsoft - Automatically import new assets to the learning catalog
,'' RES_SKILLSOFT_AUTOMATICALLY__2 -- Skillsoft - Automatically import modified assets to the learning catalog
,'' RES_SKILLSOFT_AUTOMATICALLY_RE -- Skillsoft - Automatically retire assets from the learning catalog

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
	,VALUE
	FROM WLF_PROPERTIES 
	WHERE NAME = 'mediasearch.skillsoft.enabled'
	) setupsE0