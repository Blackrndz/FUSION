/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT patternsE0.PATTERN_NAME RES_NAME
,patternDetailsE0.PATTERN_DTL_SEQ_NUM RES_SEQUENCE
,(SELECT SHIFT_NAME
    FROM ZMM_SR_SHIFTS_TL
    WHERE LANGUAGE = USERENV('LANG')
    AND SHIFT_ID = patternDetailsE0.CHILD_SHIFT_ID
    ) RES_SHIFT_NAME
,patternDetailsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,patternDetailsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,patternDetailsE0.CREATED_BY RSC_CREATED_BY
,patternDetailsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_SR_PATTERNS_VL patternsE0
,ZMM_SR_PATTERN_DTLS patternDetailsE0
WHERE patternsE0.PATTERN_ID = patternDetailsE0.PATTERN_ID 
AND patternsE0.PATTERN_TYPE_CODE = 'DURATION'
ORDER BY patternsE0.PATTERN_NAME