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

SELECT (SELECT DESCRIPTION
	FROM FND_LANGUAGES_VL
	WHERE LANGUAGE_CODE = setupsE0.LANGUAGES
	) RES_LANGUAGE
,(SELECT DECODE(VALUE,'Y','Yes','No')
	FROM WLF_PROPERTIES
	WHERE NAME = 'KEYWORD_SEARCH_OVERRIDE_MIN_CHARACTERS_'||setupsE0.LANGUAGES
	) RES_OVERRIDE_THE_DEFAULT_3_CHA -- Override the default 3 character minimum search string requirement.
,(SELECT VALUE
	FROM WLF_PROPERTIES
	WHERE NAME = 'KEYWORD_SEARCH_MIN_CHARACTERS_'||setupsE0.LANGUAGES
	) RES_CHARACTER_MINIMUM_SEARCH_R -- Character minimum search requirement
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
	,REPLACE(NAME,'KEYWORD_SEARCH_OVERRIDE_MIN_CHARACTERS_',NULL) LANGUAGES
	,ROW_NUMBER() OVER (ORDER BY LAST_UPDATE_DATE DESC) R1
	FROM WLF_PROPERTIES 
	WHERE NAME LIKE 'KEYWORD_SEARCH_OVERRIDE_MIN_CHARACTERS%'
	) setupsE0
ORDER BY 1