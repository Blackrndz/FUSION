/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoAccounting%20Rules%20-%20Segments.sql $:
 * $Id: Manage AutoAccounting Rules - Segments.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT arAutocashSetE0.HIERARCHY_NAME RES_NAME
,arAutocashRulesE0.RULE_SEQUENCE RES_SEQUENCE
,(SELECT MEANING
  FROM AR_LOOKUPS
  WHERE LOOKUP_TYPE = 'AUTOCASH_RULE'
  AND LOOKUP_CODE = arAutocashRulesE0.AUTOCASH_RULE
  ) RES_RULE
,arAutocashRulesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,arAutocashRulesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,arAutocashRulesE0.CREATED_BY  RSC_CREATED_BY
,arAutocashRulesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_AUTOCASH_HIERARCHIES arAutocashSetE0
,AR_AUTOCASH_RULES arAutocashRulesE0
WHERE arAutocashSetE0.AUTOCASH_HIERARCHY_ID = arAutocashRulesE0.AUTOCASH_HIERARCHY_ID
ORDER BY arAutocashSetE0.HIERARCHY_NAME
,arAutocashRulesE0.RULE_SEQUENCE