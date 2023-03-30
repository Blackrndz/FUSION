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

SELECT MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_REQUEST_ADVANCES'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ENABLE_ADVANCES
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_APPLY_ADVANCES'
		THEN
			(SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'EXM_ENABLE_APPLY_ADVANCES'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END) RES_METHODS_OF_APPLYING_ADVANC
,MAX(
	CASE
		WHEN Setting_Code = 'NUMBER_OPEN_CASH_ADVANCES'
		THEN t.setting_value
	END) RES_NUMBER_OF_UNAPPLIED_ADVANC
,MAX(
	CASE
		WHEN Setting_Code = 'MAX_AMOUNT_ADVANCE_CURRENCY'
		THEN
			(SELECT CURRENCY_CODE ||' - '||CurrencyPEO.NAME
			FROM Fnd_Currencies_Vl Currencypeo
			WHERE Currencypeo.CURRENCY_CODE = T.Setting_Value
			)
	END) RES_MAXIMUM_AMOUNT_ALLOWED_PER
,MAX(
	CASE
		WHEN Setting_Code = 'MAX_AMOUNT_ADVANCE_VALUE'
		THEN T.Setting_Value
	END) RES_MAXIMUM_AMOUNT_ALLOWED_P_0
,MAX(
	CASE
		WHEN Setting_Code = 'CASH_ADVANCE_PREFIX'
		THEN T.Setting_Value
	END) RES_CASH_ADVANCES_PREFIX
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_REQ_SPEND_AUTH'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_ENABLE_AUTHORIZATIONS
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_ATT_SPEND_AUTH'
		THEN (SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'ORA_EXM_ENABLE_ATT_SPEND_AUTH'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END) RES_ATTACH_AUTHORIZATION
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_BEHAVIOR'
		THEN (SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'ORA_EXM_ENABLE_BEHAVIOR'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END) RES_BEHAVIOR
,MAX(
	CASE
		WHEN Setting_Code = 'SPEND_AUTH_PREFIX'
		THEN T.Setting_Value 
	END) RES_AUTHORIZATIONS_PREFIX
,MAX(
	CASE
		WHEN Setting_Code = 'VISIBILITY_DAYS'
		THEN TO_CHAR(T.Setting_Value,'9,999.99')
	END) RES_VISIBILITY_IN_DAYS
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_FUNDS_APPL'
		THEN (SELECT meaning
			FROM Fnd_Lookups Lookuppeo
			WHERE Lookuppeo.Lookup_Type = 'ORA_EXM_ENABLE_FUNDS_APPL'
			AND Lookuppeo.LOOKUP_CODE   = t.Setting_Value
			)
	END) RES_FUNDS_APPLICATION
,MAX(
	CASE
		WHEN Setting_Code = 'ENABLE_DISP_WARN_USER'
		THEN DECODE(T.Setting_Value,'Y','Yes','No')
	END) RES_DISPLAY_WARNING_TO_USER
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