/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Server%20Configurations%20-%20Manage%20Data%20Quality%20Server%20Configurations.sql $:
* $Id: Manage Server Configurations - Manage Data Quality Server Configurations.sql 55345 2016-05-23 05:42:33Z
wuttipong.thongvises $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- FIELD_TO_APPLY_FUNCTION=RES_CASH_ADVANCE_CLEARING_ACCO/GET_CODE_COMBINATION

SELECT Bu.bu_name RES_BUSINESS_UNIT
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_REQUEST_ADVANCES'
		THEN NVL(DECODE(T.Setting_Value,'Y','Yes','N','No',T.Setting_Value),'Use setup from all business units')
	END) RES_ENABLE_ADVANCES
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_APPLY_ADVANCES'
		THEN
			(SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'EXM_ENABLE_APPLY_ADVANCES'
			AND Lookuppeo.Lookup_Code   = T.Setting_Value
			)
	END),'Use setup from all business units') RES_METHODS_OF_APPLYING_ADVANC
,NVL(MAX(
	CASE
		WHEN Setting_Code    = 'NUMBER_OPEN_CASH_ADVANCES'
		AND T.Setting_Value IS NOT NULL
		THEN 'Define value specific to business unit'
	END),'Use setup from all business units') RES_NUMBER_OF_UNAPPLIED_ADVANC
,MAX(
	CASE
		WHEN Setting_Code    = 'NUMBER_OPEN_CASH_ADVANCES'
		AND T.Setting_Value IS NOT NULL
		THEN T.Setting_Value
	END) RES_NUMBER_OF_UNAPPLIED_ADVA_0
,NVL(MAX(
	CASE
		WHEN Setting_Code    = 'MAX_AMOUNT_ADVANCE_VALUE'
		AND T.Setting_Value IS NOT NULL
		THEN 'Define value specific to business unit'
	END),'Use setup from all business units') RES_MAXIMUM_AMOUNT_ALLOWED_PER
,MAX(
	CASE
		WHEN Setting_Code    = 'MAX_AMOUNT_ADVANCE_VALUE'
		AND T.Setting_Value IS NOT NULL
		THEN T.Setting_Value
	END) RES_MAXIMUM_AMOUNT_ALLOWED_P_1
,NVL(MAX(
	CASE
		WHEN Setting_Code    = 'MAX_AMOUNT_ADVANCE_VALUE'
		AND T.Setting_Value IS NOT NULL
		THEN 'Define value specific to business unit'
	END),'Use setup from all business units') RES_CASH_ADVANCES_PREFIX
,MAX(
	CASE
		WHEN Setting_Code = 'CASH_ADVANCE_PREFIX'
		THEN T.Setting_Value
	END) RES_CASH_ADVANCES_PREFIX_VALUE
,MAX(
	CASE
		WHEN Setting_Code = 'CASH_ADVANCE_CLEARING_ACCT'
		THEN FND_FLEX_EXT.GET_SEGS(APPLICATION_SHORT_NAME => 'GL',KEY_FLEX_CODE => 'GL#',STRUCTURE_NUMBER => (SELECT CHART_OF_ACCOUNTS_ID FROM GL_CODE_COMBINATIONS WHERE CODE_COMBINATION_ID = T.Setting_Value),COMBINATION_ID => T.Setting_Value)  
	END) RES_CASH_ADVANCE_CLEARING_ACCO
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_REQ_SPEND_AUTH'
		AND T.Setting_Value IS NOT NULL
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END),'Use setup from all business units') RES_ENABLE_AUTHORIZATIONS
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_ATT_SPEND_AUTH'
		AND T.Setting_Value IS NOT NULL
		THEN (SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'ORA_EXM_ENABLE_ATT_SPEND_AUTH'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END),'Use setup from all business units') RES_ATTACH_AUTHORIZATION
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_BEHAVIOR'
		AND T.Setting_Value IS NOT NULL
		THEN (SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'ORA_EXM_ENABLE_BEHAVIOR'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END),'Use setup from all business units') RES_BEHAVIOR
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'SPEND_AUTH_PREFIX'
		AND T.Setting_Value IS NOT NULL
		THEN 'Define value specific to business unit'
	END),'Use setup from all business units') RES_AUTHORIZATIONS_PREFIX
,MAX(
	CASE
		WHEN Setting_Code = 'SPEND_AUTH_PREFIX'
		AND T.Setting_Value IS NOT NULL 
		THEN T.Setting_Value
		END) RES_AUTHORIZATIONS_PREFIX_VALU
,NVL(MAX(
	CASE
		WHEN Setting_Code = 'VISIBILITY_DAYS'
		AND T.Setting_Value IS NOT NULL
		THEN 'Define value specific to business unit'
	END),'Use setup from all business units') RES_VISIBILITY_IN_DAYS
,MAX(
	CASE
		WHEN Setting_Code = 'VISIBILITY_DAYS'
		AND T.Setting_Value IS NOT NULL 
		THEN T.Setting_Value
		END) RES_VISIBILITY_IN_DAYS_VALUE
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
			FROM Exm_Org_Settings
			WHERE Org_Id != - 1
			UNION
			SELECT Org_Id
			,option_Code
			,value_code
			,LAST_UPDATED_BY
			,LAST_UPDATE_DATE
			,CREATED_BY
			,CREATION_DATE
			FROM Exm_Setup_Options
			WHERE Org_Id != - 1
			)
		WHERE Setting_Code IN ('ENABLE_REQUEST_ADVANCES','ENABLE_APPLY_ADVANCES','ENABLE_CARRY_FORWARD'
		,'NUMBER_OPEN_CASH_ADVANCES','NUMBER_OPEN_CASH_ADVANCES','MAX_AMOUNT_ADVANCE_VALUE'
		,'MAX_AMOUNT_ADVANCE_VALUE','CASH_ADVANCE_CLEARING_ACCT','CASH_ADVANCE_PREFIX','VISIBILITY_DAYS'
		,'SPEND_AUTH_PREFIX','ENABLE_BEHAVIOR','ORA_EXM_ENABLE_ATT_SPEND_AUTH','ENABLE_REQ_SPEND_AUTH','ENABLE_ATT_SPEND_AUTH')
	) T
,Fun_All_Business_Units_V Bu
WHERE bu.bu_id = t.org_id
GROUP BY Bu.Bu_Name,bu.bu_id
ORDER BY Bu.Bu_Name