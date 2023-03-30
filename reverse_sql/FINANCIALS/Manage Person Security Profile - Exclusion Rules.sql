/* ****************************************************************************
* $Revision: 73528 $:
* $Author: tanawat.wongjan $:
* $Date: 2020-02-14 15:51:08 +0700 (Fri, 14 Feb 2020) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Person%20Security%20Profile%20-%20Exclusion%20Rules.sql $:
* $Id: Manage Person Security Profile - Exclusion Rules.sql 73528 2020-02-14 08:51:08Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PER_PRSN_SEC_PROF_EXCLUSIONS

SELECT perSecPflsE0.NAME RES_NAME
,(SELECT NAME 
	FROM PER_EXCLUSION_RULES 
	WHERE EXCLUSION_RULE_ID =exclusionsE0.EXCLUSION_RULE_ID 
	) RES_EXCLUSION_RULE
,'Yes' RES_ENABLED
,exclusionsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,exclusionsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,exclusionsE0.CREATED_BY  RSC_CREATED_BY
,exclusionsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_PERSON_SECURITY_PROFILES perSecPflsE0
,PER_PRSN_SEC_PROF_EXCLUSIONS exclusionsE0
WHERE perSecPflsE0.PERSON_SECURITY_PROFILE_ID = exclusionsE0.PERSON_SECURITY_PROFILE_ID
ORDER BY perSecPflsE0.NAME