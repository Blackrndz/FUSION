/* ****************************************************************************
* $Revision: 55390 $:
* $Author: wuttipong.thongvises $:
* $Date: 2016-05-24 15:02:08 +0700 (Tue, 24 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Server%20Configurations%20-%20Manage%20Data%20Quality%20Server%20Configurations.sql $:
* $Id: Manage Server Configurations - Manage Data Quality Server Configurations.sql 55345 2016-05-23 05:42:33Z
wuttipong.thongvises $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- FIELD_TO_APPLY_FUNCTION=RES_EMPLOYEE_LIABILITY_ACCOU_2/GET_CODE_COMBINATION
-- FIELD_TO_APPLY_FUNCTION=RES_PREPAID_EXPENSE_REVERSAL_3/GET_CODE_COMBINATION

SELECT Bu.bu_name RES_BUSINESS_UNIT
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_PAYMENT_METHOD'
		THEN
			DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_PAYMENT_METHOD
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_REIMB_CURRENCY'
		THEN
			DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ALLOW_REIMBURSEMENT_CURREN
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_ATTACHMENTS'
		THEN
			(SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'EXM_ENABLE_ATTACHMENTS'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END),'Use setup from all business units') RES_ENABLE_ATTACHMENTS
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_OVERRIDE_APPROVER'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ALLOW_OVERRIDING_APPROVER
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_PREPAID_CASH_EXP'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_PREPAID_CASH_EXPENS
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_TRAVEL'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_TRAVEL
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_RECUR_EXP'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_RECURRING_EXPENSES
	
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_SAVE_PSWD'
		THEN DECODE(T.Setting_Value,'Y','Yes','N','No')
	END),'Use setup from all business units') RES_ALLOW_PASSWORD_STORAGE_IN_

,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_BAR_CODE'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_DISPLAY_BAR_CODE
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_PROJECT_FIELDS'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_REQUIRE_PROJECT_FIELDS_FOR
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_DFF'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_DESCRIPTIVE_FLEXFIE
,'Use setup from all business units' RES_PRINTABLE_EXPENSE_REPORT_F
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_TERMS_AGREEMENTS'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_TERMS_AND_AGREEMENT
,MAX(
	CASE
		WHEN Setting_Code = 'TERMS_AGREEMENTS_MSG'
		THEN (SELECT MEANING
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'ORA_EXM_TERMS_AGRMT'
			AND LOOKUP_CODE = T.Setting_Value)
	END) RES_TERMS_AND_AGREEMENTS_URL
	
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_TA_URL'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_CORPORATE_POLICY_UR
,MAX(
	CASE
		WHEN Setting_Code = 'TERMS_AGREEMENTS_URL'
		THEN T.Setting_Value
	END) RES_CORPORATE_POLICY_URL

,NVL(MAX(
	CASE
		WHEN Setting_Code = 'CC_TRX_AGE_LIMIT'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_CORPORATE_CARD_TRAN
,MAX(
	CASE
		WHEN Setting_Code = 'CC_TRX_AGE_LIMIT'
		THEN T.Setting_Value
	END) RES_CORPORATE_CARD_TRANSACTION
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'REPORT_NUMBER_PREFIX'
		THEN 'Define value specific to business unit'
	END),'Use setup from all business units') RES_EXPENSE_REPORT_NUMBER_PREF
,MAX(
	CASE
		WHEN Setting_Code = 'REPORT_NUMBER_PREFIX'
		THEN T.Setting_Value
	END) RES_EXPENSE_REPORT_NUMBER_PR_0
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_PMT_NOTIFICATION'
		THEN 
			(SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'EXM_ENABLE_PMT_NOTIFICATION'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END),'Use setup from all business units') RES_ENABLE_PAYMENT_NOTIFICATIO
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_AUTO_CREATION'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_AUTOMATIC_TRAVEL_EX
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_AUDIT_APPROVAL'
		THEN 
			(SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'EXM_ENABLE_AUDIT_APPROVAL'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END),'Use setup from all business units') RES_EXPENSE_REPORT_AUDIT_APPRO
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'DAYS_ALLOWED_AFTER_TERMIN'
		THEN 'Define value specific to business unit'
	END),'Use setup from all business units') RES_PROCESSING_DAYS_ALLOWED_AF
,MAX(
	CASE
		WHEN Setting_Code = 'DAYS_ALLOWED_AFTER_TERMIN'
		THEN T.Setting_Value
	END) RES_PROCESSING_DAYS_ALLOWED__1
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'EMPLOYEE_LIABILITY_ACCT'
		THEN 'Define value specific to business unit'
	END),'Use setup from Oracle Fusion Payables') RES_EMPLOYEE_LIABILITY_ACCOUNT
,MAX(
	CASE
		WHEN Setting_Code = 'EMPLOYEE_LIABILITY_ACCT'
		THEN T.Setting_Value
	END) RES_EMPLOYEE_LIABILITY_ACCOU_2
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'PREPAID_EXPENSE_REVERSAL_ACCT'
		THEN 'Define value specific to business unit'
	END),'Use employee''s default expense account') RES_PREPAID_EXPENSE_REVERSAL_A
,MAX(
	CASE
		WHEN Setting_Code = 'PREPAID_EXPENSE_REVERSAL_ACCT'
		THEN T.Setting_Value
	END) RES_PREPAID_EXPENSE_REVERSAL_3
,MAX(CASE
	WHEN ROWX = 1 THEN
		T.LAST_UPDATED_BY
	END) RSC_LAST_UPDATED_BY
,MAX(CASE
	WHEN ROWX = 1 THEN
		T.LAST_UPDATE_DATE
	END) RSC_LAST_UPDATE_DATE
,MAX(CASE
	WHEN ROWX = 1 THEN
		T.CREATED_BY
	END) RSC_CREATED_BY
,MAX(CASE
	WHEN ROWX = 1 THEN
		T.CREATION_DATE
	END) RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,bu.bu_id RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM
	(SELECT Org_Id
		,Setting_Code
		,Setting_Value
		,LAST_UPDATED_BY
		,LAST_UPDATE_DATE
		,CREATED_BY
		,CREATION_DATE
		,ROW_NUMBER() OVER(PARTITION BY Org_Id ORDER BY LAST_UPDATE_DATE DESC) ROWX
		FROM (SELECT Org_Id
			,Setting_Code
			,Setting_Value
			,LAST_UPDATED_BY
			,LAST_UPDATE_DATE
			,CREATED_BY
			,CREATION_DATE
			FROM Exm_Org_Settings x
			WHERE Org_Id != - 1
			
			UNION
			
			SELECT Org_Id
			,option_Code
			,value_code
			,LAST_UPDATED_BY
			,LAST_UPDATE_DATE
			,CREATED_BY
			,CREATION_DATE
			FROM Exm_Setup_Options x
			WHERE Org_Id != - 1
		)
		WHERE Setting_Code IN ('ENABLE_PAYMENT_METHOD','ENABLE_REIMB_CURRENCY','ENABLE_ATTACHMENTS','ENABLE_OVERRIDE_APPROVER','ENABLE_PREPAID_CASH_EXP'
			,'ENABLE_TRAVEL','ENABLE_RECUR_EXP','ENABLE_SAVE_PSWD','ENABLE_BAR_CODE','ENABLE_PROJECT_FIELDS'
			,'ENABLE_DFF','ENABLE_TERMS_AGREEMENTS','TERMS_AGREEMENTS_MSG','ENABLE_TA_URL','TERMS_AGREEMENTS_URL'
			,'CC_TRX_AGE_LIMIT','REPORT_NUMBER_PREFIX','ENABLE_PMT_NOTIFICATION'
			,'ENABLE_AUTO_CREATION','ENABLE_AUDIT_APPROVAL','DAYS_ALLOWED_AFTER_TERMIN'
			,'EMPLOYEE_LIABILITY_ACCT','PREPAID_EXPENSE_REVERSAL_ACCT')
	) T
,Fun_All_Business_Units_V Bu
WHERE bu.bu_id = t.org_id
GROUP BY Bu.Bu_Name,bu.bu_id
ORDER BY Bu.Bu_Name