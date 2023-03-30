/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Bank%20Accounts%20-%20Accounts.sql $:
 * $Id: Manage Bank Accounts - Accounts.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=CE_BANK_ACCOUNTS
 
SELECT BankBranchSimplePEO.BANK_NAME RES_BANK
,BankBranchSimplePEO.COUNTRY_NAME RES_COUNTRY
,BankBranchSimplePEO.BANK_BRANCH_NAME RES_BANK_BRANCH
,CeBankAccounts.BANK_ACCOUNT_NAME RES_ACCOUNT_NAME
,CeBankAccounts.BANK_ACCOUNT_NUM RES_ACCOUNT_NUMBER
,DECODE(CeBankAccounts.MULTI_CASH_RECON_ENABLED_FLAG,'Y','Yes','No') RES_ENABLE_MULTIPLE_CASH_ACCOU
,(SELECT KfSegmentE0.NAME
		FROM FND_KF_SEGMENTS_VL KfSegmentE0
		WHERE KfSegmentE0.STRUCTURE_ID = kfstr.STRUCTURE_ID
		AND KfSegmentE0.COLUMN_NAME = (TRIM(REGEXP_SUBSTR(CeBankAccounts.CASH_CCID_FIXED_SEGMENTS, '[^,]+', 1, levels.column_value)))) RES_GL_CASH_ACCOUNT_SEGMENTS
,(CASE WHEN CeBankAccounts.MULTI_CASH_RECON_ENABLED_FLAG = 'Y'
	THEN 'Yes'
	ELSE NULL END) RES_ENABLED

,CeBankAccounts.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CeBankAccounts.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CeBankAccounts.CREATED_BY RSC_CREATED_BY
,CeBankAccounts.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,CeBankAccounts.ACCOUNT_OWNER_ORG_ID RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_BANK_ACCOUNTS CeBankAccounts
,XLE_ENTITY_PROFILES XleEntityProfiles
,CE_BANK_BRANCHES_SIMPLE_V BankBranchSimplePEO
,(SELECT XLEENTITYPROFILES.LEGAL_ENTITY_ID
		,kfstr.STRUCTURE_ID
		from GL_LEDGER_CONFIG_DETAILS GlLedgerConfigDetails
		,XLE_ENTITY_PROFILES XLEENTITYPROFILES
		,GL_LEDGERS GlLedgers
		,FND_KF_STR_INSTANCES_VL kfstr
		WHERE GLLEDGERCONFIGDETAILS.OBJECT_TYPE_CODE = 'LEGAL_ENTITY'
		AND GLLEDGERCONFIGDETAILS.SETUP_STEP_CODE = 'NONE'
		AND XLEENTITYPROFILES.LEGAL_ENTITY_ID = GLLEDGERCONFIGDETAILS.OBJECT_ID
		AND Glledgerconfigdetails.Configuration_Id = Glledgers.Configuration_Id
		AND GLLEDGERS.CHART_OF_ACCOUNTS_ID = kfstr.STRUCTURE_INSTANCE_NUMBER
		AND GLLEDGERS.LEDGER_CATEGORY_CODE = 'PRIMARY') kfstr
 ,table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(CeBankAccounts.CASH_CCID_FIXED_SEGMENTS, '[^,]+'))  + 1) as sys.OdciNumberList)) levels
WHERE((CeBankAccounts.ACCOUNT_OWNER_ORG_ID = XleEntityProfiles.LEGAL_ENTITY_ID)
AND(CeBankAccounts.BANK_BRANCH_ID          = BankBranchSimplePEO.BRANCH_PARTY_ID)
AND NOT EXISTS
	(SELECT xtr.bank_account_id
	FROM ce_bank_accounts xtr
	WHERE NVL(AP_USE_ALLOWED_FLAG,'N') = 'N'
	AND NVL(AR_USE_ALLOWED_FLAG,'N')   = 'N'
	AND NVL(PAY_USE_ALLOWED_FLAG,'N')  = 'N'
	AND NVL(XTR_USE_ALLOWED_FLAG,'N')  = 'Y'
	AND xtr.bank_account_id            = CeBankAccounts.bank_account_id
	))
AND CeBankAccounts.ACCOUNT_OWNER_ORG_ID = kfstr.LEGAL_ENTITY_ID (+)
ORDER BY DECODE(cebankaccounts.end_date,NULL,'Y','N') DESC
,CeBankAccounts.BANK_ACCOUNT_NAME,RES_ACCOUNT_NUMBER,RES_GL_CASH_ACCOUNT_SEGMENTS