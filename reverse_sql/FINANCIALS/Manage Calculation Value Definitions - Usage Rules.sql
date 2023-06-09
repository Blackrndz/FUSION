/* ****************************************************************************
 * $Revision: 78696 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2022-06-08 10:47:12 +0700 (Wed, 08 Jun 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Calculation%20Value%20Definitions%20-%20Usage%20Rules.sql $:
 * $Id: Manage Calculation Value Definitions - Usage Rules.sql 78696 2022-06-08 03:47:12Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=PAY_DIR_OVERRIDE_USAGES_F
 
SELECT payVALUEDEFIEO.NAME RES_NAME
,legislativesE0.NAME RES_LEGISLATIVE_DATA_GROUP
,TO_CHAR(payVALUEDEFIEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,calTYPEO.NAME RES_CALCULATION_TYPE
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES 
	WHERE LOOKUP_CODE = payALLOWOVEREO.TYPE
	AND LOOKUP_TYPE = 'PAY_DED_OVERRIDE_TYPE' 
	AND LANGUAGE = USERENV('LANG')
	AND SYSDATE BETWEEN START_DATE_ACTIVE AND NVL(END_DATE_ACTIVE ,TO_DATE('31-12-4712','DD-MM-YYYY'))
	) RES_VALUE_TYPE
,payALLOWOVEREO.PROMPT RES_DISPLAY_VALUE
,(SELECT DISPLAY_NAME 
	FROM PAY_DIR_CARD_DEFINITIONS_VL 
	WHERE DIR_CARD_DEFINITION_ID = payDIRCARDCOMPEO.DIR_CARD_DEFINITION_ID
	) RES_CALCULATION_CARD
,payDIRCARDCOMPEO.COMPONENT_NAME RES_CALCULATION_COMPONENT
,payDIROVERUSAGEO.VALUE_SET_CODE RES_VALUE_SET
,TO_CHAR(payDIROVERUSAGEO.EFFECTIVE_START_DATE,'DD-Mon-YYYY') RES_USAGE_RULES_EFFECTIVE_STAR
,DECODE(TO_CHAR(payVALUEDEFIEO.EFFECTIVE_END_DATE ,'DD-MM-YYYY'),'31-12-4712',NULL,TO_CHAR(payVALUEDEFIEO.EFFECTIVE_END_DATE ,'DD-Mon-YYYY')) RES_EFFECTIVE_END_DATE
,payDIRCARDCOMPEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,payDIRCARDCOMPEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,payDIRCARDCOMPEO.CREATED_BY RSC_CREATED_BY
,payDIRCARDCOMPEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,legislativesE0.LEGISLATION_CODE RSC_COUNTRY_ID

FROM PAY_VALUE_DEFINITIONS_VL  payVALUEDEFIEO
,PER_LEGISLATIVE_DATA_GROUPS_VL legislativesE0
,PAY_ALLOW_OVERRIDES_VL payALLOWOVEREO
,PAY_DIR_OVERRIDE_USAGES_F payDIROVERUSAGEO
,PAY_DIR_CARD_COMP_DEFS_VL payDIRCARDCOMPEO
,(SELECT CALC_TYPE_ID,NAME FROM PAY_CALC_TYPES_VL) calTYPEO
WHERE payVALUEDEFIEO.PARENT_VALUE_DEFN_ID IS NULL
AND payVALUEDEFIEO.LEGISLATIVE_DATA_GROUP_ID = legislativesE0.LEGISLATIVE_DATA_GROUP_ID
AND payVALUEDEFIEO.VALUE_DEFN_ID = payALLOWOVEREO.VALUE_DEFN_ID
AND payALLOWOVEREO.ALLOW_OVERRIDES_ID = payDIROVERUSAGEO.ALLOW_OVERRIDES_ID
AND payDIROVERUSAGEO.DIR_CARD_COMP_DEF_ID  = payDIRCARDCOMPEO.DIR_CARD_COMP_DEF_ID
AND payVALUEDEFIEO.CALC_TYPE_ID = calTYPEO.CALC_TYPE_ID
ORDER BY payVALUEDEFIEO.NAME
,legislativesE0.NAME 
,payVALUEDEFIEO.EFFECTIVE_START_DATE