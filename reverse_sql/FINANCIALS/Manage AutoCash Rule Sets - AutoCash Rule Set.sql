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
,arAutocashSetE0.DESCRIPTION RES_DESCRIPTION
,(SELECT SET_NAME
	FROM FND_SETID_SETS
	WHERE SET_ID = arAutocashSetE0.SET_ID
	AND LANGUAGE = USERENV('LANG')
	) RES_SET
,DECODE(arAutocashSetE0.STATUS,'A','Yes','No') RES_ACTIVE
,(SELECT MEANING
	FROM AR_LOOKUPS
	WHERE LOOKUP_TYPE = 'AUTOCASH_DISCOUNTS'
	AND LOOKUP_CODE = arAutocashSetE0.INCLUDE_DISCOUNTS
	) RES_DISCOUNT
,DECODE(arAutocashSetE0.INCLUDE_DISPUTE_ITEMS,'Y','Yes','No') RES_INCLUDE_ITEMS_IN_DISPUTE
,DECODE(arAutocashSetE0.INCLUDE_FINANCE_CHARGES,'Y','Yes','No') RES_INCLUDE_LATE_CHARGES
,(SELECT MEANING
	FROM AR_LOOKUPS
	WHERE LOOKUP_TYPE = 'AUTOCASH_REMAINING_AMOUNT'
	AND LOOKUP_CODE = arAutocashSetE0.REMAINING_AMOUNT
	) RES_REMAINING_REMITTANCE_AMOUN
,DECODE(arAutocashSetE0.APPLY_PARTIAL_PAYMENTS,'Y','Yes','No') RES_APPLY_PARTIAL_RECEIPTS
,arAutocashSetE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,arAutocashSetE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,arAutocashSetE0.CREATED_BY  RSC_CREATED_BY
,arAutocashSetE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AR_AUTOCASH_HIERARCHIES arAutocashSetE0
ORDER BY arAutocashSetE0.HIERARCHY_NAME