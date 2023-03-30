 /* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Customer%20Profile%20Classes%20-%20Profile%20Class.sql $:
 * $Id: Manage Receivables Customer Profile Classes - Profile Class.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT HzCustProfileClasses.NAME AS RES_PROFILE_CLASS_NAME
,ArCollectors.NAME AS RES_COLLECTOR
,(SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'AR_CMGT_CREDIT_CLASSIFICATION'
	AND LOOKUP_CODE   = HzCustProfileClasses.CREDIT_CLASSIFICATION
	) AS RES_CREDIT_CLASSIFICATION
,DECODE(HzCustProfileClasses.CREDIT_CURRENCY_CODE,NULL,NULL,(HzCustProfileClasses.CREDIT_CURRENCY_CODE||' - '||
	(SELECT NAME FROM FND_CURRENCIES_TL
	WHERE CURRENCY_CODE = HzCustProfileClasses.CREDIT_CURRENCY_CODE
	AND LANGUAGE = USERENV('LANG'))
	)) AS RES_CREDIT_LIMIT
,HzCustProfileClasses.CREDIT_LIMIT AS RES_CREDIT_LIMIT_AMOUNT
,HzCustProfileClasses.TOLERANCE AS RES_TOLERANCE
,(SELECT USER_CONVERSION_TYPE 
	FROM GL_DAILY_CONVERSION_TYPES
	WHERE CONVERSION_TYPE = HzCustProfileClasses.EXCHANGE_RATE_TYPE
	) AS RES_CONVERSION_RATE_TYPE
,NVL((SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = HzCustProfileClasses.CREDIT_CHECKING
	),'No') AS RES_INCLUDE_IN_CREDIT_CHECK
,HzCustProfileClasses.OFFSET_DAYS RES_EXPIRATION_OFFSET_DAYS
,NVL((SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = NVL(HzCustProfileClasses.CONS_INV_FLAG,'N')
	),'No') AS RES_ENABLE
,(SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'HZ_CONS_BILL_LEVEL'
	AND LOOKUP_CODE   = HzCustProfileClasses.CONS_BILL_LEVEL
	) AS RES_BILL_LEVEL
,(SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'HZ_CONS_INV_TYPE'
	AND LOOKUP_CODE   = HzCustProfileClasses.CONS_INV_TYPE
	) AS RES_BILL_TYPE
,RaTermsVl.NAME AS RES_PAYMENT_TERMS
,(select distinct SET_NAME from FUSION.FND_SETID_SETS_VL SetIdSetPEO where SetIdSetPEO.set_id = RaTermsVl.set_id) RES_PAYMENT_TERMS_SET_NAME
,HzCustProfileClasses.DISCOUNT_GRACE_DAYS AS RES_DISCOUNT_GRACE_DAYS
,NVL((SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = HzCustProfileClasses.DISCOUNT_TERMS
	),'No') AS RES_ALLOW_DISCOUNT
,NVL((SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = HzCustProfileClasses.OVERRIDE_TERMS
	),'No') AS RES_OVERRIDE_TERMS
,(SELECT distinct meaning
	FROM FND_LOOKUP_VALUES
	WHERE lookup_type = 'ARLPLB_MATCHING_OPTION'
	AND lookup_code   = HzCustProfileClasses.LOCKBOX_MATCHING_OPTION
	AND LANGUAGE = USERENV('LANG')
	) AS RES_MATCH_RECEIPTS_BY
,(SELECT distinct SETS.SET_NAME
	FROM FND_LOOKUP_VALUES LKP
	,FND_SETID_SETS SETS
	WHERE lookup_type = 'ARLPLB_MATCHING_OPTION'
	AND lookup_code   = HzCustProfileClasses.LOCKBOX_MATCHING_OPTION
	AND SETS.SET_ID             = LKP.SET_ID
	AND LKP.LANGUAGE = USERENV('LANG')
	AND SETS.LANGUAGE = USERENV('LANG')
	) AS RES_MATCH_RECEIPTS_BY_SET_NAME
,AutomatchRuleEO.NAME AS RES_AUTOMATCH_RULE_SET
,(select distinct SET_NAME from FUSION.FND_SETID_SETS_VL SetIdSetPEO where SetIdSetPEO.set_id = AutomatchRuleEO.set_id) RES_AUTOMATCH_RULE_SET_SET_NAM
,NVL((SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = NVL(HzCustProfileClasses.MATCH_BY_AUTOUPDATE_FLAG,'N')
	),'No') AS RES_AUTOMATICALLY_UPDATE_RECEI
,ArAutocashHierarchies.HIERARCHY_NAME AS RES_AUTOCASH_RULE_SET
,(select distinct SET_NAME from FUSION.FND_SETID_SETS_VL SetIdSetPEO where SetIdSetPEO.set_id = ArAutocashHierarchies.set_id) RES_AUTOCASH_RULE_SET_SET_NAME
,ArAutocashHierarchies1.HIERARCHY_NAME AS RES_REMAINDER_RULE_SET
,(select distinct SET_NAME from FUSION.FND_SETID_SETS_VL SetIdSetPEO where SetIdSetPEO.set_id = ArAutocashHierarchies1.set_id) RES_REMAINDER_RULE_SET_SET_NAM
,ExceptionRuleEO.NAME                  AS RES_APPLICATION_EXCEPTION_RULE
,(select distinct SET_NAME from FUSION.FND_SETID_SETS_VL SetIdSetPEO where SetIdSetPEO.set_id = ExceptionRuleEO.set_id)  RES_APPLICATION_EXCEPTION_RU_0
,NVL((SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = HzCustProfileClasses.AUTO_REC_INCL_DISPUTED_FLAG
	),'No') AS RES_AUTORECEIPTS_INCLUDE_DISPU
,NVL((SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = HzCustProfileClasses.STATEMENTS
	),'No') AS RES_SEND_STATEMENT
,(SELECT distinct NAME
	FROM ar_statement_cycles
	WHERE statement_cycle_id = HzCustProfileClasses.STATEMENT_CYCLE_ID
	) AS RES_STATEMENT_CYCLE
,NVL((SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = HzCustProfileClasses.CREDIT_BALANCE_STATEMENTS
	),'No') AS RES_SEND_CREDIT_BALANCE
,NVL((SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = HzCustProfileClasses.DUNNING_LETTERS
	),'No') AS RES_SEND_DUNNING_LETTERS
,(SELECT distinct MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'AR_CUST_PREF_CONTACT_METHOD'
	AND LOOKUP_CODE   = HzCustProfileClasses.PREF_CONTACT_METHOD
	) AS RES_PREFERRED_CONTACT_METHOD
,(SELECT distinct NAME
	FROM ra_grouping_rules
	WHERE GROUPING_RULE_ID = HzCustProfileClasses.GROUPING_RULE_ID
	) AS RES_GROUPING_RULE
,HzCustProfileClasses.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,HzCustProfileClasses.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,HzCustProfileClasses.CREATED_BY  RSC_CREATED_BY
,HzCustProfileClasses.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_CUST_PROFILE_CLASSES HzCustProfileClasses
,RA_TERMS_VL RaTermsVl
,AR_COLLECTORS ArCollectors
,AR_AUTOCASH_HIERARCHIES ArAutocashHierarchies
,AR_AUTOCASH_HIERARCHIES ArAutocashHierarchies1
,AR_AUTOMATCH_RULES AutomatchRuleEO
,AR_APP_EXCEPTION_RULES ExceptionRuleEO
WHERE((((HzCustProfileClasses.STANDARD_TERMS           = RaTermsVl.TERM_ID(+))
AND(HzCustProfileClasses.COLLECTOR_ID                  = ArCollectors.COLLECTOR_ID(+)))
AND(HzCustProfileClasses.AUTOCASH_HIERARCHY_ID         = ArAutocashHierarchies.AUTOCASH_HIERARCHY_ID(+)))
AND(HzCustProfileClasses.AUTOCASH_HIERARCHY_ID_FOR_ADR = ArAutocashHierarchies1.AUTOCASH_HIERARCHY_ID(+)))
AND(HzCustProfileClasses.AUTOMATCH_RULE_ID             = AutomatchRuleEO.AUTOMATCH_RULE_ID(+))
AND(HzCustProfileClasses.EXCEPTION_RULE_ID             = ExceptionRuleEO.EXCEPTION_RULE_ID(+)) 
ORDER BY HzCustProfileClasses.NAME