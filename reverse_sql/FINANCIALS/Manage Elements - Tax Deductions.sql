/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Elements%20-%20Tax%20Deductions.sql $:
 * $Id: Manage Elements - Tax Deductions.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT legislativeDataGrpsE0.NAME RES_LEGISLATIVE_DATA_GROUP
,prClassesE0.CLASSIFICATION_NAME RES_PRIMARY_CLASSIFICATION
,(SELECT CLASSIFICATION_NAME
    FROM PAY_ELE_CLASSIFICATIONS_VL
    WHERE CLASSIFICATION_ID = elementsE0.SECONDARY_CLASSIFICATION_ID
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
		'Standard'
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

,DECODE(elementsE0.STANDARD_LINK_FLAG ,'Y','Yes','N','No') RES_SHOULD_EVERY_PERSON_ELIGIB 	-- Should every person eligible for the element automatically receive it?
,(SELECT DEFINITION_NAME
	FROM PAY_TIME_DEFINITIONS
	WHERE TIME_DEFINITION_ID = elementsE0.STARTING_TIME_DEF_ID
	) RES_WHAT_IS_THE_EARLIEST_ENTRY 	-- What is the earliest entry date for this element?
,(SELECT DEFINITION_NAME
	FROM PAY_TIME_DEFINITIONS
	WHERE TIME_DEFINITION_ID = elementsE0.ENDING_TIME_DEF_ID
	) RES_WHAT_IS_THE_LATEST_ENTRY_D 	-- What is the latest entry date for this element?
,(CASE
	WHEN elementsE0.USE_AT_REL_LEVEL = 'Y' THEN
		'Payroll relationship level'
	WHEN elementsE0.USE_AT_TERM_LEVEL = 'Y' THEN
		'Term Level'
	WHEN elementsE0.USE_AT_ASG_LEVEL = 'Y' THEN
		'Assignment level'
    END) RES_AT_WHICH_EMPLOYMENT_LEVEL_ 	-- At which employment level should this element be attached?
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'PAY_PROCESSING_TYPE'
	AND LOOKUP_CODE = elementsE0.PROCESSING_TYPE
    ) RES_DOES_THIS_ELEMENT_RECUR_EA 	-- Does this element recur each payroll period, or does it require explicit entry?
,DECODE(elementsE0.MULTIPLE_ENTRIES_ALLOWED_FLAG ,'Y','Yes','N','No') RES_CAN_A_PERSON_HAVE_MORE_THA 	-- Can a person have more than one entry of this element in a payroll period?

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


FROM PAY_ELEMENT_TYPES_VL elementsE0
,PAY_ELEMENT_TYPES_F elementsFE0
,(SELECT NAME
    ,LEGISLATIVE_DATA_GROUP_ID
	,LEGISLATION_CODE
    FROM PER_LEGISLATIVE_DATA_GROUPS_VL
    ) legislativeDataGrpsE0
,PAY_ELE_CLASSIFICATIONS_VL prClassesE0
WHERE elementsE0.LEGISLATIVE_DATA_GROUP_ID = legislativeDataGrpsE0.LEGISLATIVE_DATA_GROUP_ID

AND elementsE0.CLASSIFICATION_ID = prClassesE0.BASE_CLASSIFICATION_ID
AND legislativeDataGrpsE0.LEGISLATION_CODE = prClassesE0.LEGISLATION_CODE

AND prClassesE0.CLASSIFICATION_NAME = 'Tax Deductions'

AND elementsE0.ELEMENT_TYPE_ID = elementsFE0.ELEMENT_TYPE_ID 
AND elementsE0.EFFECTIVE_START_DATE = elementsFE0.EFFECTIVE_START_DATE

ORDER BY elementsE0.ELEMENT_NAME