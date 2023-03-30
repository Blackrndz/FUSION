/* ****************************************************************************
 * $Revision: 60934 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 18:30:12 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoPost%20Criteria%20Sets%20-%20AutoPost%20Criteria%20Sets.sql $:
 * $Id: Manage AutoPost Criteria Sets - AutoPost Criteria Sets.sql 60934 2017-02-06 11:30:12Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT arAutoMatchRulesE0.NAME RES_NAME
,arAutoMatchRuleDTLSE0.SEQUENCE_NUMBER RES_LINE_NUMBER
,(SELECT MEANING
	FROM AR_LOOKUPS
	WHERE LOOKUP_TYPE = 'AR_AM_STRING_LOCATION'
	AND LOOKUP_CODE = arAutoMatchRuleDTLSE0.STRING_LOCATION_CODE
	) RES_STRING_LOCATION
,(SELECT MEANING
	FROM AR_LOOKUPS
	WHERE LOOKUP_TYPE = 'AR_AM_STRING_VALUE'
	AND LOOKUP_CODE = arAutoMatchRuleDTLSE0.PADDING_VALUE_CODE
	) RES_STRING_VALUE
,arAutoMatchRuleDTLSE0.NUMBER_OF_POSITIONS RES_NUMBER_OF_CHARACTERS
,arAutoMatchRuleDTLSE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,arAutoMatchRuleDTLSE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,arAutoMatchRuleDTLSE0.CREATED_BY RSC_CREATED_BY
,arAutoMatchRuleDTLSE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_AUTOMATCH_RULES arAutoMatchRulesE0
,AR_AUTOMATCH_RULE_DTLS arAutoMatchRuleDTLSE0
WHERE arAutoMatchRulesE0.AUTOMATCH_RULE_ID = arAutoMatchRuleDTLSE0.AUTOMATCH_RULE_ID 
AND STRING_TYPE_CODE = 'REM'
ORDER BY arAutoMatchRulesE0.NAME
,arAutoMatchRuleDTLSE0.SEQUENCE_NUMBER