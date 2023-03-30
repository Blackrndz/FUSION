/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Elements%20-%20Absences.sql $:
 * $Id: Manage Elements - Absences.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT legislativeDataGrpsE0.NAME RES_LEGISLATIVE_DATA_GROUP
,prClassesE0.CLASSIFICATION_NAME RES_PRIMARY_CLASSIFICATION
,(SELECT CLASSIFICATION_NAME
    FROM PAY_ELE_CLASSIFICATIONS_VL
    WHERE BASE_CLASSIFICATION_ID = elementsE0.SECONDARY_CLASSIFICATION_ID
	AND LEGISLATION_CODE = legislativeDataGrpsE0.LEGISLATION_CODE
    ) RES_SECONDARY_CLASSIFICATION		
,(CASE
	WHEN EXISTS (SELECT 1 
			FROM PAY_DIR_CARD_COMP_DEFS_F cardComp
			,PAY_DIR_CARD_DEFINITIONS cardDef
			WHERE cardComp.DIR_CARD_DEFINITION_ID = cardDef.DIR_CARD_DEFINITION_ID
			AND cardDef.BASE_DISPLAY_NAME = 'Time Cards'
			AND cardComp.ELEMENT_TYPE_ID = elementsFE0.ELEMENT_TYPE_ID
			AND elementsFE0.EFFECTIVE_END_DATE BETWEEN cardComp.EFFECTIVE_START_DATE AND cardComp.EFFECTIVE_END_DATE) THEN 
		'Time Card'
	ELSE
		'Absence'
	END) RES_CATEGORY
,elementsE0.ELEMENT_NAME RES_ELEMENT_NAME
,elementsE0.REPORTING_NAME RES_REPORTING_NAME
,elementsE0.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(elementsE0.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_DATE
,(SELECT NAME
    FROM FND_CURRENCIES_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND CURRENCY_CODE = elementsE0.INPUT_CURRENCY_CODE
    ) RES_INPUT_CURRENCY	


,H_D.H_D RES_WHAT_CALCULATION_UNITS_ARE		-- What calculation units are used for reporting?
,DECODE(rateCalsE0.VALUE1,'ANNUALIZED RATE CONVERSION','Standard Rate Annualized'
	,'DAILY RATE CONVERSION','Standard Rate Daily'
	,'ORA_ANNUAL_STD_WORK_HOURS','Standard Working Hours Rate Annualized'
	,'ORA_ANNUAL_WORK_HOURS','Assignment Working Hours Rate Annualized'
	,'ORA_PERIOD_WORK_SCHED_RATE','Periodic Work Schedule Rate Annualized'
	) RES_WORK_UNITS_CONVERSION_RULE 	-- Work Units Conversion Rule
,'Accrual Balances and Absences' RES_WHAT_TYPE_OF_ABSENCE_INFOR		-- What type of absence information do you want transferred to payroll?


,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'MX' THEN
		'Statutory' 
	END) RES_ISR_TAXABILITY_RULE_APPLIC -- ISR taxability rule applicable to this element?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'MX' THEN
		'Statutory' 
	END) RES_STATE_TAXABILITY_RULE_APPL -- State taxability rule applicable to this element?


,(CASE
	WHEN rateCalsE3.VALUE1 IS NULL THEN
		'Reduce regular earnings by absence payment'
	ELSE
		'Select rate to determine absence deduction amount'
	END) RES_HOW_DO_YOU_WANT_TO_REDUCE_		-- How do you want to reduce earnings for employees not requiring a time card?
,(SELECT NAME
	FROM PAY_RATE_DEFINITIONS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND RATE_DEFINITION_ID = rateCalsE3.VALUE1
	) RES_RATE_TO_DETERMINE_ABSENCE_		-- Rate to Determine Absence Deduction Amount


,'' RES_WHICH_RATE_SHOULD_THE_NORM -- Which rate should the normal earnings calculation the employee is no longer entitled to use?


,(SELECT NAME
	FROM PAY_RATE_DEFINITIONS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND RATE_DEFINITION_ID = rateCalsE1.VALUE1
	) RES_WHICH_RATE_SHOULD_THE_ABSE		-- Which rate should the absence payment calculation use?


,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'MX' THEN
		'Yes' 
	END) RES_DOES_THIS_ELEMENT_RESULT_R		-- Does this element result reduces the ISR subject basis?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'MX' THEN
		'Yes' 
	END) RES_DOES_THIS_ELEMENT_RESULT_0		-- Does this element result reduces the state subject basis?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'US' THEN
		'No'
	END) RES_HOW_DO_YOU_WANT_ABSENCE_PA		-- How do you want Absence Payment to be taxed?
,'' RES_ABSENCE_PAYMENT_PROCESS_MO		-- Absence Payment Process Mode
,'No' RES_DOES_THIS_PLAN_ENABLE_ENTI		-- Does this plan enable entitlement payments after termination?


,(CASE
	WHEN EXISTS (SELECT 1
		FROM PAY_ELEMENT_TYPES_F esE0
		,PAY_BALANCE_FEEDS_F feedsE0
		,PAY_BALANCE_TYPES_VL balancesE0
		WHERE esE0.ELEMENT_TYPE_ID = feedsE0.ELEMENT_TYPE_ID
		AND feedsE0.BALANCE_TYPE_ID = balancesE0.BALANCE_TYPE_ID
		AND balancesE0.BALANCE_NAME  LIKE '%Liability'
		AND esE0.DEDUCTION_TYPE_ID = elementsE0.DEDUCTION_TYPE_ID) THEN
		'Yes'
	ELSE
		'No'
	END) RES_CALCULATE_ABSENCE_LIABILIT		-- Calculate absence liability?
,(SELECT NAME
	FROM PAY_RATE_DEFINITIONS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND RATE_DEFINITION_ID = rateCalsE2.VALUE1
	) RES_WHICH_RATE_SHOULD_THE_LIAB		-- Which rate should the liability balance calculation use?


,(CASE
	WHEN rateCalsE4.VALUE1 IS NOT NULL THEN
		'Yes'
	ELSE
		'No'
	END) RES_DOES_THIS_PLAN_ENABLE_BALA		-- Does this plan enable balance payments when enrollment ends?
,(SELECT NAME
	FROM PAY_RATE_DEFINITIONS_F_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE
	AND RATE_DEFINITION_ID = rateCalsE4.VALUE1
	) RES_WHICH_RATE_SHOULD_THE_FINA		-- Which rate should the final balance payment calculation use?
	
,'No' RES_DOES_THIS_PLAN_ENABLE_PART		-- Does this plan enable partial payment of balance?
,'' RES_WHICH_RATE_SHOULD_THE_DISC		-- Which rate should the discretionary disbursement calculation use?
,'' RES_WHAT_TYPE_OF_TAXATION_APPL		-- What type of taxation applies to balance payments when enrollment ends?
,'' RES_WHAT_TYPE_OF_TAXATION_AP_1		-- What type of taxation applies to partial payment of balances?
,'' RES_IF_THE_PARTIAL_PAYMENT_ELE		-- If the partial payment element is insurable, how are the earnings allocated?
,'' RES_ARE_THERE_INSURABLE_HOURS_		-- Are there insurable hours associated with the partial payment element?
,'' RES_IF_THE_FINAL_PAYMENT_ELEME		-- If the final payment element is insurable, how are the earnings allocated?
,'' RES_ARE_THERE_INSURABLE_HOUR_2		-- Are there insurable hours associated with the final payment element?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'CA' THEN
		'Regular' 
	END) RES_WHAT_TYPE_OF_TAXATION_AP_3		-- What type of taxation applies to this element?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'CA' THEN
		'Date earned' 
	END) RES_IF_THIS_ELEMENT_IS_INSURAB		-- If this element is insurable, how are the earnings allocated?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'CA' THEN
		'No' 
	END) RES_ARE_THERE_INSURABLE_HOUR_4		-- Are there insurable hours associated with this element?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'CA' THEN
		'No' 
	END) RES_SHOULD_THIS_ELEMENT_CREATE		-- Should this element create a ROE event notification?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'MX' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE LIKE 'ORA_HRX_MX_CFDI_FOR%'
			AND LOOKUP_CODE = extraE0.EEI_INFORMATION1) --'002 - ISR Tax' 
	END) RES_WHAT_IS_THE_CFDI_CODE_WHEN		-- What is the CFDI Code when this element result is positive?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'MX' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE LIKE 'ORA_HRX_MX_CFDI_FOR%'
			AND LOOKUP_CODE = extraE0.EEI_INFORMATION2) --'050 - Travel expenses' 
	END) RES_WHAT_IS_THE_CFDI_CODE_WH_5		-- What is the CFDI Code when this element result is negative?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'GB' THEN
		'Occupational maternity' 
	END) RES_WHAT_IS_THE_ABSENCE_TYPE_F		-- What is the absence type for this absence payment? 
,'' RES_HOW_DO_YOU_WANT_PAYOUT_AMO		-- How do you want Payout Amount to be taxed?
,'' RES_ABSENCE_PAYOUT_PROCESS_MOD		-- Absence Payout Process Mode
,'' RES_HOW_DO_YOU_WANT_CASH_OUT_A		-- How do you want Cash out amount to be taxed?
,'' RES_ABSENCE_CASH_OUT_PROCESS_M		-- Absence Cash out Process Mode
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'US' THEN
		'No' 
	END) RES_SHOULD_THIS_ELEMENT_BE_INC		-- Should this element be included in the earnings calculation of the FLSA overtime base rate?
,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'US' THEN
		'No'
	END) RES_SHOULD_THIS_ELEMENT_BE_I_6		-- Should this element be included in the hours calculation of the FLSA overtime base rate?


,(CASE
	WHEN legislativeDataGrpsE0.LEGISLATION_CODE = 'US' THEN
		'No' 
	END) RES_SHOULD_THIS_ELEMENT_BE_I_7 -- Should this element be included in the earnings calculation of the overtime base rate?


	



,elementsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,elementsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,elementsE0.CREATED_BY RSC_CREATED_BY
,elementsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,legislativeDataGrpsE0.LEGISLATION_CODE RSC_COUNTRY_ID

--,elementsE0.DEDUCTION_TYPE_ID
--,elementsE0.ELEMENT_TYPE_ID


FROM PAY_ELEMENT_TYPES_VL elementsE0
,PAY_ELEMENT_TYPES_F elementsFE0
,(SELECT NAME
    ,LEGISLATIVE_DATA_GROUP_ID
	,LEGISLATION_CODE
    FROM PER_LEGISLATIVE_DATA_GROUPS_VL
    ) legislativeDataGrpsE0
,PAY_ELE_CLASSIFICATIONS_VL prClassesE0


,(SELECT DISTINCT esE0.DEDUCTION_TYPE_ID
	,DECODE(balancesE0.BALANCE_UOM,'ND','Days','H_DECIMAL3','Hours',balancesE0.BALANCE_UOM) H_D
	FROM PAY_ELEMENT_TYPES_F esE0
	,PAY_BALANCE_FEEDS_F feedsE0
	,PAY_BALANCE_TYPES_VL balancesE0
	,PAY_BALANCE_CATEGORIES_F blCatsE0
	WHERE esE0.ELEMENT_TYPE_ID = feedsE0.ELEMENT_TYPE_ID
	AND feedsE0.BALANCE_TYPE_ID = balancesE0.BALANCE_TYPE_ID
	AND balancesE0.BALANCE_CATEGORY_ID = blCatsE0.BALANCE_CATEGORY_ID
	AND blCatsE0.BASE_CATEGORY_NAME IN ('ORA_ABSENCE_ACCRUALS','ORA_DAYS','Hours')
	) H_D
,(SELECT DISTINCT esE0.DEDUCTION_TYPE_ID 
	,valsE0.VALUE1
	FROM PAY_ELEMENT_TYPES_F esE0
	,PAY_CALCULATION_UNITS_F calunitsE0
	,PAY_RANGE_ITEMS_F valsE0
	WHERE esE0.ELEMENT_TYPE_ID = calunitsE0.ELEMENT_TYPE_ID
	AND calunitsE0.VALUE_DEFN_ID = valsE0.VALUE_DEFN_ID
	AND calunitsE0.CALC_PART_ID = (SELECT CALC_PART_ID
		FROM PAY_CALC_PARTS_F
		WHERE BASE_PART_NAME = 'ORA_RATE_FORMULA')
		) rateCalsE0
,(SELECT DISTINCT esE0.DEDUCTION_TYPE_ID 
	,valsE0.VALUE1
	FROM PAY_ELEMENT_TYPES_F esE0
	,PAY_CALCULATION_UNITS_F calunitsE0
	,PAY_RANGE_ITEMS_F valsE0
	WHERE esE0.ELEMENT_TYPE_ID = calunitsE0.ELEMENT_TYPE_ID
	AND calunitsE0.VALUE_DEFN_ID = valsE0.VALUE_DEFN_ID
	AND calunitsE0.CALC_PART_ID = (SELECT CALC_PART_ID
		FROM PAY_CALC_PARTS_F
		WHERE BASE_PART_NAME = 'ORA_ENTITLEMENT_RATE')
		) rateCalsE1
,(SELECT DISTINCT esE0.DEDUCTION_TYPE_ID 
	,valsE0.VALUE1
	FROM PAY_ELEMENT_TYPES_F esE0
	,PAY_CALCULATION_UNITS_F calunitsE0
	,PAY_RANGE_ITEMS_F valsE0
	WHERE esE0.ELEMENT_TYPE_ID = calunitsE0.ELEMENT_TYPE_ID
	AND calunitsE0.VALUE_DEFN_ID = valsE0.VALUE_DEFN_ID
	AND calunitsE0.CALC_PART_ID = (SELECT CALC_PART_ID
		FROM PAY_CALC_PARTS_F
		WHERE BASE_PART_NAME = 'ORA_BOOKED_LIABILITY_RATE')
		) rateCalsE2
,(SELECT DISTINCT esE0.DEDUCTION_TYPE_ID 
	,valsE0.VALUE1
	FROM PAY_ELEMENT_TYPES_F esE0
	,PAY_CALCULATION_UNITS_F calunitsE0
	,PAY_RANGE_ITEMS_F valsE0
	WHERE esE0.ELEMENT_TYPE_ID = calunitsE0.ELEMENT_TYPE_ID
	AND calunitsE0.VALUE_DEFN_ID = valsE0.VALUE_DEFN_ID
	AND calunitsE0.CALC_PART_ID = (SELECT CALC_PART_ID
		FROM PAY_CALC_PARTS_F
		WHERE BASE_PART_NAME = 'ORA_DED_AMOUNT_RATE')
		) rateCalsE3
,(SELECT DISTINCT esE0.DEDUCTION_TYPE_ID 
	,valsE0.VALUE1
	FROM PAY_ELEMENT_TYPES_F esE0
	,PAY_CALCULATION_UNITS_F calunitsE0
	,PAY_RANGE_ITEMS_F valsE0
	WHERE esE0.ELEMENT_TYPE_ID = calunitsE0.ELEMENT_TYPE_ID
	AND calunitsE0.VALUE_DEFN_ID = valsE0.VALUE_DEFN_ID
	AND calunitsE0.CALC_PART_ID = (SELECT CALC_PART_ID
		FROM PAY_CALC_PARTS_F
		WHERE BASE_PART_NAME = 'ORA_DISCRETIONARY_DISBURSEMENT_RATE')
		) rateCalsE4
,(SELECT et.DEDUCTION_TYPE_ID
	,(SELECT COUNT(*) CNT 
		FROM PAY_ELEMENT_TYPES_F 
		WHERE DEDUCTION_TYPE_ID = et.DEDUCTION_TYPE_ID
		AND BASE_ELEMENT_NAME LIKE '%Accrual%'
		) ACCR
	,(SELECT COUNT(*) CNT 
		FROM PAY_ELEMENT_TYPES_F 
		WHERE DEDUCTION_TYPE_ID = et.DEDUCTION_TYPE_ID
		AND BASE_ELEMENT_NAME LIKE '%Entitlement%'
		) ENTM
	FROM PAY_ELEMENT_TYPES_F et
	GROUP BY et.DEDUCTION_TYPE_ID
	) ABS_TYPE_TO_PAYROLL
,(SELECT ELEMENT_TYPE_ID
	,EEI_INFORMATION1
	,EEI_INFORMATION2
	FROM PAY_ELE_TYPE_EXTRA_INFO
	WHERE INFORMATION_TYPE = 'ORA_HRX_MX_CFDI_PAYSLIP_CODE'
	) extraE0
WHERE elementsE0.LEGISLATIVE_DATA_GROUP_ID = legislativeDataGrpsE0.LEGISLATIVE_DATA_GROUP_ID

AND elementsE0.CLASSIFICATION_ID = prClassesE0.BASE_CLASSIFICATION_ID
AND legislativeDataGrpsE0.LEGISLATION_CODE = prClassesE0.LEGISLATION_CODE

AND prClassesE0.CLASSIFICATION_NAME = 'Absences'

AND elementsE0.ELEMENT_TYPE_ID = elementsFE0.ELEMENT_TYPE_ID 
AND elementsE0.EFFECTIVE_START_DATE = elementsFE0.EFFECTIVE_START_DATE


AND elementsE0.DEDUCTION_TYPE_ID = H_D.DEDUCTION_TYPE_ID(+)
AND elementsE0.DEDUCTION_TYPE_ID = rateCalsE0.DEDUCTION_TYPE_ID(+)
AND elementsE0.DEDUCTION_TYPE_ID = rateCalsE1.DEDUCTION_TYPE_ID(+)
AND elementsE0.DEDUCTION_TYPE_ID = rateCalsE2.DEDUCTION_TYPE_ID(+)
AND elementsE0.DEDUCTION_TYPE_ID = rateCalsE3.DEDUCTION_TYPE_ID(+)
AND elementsE0.DEDUCTION_TYPE_ID = rateCalsE4.DEDUCTION_TYPE_ID(+)
AND elementsE0.DEDUCTION_TYPE_ID = ABS_TYPE_TO_PAYROLL.DEDUCTION_TYPE_ID(+)
AND elementsE0.ELEMENT_TYPE_ID = extraE0.ELEMENT_TYPE_ID(+)


/*AND (elementsE0.ELEMENT_NAME NOT LIKE '%Accrual%'
	AND elementsE0.ELEMENT_NAME NOT LIKE '%Calculator%'
	AND elementsE0.ELEMENT_NAME NOT LIKE '%Entitlement%'
	AND elementsE0.ELEMENT_NAME NOT LIKE '%Discretionary%'
	AND elementsE0.ELEMENT_NAME NOT LIKE '%Disbursement%'
	AND elementsE0.ELEMENT_NAME NOT LIKE '%Overtime Only%')*/

ORDER BY elementsE0.ELEMENT_NAME