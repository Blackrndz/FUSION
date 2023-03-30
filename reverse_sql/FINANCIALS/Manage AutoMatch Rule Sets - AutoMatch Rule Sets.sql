/* ****************************************************************************
 * $Revision: 60934 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 18:30:12 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20AutoPost%20Criteria%20Sets%20-%20AutoPost%20Criteria%20Sets.sql $:
 * $Id: Manage AutoPost Criteria Sets - AutoPost Criteria Sets.sql 60934 2017-02-06 11:30:12Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT (SELECT SET_NAME 
	FROM FND_SETID_SETS
	WHERE SET_ID = arAutoMatchRulesE0.SET_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_SET
,arAutoMatchRulesE0.NAME RES_NAME
,arAutoMatchRulesE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(arAutoMatchRulesE0.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(arAutoMatchRulesE0.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,DECODE(arAutoMatchRulesE0.ACTIVE_FLAG,'Y','Yes','No') RES_ACTIVE
,arAutoMatchRulesE0.CUSTOMER_THRESHOLD RES_CUSTOMER_RECOMMENDATION_TH
,arAutoMatchRulesE0.MIN_MATCH_THRESHOLD RES_MINIMUM_MATCH_THRESHOLD
,arAutoMatchRulesE0.TRANSACTION_THRESHOLD RES_COMBINED_WEIGHTED_THRESHOL
,arAutoMatchRulesE0.NUMBER_OF_DAYS_CLOSED RES_DAYS_OF_CLOSED_INVOICES_TH
,arAutoMatchRulesE0.CUSTOMER_WEIGHT RES_CUSTOMER_WEIGHT
,arAutoMatchRulesE0.TRANSACTION_WEIGHT RES_TRANSACTION_WEIGHT
,arAutoMatchRulesE0.AMOUNT_WEIGHT RES_AMOUNT_WEIGHT
,'100' RES_TOTAL
,arAutoMatchRulesE0.NET_TAX_WEIGHT RES_NET_OF_TAX_WEIGHT
,arAutoMatchRulesE0.NET_TAX_FREIGHT_WEIGHT RES_NET_OF_TAX_AND_FREIGHT_WEI
,arAutoMatchRulesE0.NET_FREIGHT_WEIGHT RES_NET_OF_FREIGHT_WEIGHT
,arAutoMatchRulesE0.NET_UNDISC_WEIGHT RES_UNEARNED_DISCOUNT_WEIGHT
,arAutoMatchRulesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,arAutoMatchRulesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,arAutoMatchRulesE0.CREATED_BY RSC_CREATED_BY
,arAutoMatchRulesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_AUTOMATCH_RULES arAutoMatchRulesE0
ORDER BY arAutoMatchRulesE0.NAME