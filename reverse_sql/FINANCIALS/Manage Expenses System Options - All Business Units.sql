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

SELECT MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_PAYMENT_METHOD'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ENABLE_PAYMENT_METHOD
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_REIMB_CURRENCY'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ALLOW_REIMBURSEMENT_CURREN
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_ATTACHMENTS'
		THEN
			(SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'EXM_ENABLE_ATTACHMENTS'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END) RES_ENABLE_ATTACHMENTS
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_OVERRIDE_APPROVER'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ALLOW_OVERRIDING_APPROVER
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_PREPAID_CASH_EXP'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ENABLE_PREPAID_CASH_EXPENS
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_TRAVEL'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ENABLE_TRAVEL
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_RECUR_EXP'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ENABLE_RECURRING_EXPENSES
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_BAR_CODE'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_DISPLAY_BAR_CODE
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_DFF'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ENABLE_DESCRIPTIVE_FLEXFIE
,MAX(
	CASE
		WHEN Setting_Code = 'REPORT_TEMPLATE'
		THEN DECODE(T.Setting_Value,'FinExmReports','Printable Expense Report Template')
	END) RES_PRINTABLE_EXPENSE_REPORT_F
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_TERMS_AGREEMENTS'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ENABLE_TERMS_AND_AGREEMENT
,MAX(
	CASE
		WHEN Setting_Code = 'TERMS_AGREEMENTS_MSG'
		THEN (SELECT MEANING 
			FROM FND_LOOKUPS
			WHERE LOOKUP_TYPE = 'ORA_EXM_TERMS_AGRMT' 
			AND LOOKUP_CODE = T.Setting_Value
			)
	END) RES_CORPORATE_POLICY
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_TA_URL'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END)  RES_ENABLE_CORPORATE_POLICY_UR
,MAX(
	CASE
		WHEN Setting_Code = 'TERMS_AGREEMENTS_URL'
		THEN T.Setting_Value
	END) RES_URL
,MAX(
	CASE
		WHEN Setting_Code = 'CC_TRX_AGE_LIMIT'
		THEN DECODE(T.Setting_Value,NULL,'No','Yes')
	END) RES_ENABLE_CORPORATE_CARD_TRAN
,MAX(
	CASE
		WHEN Setting_Code = 'CC_TRX_AGE_LIMIT'
		THEN T.Setting_Value
	END) RES_CORPORATE_CARD_TRANSACTION
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_PROJECT_FIELDS'
		THEN DECODE(T.Setting_Value,NULL,'No','Y','Yes','N','No')
	END) RES_REQUIRE_PROJECT_FIELDS_FOR
,MAX(
	CASE
		WHEN Setting_Code = 'REPORT_NUMBER_PREFIX'
		THEN T.Setting_Value
	END) RES_EXPENSE_REPORT_NUMBER_PREF
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_PMT_NOTIFICATION'
		THEN
			(SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'EXM_ENABLE_PMT_NOTIFICATION'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END) RES_ENABLE_PAYMENT_NOTIFICATIO
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_AUTO_CREATION'
		THEN DECODE(T.Setting_Value,NULL,'No','Y','Yes','N','No')
	END) RES_ENABLE_AUTOMATIC_TRAVEL_EX
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_AUDIT_APPROVAL'
		THEN
			(SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'EXM_ENABLE_AUDIT_APPROVAL'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END) RES_EXPENSE_REPORT_AUDIT_APPRO
,MAX(
	CASE
		WHEN Setting_Code = 'DAYS_ALLOWED_AFTER_TERMIN'
		THEN T.Setting_Value
	END) RES_PROCESSING_DAYS_ALLOWED_AF
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_REIMB_OPTION'
		THEN
			(SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'EXM_ENABLE_REIMB_OPTION'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END) RES_PAY_EXPENSE_REPORTS_THROUG
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
,NULL RSC_BUSINESS_UNIT_ID
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
		FROM Exm_Org_Settings
		WHERE Org_Id = - 1
		UNION
		SELECT Org_Id
		,option_Code
		,value_code
		,LAST_UPDATED_BY
		,LAST_UPDATE_DATE
		,CREATED_BY
		,CREATION_DATE
		FROM Exm_Setup_Options
		WHERE Org_Id = - 1
		)
	) T