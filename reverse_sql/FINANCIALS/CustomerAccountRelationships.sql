/* ****************************************************************************
 * $Revision: 56649 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2016-07-12 11:20:44 +0700 (Tue, 12 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Currency%20Rates%20Manager%20-%20Rate%20Types.sql $:
 * $Id: Currency Rates Manager - Rate Types.sql 56649 2016-07-12 04:20:44Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- STRICTLY_BATCH_SEQ = RES_ACCOUNT_RELATIONSHIP_SOU_0

SELECT '' RES_BATCH_IDENTIFIER
,'I' RES_INSERT_UPDATE_INDICATOR
,'CUSTOMER' RES_ACCOUNT_RELATIONSHIP_SOURC
,HzCustAcctRelateAllE0.CUST_ACCT_RELATE_ID RES_ACCOUNT_RELATIONSHIP_SOU_0
,'CUSTOMER' RES_CUSTOMER_ACCOUNT_SOURCE_SY
,HzCustAccountsE0.ACCOUNT_NUMBER RES_CUSTOMER_ACCOUNT_SOURCE__1
,'CUSTOMER' RES_RELATED_ACCOUNT_SOURCE_SYS
,HzCustAccountsE1.ACCOUNT_NUMBER RES_RELATED_ACCOUNT_SOURCE_S_2
,HzCustAcctRelateAllE0.RELATIONSHIP_TYPE RES_RELATIONSHIP_TYPE
,HzCustAcctRelateAllE0.CUSTOMER_RECIPROCAL_FLAG RES_RECIPROCAL_INDICATOR
,HzCustAcctRelateAllE0.BILL_TO_FLAG RES_BILL_TO_INDICATOR
,HzCustAcctRelateAllE0.SHIP_TO_FLAG RES_SHIP_TO_INDICATOR
,(SELECT SET_CODE
	FROM FND_SETID_SETS
	WHERE LANGUAGE = USERENV('LANG')
	AND SET_ID = HzCustAcctRelateAllE0.SET_ID
	) RES_ACCOUNT_RELATIONSHIP_SET
,TO_CHAR(HzCustAcctRelateAllE0.START_DATE,'YYYY/MM/DD') RES_FROM_DATE
,DECODE(TO_CHAR(HzCustAcctRelateAllE0.END_DATE,'YYYY/MM/DD'),'4712/12/31',NULL,TO_CHAR(HzCustAcctRelateAllE0.END_DATE,'YYYY/MM/DD')) RES_TO_DATE
,HzCustAcctRelateAllE0.ATTRIBUTE_CATEGORY RES_USER_DEFINED_CONTEXT_PROMP
,HzCustAcctRelateAllE0.ATTRIBUTE1 RES_DESCRIPTIVE_FLEXFIELD_SEGM
,HzCustAcctRelateAllE0.ATTRIBUTE2 RES_DESCRIPTIVE_FLEXFIELD_SE_3
,HzCustAcctRelateAllE0.ATTRIBUTE3 RES_DESCRIPTIVE_FLEXFIELD_SE_4
,HzCustAcctRelateAllE0.ATTRIBUTE4 RES_DESCRIPTIVE_FLEXFIELD_SE_5
,HzCustAcctRelateAllE0.ATTRIBUTE5 RES_DESCRIPTIVE_FLEXFIELD_SE_6
,HzCustAcctRelateAllE0.ATTRIBUTE6 RES_DESCRIPTIVE_FLEXFIELD_SE_7
,HzCustAcctRelateAllE0.ATTRIBUTE7 RES_DESCRIPTIVE_FLEXFIELD_SE_8
,HzCustAcctRelateAllE0.ATTRIBUTE8 RES_DESCRIPTIVE_FLEXFIELD_SE_9
,HzCustAcctRelateAllE0.ATTRIBUTE9 RES_DESCRIPTIVE_FLEXFIELD_S_10
,HzCustAcctRelateAllE0.ATTRIBUTE10 RES_DESCRIPTIVE_FLEXFIELD_S_11
,HzCustAcctRelateAllE0.ATTRIBUTE11 RES_DESCRIPTIVE_FLEXFIELD_S_12
,HzCustAcctRelateAllE0.ATTRIBUTE12 RES_DESCRIPTIVE_FLEXFIELD_S_13
,HzCustAcctRelateAllE0.ATTRIBUTE13 RES_DESCRIPTIVE_FLEXFIELD_S_14
,HzCustAcctRelateAllE0.ATTRIBUTE14 RES_DESCRIPTIVE_FLEXFIELD_S_15
,HzCustAcctRelateAllE0.ATTRIBUTE15 RES_DESCRIPTIVE_FLEXFIELD_S_16
,HzCustAcctRelateAllE0.ATTRIBUTE16 RES_DESCRIPTIVE_FLEXFIELD_S_17
,HzCustAcctRelateAllE0.ATTRIBUTE17 RES_DESCRIPTIVE_FLEXFIELD_S_18
,HzCustAcctRelateAllE0.ATTRIBUTE18 RES_DESCRIPTIVE_FLEXFIELD_S_19
,HzCustAcctRelateAllE0.ATTRIBUTE19 RES_DESCRIPTIVE_FLEXFIELD_S_20
,HzCustAcctRelateAllE0.ATTRIBUTE20 RES_DESCRIPTIVE_FLEXFIELD_S_21
,HzCustAcctRelateAllE0.ATTRIBUTE21 RES_DESCRIPTIVE_FLEXFIELD_S_22
,HzCustAcctRelateAllE0.ATTRIBUTE22 RES_DESCRIPTIVE_FLEXFIELD_S_23
,HzCustAcctRelateAllE0.ATTRIBUTE23 RES_DESCRIPTIVE_FLEXFIELD_S_24
,HzCustAcctRelateAllE0.ATTRIBUTE24 RES_DESCRIPTIVE_FLEXFIELD_S_25
,HzCustAcctRelateAllE0.ATTRIBUTE25 RES_DESCRIPTIVE_FLEXFIELD_S_26
,HzCustAcctRelateAllE0.ATTRIBUTE26 RES_DESCRIPTIVE_FLEXFIELD_S_27
,HzCustAcctRelateAllE0.ATTRIBUTE27 RES_DESCRIPTIVE_FLEXFIELD_S_28
,HzCustAcctRelateAllE0.ATTRIBUTE28 RES_DESCRIPTIVE_FLEXFIELD_S_29
,HzCustAcctRelateAllE0.ATTRIBUTE29 RES_DESCRIPTIVE_FLEXFIELD_S_30
,HzCustAcctRelateAllE0.ATTRIBUTE30 RES_DESCRIPTIVE_FLEXFIELD_S_31
,HzCustAcctRelateAllE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,HzCustAcctRelateAllE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,HzCustAcctRelateAllE0.CREATED_BY RSC_CREATED_BY
,HzCustAcctRelateAllE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_PARTIES HzPartiesE0
,HZ_PARTY_USG_ASSIGNMENTS HzPartyUsgAssignmentsE0
,HZ_CUST_ACCOUNTS HzCustAccountsE0
,HZ_CUST_ACCOUNTS HzCustAccountsE1
,HZ_CUST_ACCT_RELATE_ALL HzCustAcctRelateAllE0
WHERE HzPartiesE0.PARTY_ID = HzPartyUsgAssignmentsE0.PARTY_ID
AND HzPartyUsgAssignmentsE0.PARTY_USAGE_CODE = 'CUSTOMER'
AND HzPartiesE0.PARTY_ID = HzCustAccountsE0.PARTY_ID
AND HzCustAccountsE0.CUST_ACCOUNT_ID = HzCustAcctRelateAllE0.CUST_ACCOUNT_ID
AND HzCustAcctRelateAllE0.RELATED_CUST_ACCOUNT_ID = HzCustAccountsE1.CUST_ACCOUNT_ID