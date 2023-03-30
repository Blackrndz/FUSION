 /* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Customer%20Profile%20Classes%20-%20Late%20Charges.sql $:
 * $Id: Manage Receivables Customer Profile Classes - Late Charges.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT HzCustProfileClasses.NAME AS RES_PROFILE_CLASS_NAME
,NVL((SELECT MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = HzCustProfileClasses.INTEREST_CHARGES
	),'No') AS RES_ENABLE_LATE_CHARGES
,(SELECT MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'AR_MANDATORY_LATE_CHARGES'
	AND LOOKUP_CODE   = HzCustProfileClasses.LATE_CHARGE_CALCULATION_TRX
	) AS RES_LATE_CHARGE_CALCULATION_ME
,DECODE(HzCustProfileClasses.DISPUTED_TRANSACTIONS_FLAG,'Y',(DECODE(HzCustProfileClasses.CREDIT_ITEMS_FLAG,'Y',
	'Credit Items and Disputed Transactions','N','Disputed Transactions')),'N','Credit Items') AS RES_CHARGE_REDUCTIONS
,(SELECT MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'AR_LATE_CHARGE_TYPE'
	AND LOOKUP_CODE   = HzCustProfileClasses.LATE_CHARGE_TYPE
	)              AS RES_LATE_CHARGE_TYPE
,RaTermsVl.NAME AS RES_PAYMENT_TERMS
,(select SET_NAME from FUSION.FND_SETID_SETS_VL SetIdSetPEO where SetIdSetPEO.set_id = RaTermsVl.set_id) RES_PAYMENT_TERMS_SET_NAME
,(SELECT MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'AR_FORMULAE'
	AND LOOKUP_CODE   = HzCustProfileClasses.CHARGE_ON_FINANCE_CHARGE_FLAG
	) AS RES_INTEREST_CALCULATION_FORMU
,(SELECT MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'AR_CALCULATION_PERIOD'
	AND LOOKUP_CODE   = HzCustProfileClasses.INTEREST_CALCULATION_PERIOD
	) AS RES_INTEREST_CALCULATION_PERIO
,(SELECT MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = NVL(HzCustProfileClasses.MULTIPLE_INTEREST_RATES_FLAG,'N')
	)                                         AS RES_USE_MULTIPLE_INTEREST_RATE
,HzCustProfileClasses.PAYMENT_GRACE_DAYS   AS RES_RECEIPT_GRACE_DAYS
,HzCustProfileClasses.INTEREST_PERIOD_DAYS AS RES_INTEREST_DAYS_PERIOD
,(SELECT MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'YES/NO'
	AND LOOKUP_CODE   = HzCustProfileClasses.HOLD_CHARGED_INVOICES_FLAG
	)                                      AS RES_ASSESS_LATE_CHARGES_ONCE
,TO_CHAR(HzCustProfileClasses.CHARGE_BEGIN_DATE,'DD-Mon-YYYY') AS RES_CHARGE_START_DATE
,HzCustProfileClasses.MESSAGE_TEXT_ID   AS RES_MESSAGE_TEXT
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
WHERE((((HzCustProfileClasses.LATE_CHARGE_TERM_ID           = RaTermsVl.TERM_ID(+))
AND(HzCustProfileClasses.COLLECTOR_ID                  = ArCollectors.COLLECTOR_ID(+)))
AND(HzCustProfileClasses.AUTOCASH_HIERARCHY_ID         = ArAutocashHierarchies.AUTOCASH_HIERARCHY_ID(+)))
AND(HzCustProfileClasses.AUTOCASH_HIERARCHY_ID_FOR_ADR = ArAutocashHierarchies1.AUTOCASH_HIERARCHY_ID(+)))
AND(HzCustProfileClasses.AUTOMATCH_RULE_ID             = AutomatchRuleEO.AUTOMATCH_RULE_ID(+))
AND(HzCustProfileClasses.EXCEPTION_RULE_ID             = ExceptionRuleEO.EXCEPTION_RULE_ID(+))
and  HzCustProfileClasses.INTEREST_CHARGES = 'Y'
order by HZCUSTPROFILECLASSES.name
